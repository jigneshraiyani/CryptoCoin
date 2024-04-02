//
//  HapticManager.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/31/24.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
