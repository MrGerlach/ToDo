//
//  Reminder+EKReminder.swift
//  ToDoApp
//
//  Created by Michał Gerlach on 07/03/2023.
//

import Foundation
import EventKit

extension Reminder {
    init(with ekReminder: EKReminder) throws {
        guard let dueDate = ekReminder.alarms?.first?.absoluteDate else {
            throw AppError.reminderHasNoDueDate
        }
        id = ekReminder.calendarItemIdentifier // EventKit provides a unique identifier for all reminders
        title = ekReminder.title
        self.dueDate = dueDate
        notes = ekReminder.notes
        isComplete = ekReminder.isCompleted
    }
}
