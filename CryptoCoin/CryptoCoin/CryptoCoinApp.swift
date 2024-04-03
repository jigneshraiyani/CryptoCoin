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
    @State private var showLaunchView: Bool = true
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accentColor)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView {
                    DashBoardView()
                        .navigationBarHidden(true)
                }.environmentObject(dashboardvm)
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
