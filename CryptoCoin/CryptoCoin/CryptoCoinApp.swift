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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DashBoardView()
                    .navigationBarHidden(true)
            }.environmentObject(dashboardvm)
        }
    }
}
