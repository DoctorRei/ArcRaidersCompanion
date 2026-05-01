//
//  NetworkManager.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import Moya
import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError(Error)
    case serverError(Int)
    case moyaError(MoyaError)
}

final class NetworkManager {
    typealias ItemsResponse = Model.Response.ItemsResponse
    typealias Item = Model.DataModels.ItemsData.Item
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private let provider = MoyaProvider<MetaForgeService>(plugins: [NetworkLoggerPlugin()])
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchEvents() async throws -> [Model.Event] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.events) { result in
                switch result {
                case .success(let data):
                    do {
                        let scheduleResponse = try self.decoder.decode(Model.EventScheduleResponse.self, from: data.data)
                        continuation.resume(returning: scheduleResponse.data)
                    } catch {
                        continuation.resume(throwing: NetworkError.decodingError(error))
                    }
                case .failure(let error):
                    continuation.resume(throwing: NetworkError.moyaError(error))
                }
            }
        }
    }
    
    func fetchArcs() async throws -> [Model.DataModels.ArcsData.ARCEnemy] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.arcs) { result in
                switch result {
                case .success(let data):
                    do {
                        let scheduleResponse = try self.decoder.decode(Model.Response.ArcsRespone.self, from: data.data)
                        continuation.resume(returning: scheduleResponse.data)
                    } catch {
                        continuation.resume(throwing: NetworkError.decodingError(error))
                    }
                case .failure(let error):
                    continuation.resume(throwing: NetworkError.moyaError(error))
                }
            }
        }
    }
    
    func fetchItems() async throws -> [Item] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.arcs) { result in
                switch result {
                case .success(let data):
                    do {
                        let scheduleResponse = try self.decoder.decode(Model.Response.ItemsResponse.self, from: data.data)
                        continuation.resume(returning: scheduleResponse.data)
                    } catch {
                        continuation.resume(throwing: NetworkError.decodingError(error))
                    }
                case .failure(let error):
                    continuation.resume(throwing: NetworkError.moyaError(error))
                }
            }
        }
    }
    
    func fetchItems(
        page: Int = 1,
        limit: Int = 200,
        search: String? = nil,
        itemType: ItemType? = nil,
        rarity: Rarity? = nil,
        loadoutSlot: LoadoutSlot? = nil,
        workbench: String? = nil,
        subcategory: String? = nil,
        shieldType: String? = nil,
        sortBy: SortField = .name,
        sortOrder: SortOrder = .asc,
        minimal: Bool = false,
        includeComponents: Bool = false
    ) async throws -> ItemsResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.items(
                page: page,
                limit: limit,
                id: nil,
                itemType: itemType?.rawValue,
                rarity: rarity?.rawValue,
                search: search,
                loadoutSlot: loadoutSlot?.rawValue,
                workbench: workbench,
                subcategory: subcategory,
                shieldType: shieldType,
                includeComponents: includeComponents,
                sortBy: sortBy,
                sortOrder: sortOrder,
                minimal: minimal
            )) { result in
                switch result {
                case .success(let response):
                    do {
                        let itemsResponse = try self.decoder.decode(ItemsResponse.self, from: response.data)
                        continuation.resume(returning: itemsResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Получение конкретного предмета по ID
    func fetchItem(
        id: String,
        includeComponents: Bool = false
    ) async throws -> Item {
        let response: ItemsResponse = try await withCheckedThrowingContinuation { continuation in
            provider.request(.items(
                page: nil,
                limit: nil,
                id: id,
                itemType: nil,
                rarity: nil,
                search: nil,
                loadoutSlot: nil,
                workbench: nil,
                subcategory: nil,
                shieldType: nil,
                includeComponents: includeComponents,
                sortBy: nil,
                sortOrder: nil,
                minimal: false
            )) { result in
                switch result {
                case .success(let response):
                    do {
                        let itemsResponse = try self.decoder.decode(ItemsResponse.self, from: response.data)
                        continuation.resume(returning: itemsResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
        guard let item = response.data.first else {
            throw NSError(domain: "ArcRaidersService", code: 404,
                          userInfo: [NSLocalizedDescriptionKey: "Item with id '\(id)' not found"])
        }
        
        return item
    }
    
    func fetchAllItems(
        search: String? = nil,
        itemType: ItemType? = nil,
        rarity: Rarity? = nil,
        limit: Int = 50,
        progress: ((Int, Int) -> Void)? = nil
    ) async throws -> [Item] {
        var allItems: [Item] = []
        var currentPage = 1
        var hasMorePages = true
        
        while hasMorePages {
            let response = try await fetchItems(
                page: currentPage,
                limit: limit,
                search: search,
                itemType: itemType,
                rarity: rarity
            )
            
            allItems.append(contentsOf: response.data)
            if let pagination = response.pagination?.hasNextPage {
                hasMorePages = pagination
            }
            currentPage += 1
            
            if let total = response.pagination?.total {
                await MainActor.run {
                    progress?(allItems.count, total)
                }
            }
        }
        
        return allItems
    }
}
