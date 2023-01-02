//
//  Reminder.swift
//  ToDoApp
//
//  Created by Michał Gerlach on 02/01/2023.
//

import Foundation

struct Reminder {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
    
}

#if DEBUG
extension Reminder {
    static var sampleData = [
            Reminder(title: "Feed my cats", dueDate: Date().addingTimeInterval(800.0), notes: "Don't forget about snacks"),
            Reminder(title: "Code review", dueDate: Date().addingTimeInterval(14000.0), notes: "Don't forget to add commit!", isComplete: true),
            Reminder(title: "Finish project for studies", dueDate: Date().addingTimeInterval(3200.0), notes: "Collaborate with other classmates", isComplete: true),
            Reminder(title: "Confirm group reservation", dueDate: Date().addingTimeInterval(92500.0), notes: "Ask about table near the window"),
            Reminder(title: "Check out flights for spring break", dueDate: Date().addingTimeInterval(101000.0),  notes: "Make holiday request in SAP")
        ]
}
#endif
