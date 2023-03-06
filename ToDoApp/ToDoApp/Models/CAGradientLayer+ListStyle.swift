//
//  CAGradientLayer+ListStyle.swift
//  ToDoApp
//
//  Created by Michał Gerlach on 06/03/2023.
//

import Foundation
import UIKit

extension CAGradientLayer {
    
    static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer
    }
    
    private static func colors(for style: ReminderListStyle) -> [CGColor] {
        let beginColor: UIColor
        let endColor: UIColor
        
        switch style {
        case .all:
            beginColor = AppColor.gradientAllBegin
            endColor = AppColor.gradientAllEnd
        case .future:
            beginColor = AppColor.gradientFutureBegin
            endColor = AppColor.gradientFutureEnd
        case .today:
            beginColor = AppColor.gradientTodayBegin
            endColor = AppColor.gradientTodayEnd
        }
        return [beginColor.cgColor, endColor.cgColor]
    }
}
