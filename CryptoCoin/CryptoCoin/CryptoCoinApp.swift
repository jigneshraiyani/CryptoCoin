//
//  CryptoCoinApp.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import SwiftUI

@main
struct CryptoCoinApp: App {
    @StateObject private var dashboardvm = DashBoardViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DashBoardView()
                    .navigationBarHidden(true)
            }.environmentObject(dashboardvm)
        }
    }
}
