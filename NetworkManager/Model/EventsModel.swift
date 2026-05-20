//
//  EventsModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import Foundation

extension NetworkLayer.Model.Event {
    public enum EventStatus {
        case active
        case upcoming
        case finished
    }
    
    public var status: EventStatus {
        if isActive { return .active }
        if isUpcoming { return .upcoming }
        return .finished
    }
}

extension NetworkLayer.Model {
    struct EventScheduleResponse: Decodable {
        let data: [Event]
        let cachedAt: Int64
        
        // Вычисляемое свойство для преобразования cachedAt в Date
        var cachedAtDate: Date {
            return Date(timeIntervalSince1970: TimeInterval(cachedAt) / 1000)
        }
    }
    
    // MARK: - Модель события
    public struct Event: Decodable, Identifiable {
        public let name: String
        public let map: String
        public let icon: String
        public let startTime: Int64
        public let endTime: Int64
        
        // Используем комбинацию name, map и startTime как уникальный идентификатор
        public var id: String {
            return "\(name)-\(map)-\(startTime)"
        }
        
        // Вычисляемые свойства для удобной работы с датами
        var startDate: Date {
            return Date(timeIntervalSince1970: TimeInterval(startTime) / 1000)
        }
        
        var endDate: Date {
            return Date(timeIntervalSince1970: TimeInterval(endTime) / 1000)
        }
        
        // Длительность события в секундах
        var duration: TimeInterval {
            return endDate.timeIntervalSince(startDate)
        }
        
        // Форматированное время начала
        public var formattedStartTime: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone.current
            return formatter.string(from: startDate)
        }
        
        // Форматированное время окончания
        public var formattedEndTime: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone.current
            return formatter.string(from: endDate)
        }
        
        // Форматированная дата и время
        public var formattedDateTime: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            formatter.timeZone = TimeZone.current
            return formatter.string(from: startDate)
        }
        
        // Проверка, активно ли событие сейчас
        public var isActive: Bool {
            let now = Date()
            return now >= startDate && now <= endDate
        }
        
        // Проверка, будет ли событие в будущем
        var isUpcoming: Bool {
            return Date() < startDate
        }
        
        // Проверка, завершено ли событие
        var isFinished: Bool {
            return Date() > endDate
        }
        
        // Прогресс события в процентах (0-1)
        var progress: Double {
            let now = Date()
            guard now >= startDate && now <= endDate else { return 0 }
            let totalDuration = endDate.timeIntervalSince(startDate)
            let elapsed = now.timeIntervalSince(startDate)
            return min(max(elapsed / totalDuration, 0), 1)
        }
        
        // Оставшееся время в секундах
        var timeRemaining: TimeInterval? {
            guard now < endDate else { return nil }
            return endDate.timeIntervalSince(now)
        }
        
        private var now: Date { Date() }
    }
}

// MARK: - Расширение для фильтрации и сортировки
extension Array where Element == NetworkLayer.Model.Event {
    typealias Event = NetworkLayer.Model.Event

    var active: [Event] {
        return filter { $0.isActive }.sorted { $0.startDate < $1.startDate }
    }
    
    var upcoming: [Event] {
        return filter { $0.isUpcoming }.sorted { $0.startDate < $1.startDate }
    }
    
    var finished: [Event] {
        return filter { $0.isFinished }.sorted { $0.startDate > $1.startDate }
    }
    
    var today: [Event] {
        let calendar = Calendar.current
        let today = Date()
        return filter { event in
            calendar.isDate(event.startDate, inSameDayAs: today)
        }.sorted { $0.startDate < $1.startDate }
    }
    
    var uniqueEventNames: [String] {
        return Set(map { $0.name }).sorted()
    }
    
    var uniqueMaps: [String] {
        return Set(map { $0.map }).sorted()
    }
    
    func groupedByDay() -> [Date: [Event]] {
        let calendar = Calendar.current
        return Dictionary(grouping: self) { event in
            calendar.startOfDay(for: event.startDate)
        }
    }
    
    func groupedByName() -> [String: [Event]] {
        return Dictionary(grouping: self) { $0.name }
    }
    
    func groupedByMap() -> [String: [Event]] {
        return Dictionary(grouping: self) { $0.map }
    }
}
