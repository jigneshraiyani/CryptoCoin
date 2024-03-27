//
//  UIApplication.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/27/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
