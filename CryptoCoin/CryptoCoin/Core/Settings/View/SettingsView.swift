//
//  SettingsView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 4/3/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.backgroundColor
                    .ignoresSafeArea()
                List {
                    detailsView
                        .listRowBackground(Color.theme.backgroundColor.opacity(0.5))
                    geckoView
                        .listRowBackground(Color.theme.backgroundColor.opacity(0.5))
                    developerView
                        .listRowBackground(Color.theme.backgroundColor.opacity(0.5))
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    private var detailsView: some View {
        Section(header: Text("About CryptoCoin")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius:20))
                Text("Cryptocurrency represents a groundbreaking innovation in the realm of finance and technology, with the potential to reshape traditional financial systems and empower individuals with greater control over their assets and transactions. However, it's essential to approach cryptocurrencies with a clear understanding of their opportunities and risks.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Follow on LinkeIn",
                 destination: URL(string: "https://www.linkedin.com/in/jigneshraiyani1/")!)
        }
    }
    
    private var geckoView: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius:20))
                Text("CoinGecko serves as a valuable resource for cryptocurrency enthusiasts, traders, investors, and researchers seeking reliable data, analysis, and insights to navigate the dynamic and evolving cryptocurrency market.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Visit CoinGecko",
                 destination: URL(string: "https://www.coingecko.com")!)
        }
    }
    
    private var developerView: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius:20))
                Text("This app has been developed in SwiftUI and Swift. Overall, SwiftUI represents a modern and powerful approach to UI development on Apple platforms, offering developers a streamlined and intuitive toolkit for creating rich and interactive user experiences.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accentColor)
            }
            .padding(.vertical)
            Link("Check different projects",
                 destination: URL(string: "https://github.com/jigneshraiyani?tab=repositories")!)
        }
    }
}
