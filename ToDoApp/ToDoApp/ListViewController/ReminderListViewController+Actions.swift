//
//  ReminderListViewController+Actions.swift
//  ToDoApp
//
//  Created by Michał Gerlach on 04/01/2023.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(with: id)
    }
    
    
}
