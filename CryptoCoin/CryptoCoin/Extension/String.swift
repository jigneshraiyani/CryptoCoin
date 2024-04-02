//
//  String.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 4/3/24.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
