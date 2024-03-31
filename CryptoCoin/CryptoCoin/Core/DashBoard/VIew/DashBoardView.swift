//
//  DashBoardView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import SwiftUI

struct DashBoardView: View {
    let infoIcon = "info"
    let plusIcon = "plus"
    let chevIcon = "chevron.right"
    let priceTitle = "Live Prices"
    let portfolioTitle = "Portfolio"
    
    let barTitle = "Coin"
    let barHolding = "Holding"
    let barPrice = "Price"
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @EnvironmentObject private var dashboardv : DashBoardViewModel
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea(.all)
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(dashboardv)
                }
            VStack {
                dashBoardheader
                DashBoardStatisticView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $dashboardv.searchBarText)
                columnsTitles
                if showPortfolio == false {
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio == true {
                    portfolioCoinList
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
        }
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashBoardView()
                .navigationBarHidden(true)
        }
        .environmentObject(DeveloperPreview.shareInstance.dashboardvm)
    }
}

extension DashBoardView {
    private var dashBoardheader: some View {
        HStack {
            CircleButton(iconName: showPortfolio ? plusIcon : infoIcon)
                .animation(.none)
                .background(
                    CircleButtonAnimation(animation: $showPortfolio)
                )
                .onTapGesture {
                    showPortfolioView.toggle()
                }
            Spacer()
            Text(showPortfolio ? portfolioTitle : priceTitle)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accentColor)
                .animation(.none)
            Spacer()
            CircleButton(iconName: chevIcon)
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinList: some View {
        List {
            ForEach(dashboardv.allCoins) { coin in
                CoinRowView(coin: coin,
                            showHoldingColumn: false)
                    .listRowInsets(.init(top: 10,
                                         leading: 0,
                                         bottom: 0,
                                         trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinList: some View {
        List {
            ForEach(dashboardv.portfolioCoins) { coin in
                CoinRowView(coin: coin,
                            showHoldingColumn: true)
                    .listRowInsets(.init(top: 10,
                                         leading: 0,
                                         bottom: 0,
                                         trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnsTitles: some View {
        HStack {
            Text(barTitle)
            Spacer()
            if showPortfolio == true {
                Text(barHolding)
            }
            Text(barPrice)
                .frame(width: UIScreen.main.bounds.width/3.5,
                       alignment: .trailing)
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    dashboardv.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: dashboardv.isLoading ? 360 : 0),
                            anchor: .center)
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.accentColor)
        .padding(.horizontal)
    }
}
