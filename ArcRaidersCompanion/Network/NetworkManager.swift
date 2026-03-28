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
    static let shared = NetworkManager()
    
    private init() {}
    
    private let provider = MoyaProvider<MetaForgeService>()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchEvents() async throws -> [Event] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.events) { result in
                switch result {
                case .success(let data):
                    do {
                        let scheduleResponse = try self.decoder.decode(EventScheduleResponse.self, from: data.data)
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
}
