//
//  Double.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import Foundation

extension Double {
    
    /// Currency conversion 2 decimal places
    /// '''
    /// e.g 1234.5600 to $1234.56
    /// '''
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func convertCurrencyWith2Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Currency conversion 2-6 decimal places
    /// '''
    /// e.g 1234.56 to $1234.56
    /// '''
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func convertCurrencyWith6Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
    /// Currency as a String with 2-6 decimal places
    /// ```
    /// e.g 1.12200 to "1.12"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// String representation with percent symbol
    /// ```
    /// e.g 1.12200 to "1.12%"
    /// ```
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
}
