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
    let chevDownIcon = "chevron.down"
    let goforwardIcon = "goforward"
    let priceTitle = "Live Prices"
    let portfolioTitle = "Portfolio"
    
    let barTitle = "Coin"
    let barHolding = "Holding"
    let barPrice = "Price"
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var selectedCoin: Coin? = nil
    @State private var showDetailsView: Bool = false
    @State private var showSettingsView: Bool = false
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
                    ZStack(alignment: .top) {
                        if dashboardv.portfolioCoins.isEmpty && dashboardv.searchBarText.isEmpty {
                            portfolioEmptyText
                        } else {
                            portfolioCoinList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
        .background(
            NavigationLink(destination: DetailLoadingView(coin: $selectedCoin),
                           isActive: $showDetailsView,
                           label: { EmptyView() })
        )
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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimation(animation: $showPortfolio)
                )
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
                    .onTapGesture {
                        navigateToDetailsView(coin: coin)
                    }
                    .listRowBackground(Color.theme.backgroundColor)
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
                    .onTapGesture {
                        navigateToDetailsView(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioEmptyText: some View {
        Text("You have not added any coins to your portfolio yet. Click the + button to get started.")
            .font(.callout)
            .foregroundColor(Color.theme.accentColor)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private func navigateToDetailsView(coin: Coin) {
        selectedCoin = coin
        showDetailsView.toggle()
    }
    
    private var columnsTitles: some View {
        HStack {
            HStack {
                Text(barTitle)
                Image(systemName: chevDownIcon)
                    .opacity((dashboardv.sortingOption == .rank || dashboardv.sortingOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: dashboardv.sortingOption == .rank ? 0 : 180 ))
            }
            .onTapGesture {
                withAnimation(.default) {
                    dashboardv.sortingOption =
                    dashboardv.sortingOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if showPortfolio == true {
                HStack {
                    Text(barHolding)
                    Image(systemName: chevDownIcon)
                        .opacity((dashboardv.sortingOption == .holding || dashboardv.sortingOption == .holdingReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: dashboardv.sortingOption == .holding ? 0 : 180 ))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        dashboardv.sortingOption =
                        dashboardv.sortingOption == .holding ? .holdingReversed : .holding
                    }
                }
            }
            HStack {
                Text(barPrice)
                Image(systemName: chevDownIcon)
                    .opacity((dashboardv.sortingOption == .price || dashboardv.sortingOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: dashboardv.sortingOption == .price ? 0 : 180 ))
            }
            .frame(width: UIScreen.main.bounds.width/3.5,
                       alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    dashboardv.sortingOption =
                    dashboardv.sortingOption == .price ? .priceReversed : .price
                }
            }
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    dashboardv.reloadData()
                }
            } label: {
                Image(systemName: goforwardIcon)
            }
            .rotationEffect(Angle(degrees: dashboardv.isLoading ? 360 : 0),
                            anchor: .center)
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.accentColor)
        .padding(.horizontal)
    }
}
