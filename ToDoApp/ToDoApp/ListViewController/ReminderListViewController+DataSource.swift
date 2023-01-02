//
//  ReminderListViewController+DataSource.swift
//  ToDoApp
//
//  Created by Michał Gerlach on 02/01/2023.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHanlder(cell : UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item] // Retrieve the reminder corresponding to the item
        var contentConfiguration = cell.defaultContentConfiguration() //Retrieve the cell’s default content configuration
        //defaultContentConfiguration() creates a content configuration with the predefined system style
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
    }
}
