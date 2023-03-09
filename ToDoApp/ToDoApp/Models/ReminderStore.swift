//
//  ReminderStore.swift
//  ToDoApp
//
//  Created by Michał Gerlach on 07/03/2023.
//

import Foundation
import EventKit

final class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            return
        case .restricted:
            throw AppError.accessRestricted
        case .notDetermined:
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else {
                throw AppError.accessDenied
            }
        case .denied:
            throw AppError.accessDenied
        @unknown default:
            throw AppError.unknown
        }
    }
    
    private func read(with id: Reminder.ID) throws -> EKReminder {
        guard let ekReminder = ekStore.calendarItem(withIdentifier: id) as? EKReminder else {
            throw AppError.failedReadingCalendarItem
        }
        return ekReminder
    }
    
    func readAll() async throws -> [Reminder]{
        guard isAvailable else {
            throw AppError.accessDenied
        }
        
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekReminders = try await ekStore.reminders(matching: predicate)
        let reminders: [Reminder] = try ekReminders.compactMap { ekReminder in //compactMap -> both .filter and .map
            do {
                return try Reminder(with: ekReminder)
            } catch AppError.reminderHasNoDueDate {
                return nil
            }
        }
        return reminders
    }
    
    @discardableResult // attribute instructs the compiler to omit warnings in cases where the call site doesn’t capture the return value
    func save(_ reminder: Reminder) throws -> Reminder.ID {
        guard isAvailable else {
            throw AppError.accessDenied
        }
        let ekReminder: EKReminder
        do {
            ekReminder = try read(with: reminder.id)
        } catch {
            ekReminder = EKReminder(eventStore: ekStore)
        }
        ekReminder.update(using: reminder, in: ekStore)
        try ekStore.save(ekReminder, commit: true)
        return ekReminder.calendarItemIdentifier
    }
    func remove(with id: Reminder.ID) throws {
        guard isAvailable else {
            throw AppError.accessDenied
        }
        let ekReminder = try read(with: id)
        try ekStore.remove(ekReminder, commit: true)
    }
}
