//
//  EkEventStore+AsyncFetch.swift
//  ToDoApp
//
//  Created by Michał Gerlach on 07/03/2023.
//

import Foundation
import EventKit

extension EKEventStore {
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) { reminders in
                if let reminders = reminders {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: AppError.failedReadingReminders)
                }
            }
        }
    }
    
}
// can access a user’s calendar events and reminders.
