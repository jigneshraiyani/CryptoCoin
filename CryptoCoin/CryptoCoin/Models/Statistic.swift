//
//  Statistic.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/28/24.
//

import Foundation

class Statistic: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentage: Double?
    
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
}
