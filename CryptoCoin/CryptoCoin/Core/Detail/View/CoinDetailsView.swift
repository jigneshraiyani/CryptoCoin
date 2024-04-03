//
//  CoinDetailsView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/31/24.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                CoinDetailsView(coin: coin)
            }
        }
    }
    
}

struct CoinDetailsView: View {
    @StateObject var vm: CoinDetailViewModel
    @State private var showFullDescription: Bool = false
    
    private let overViewTitleText = "Overview"
    private let additionDetailsText = "Additional Details"
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let gridSpacing: CGFloat = 20
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overViewTitle
                    Divider()
                    descriptionView
                    overViewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteView
                }
                .padding()
            }
        }
        .background(
            Color.theme.backgroundColor
                .ignoresSafeArea()
        )
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailsView(coin: dev.coin)
    }
}

extension CoinDetailsView {
    
    private var navigationBarTrailingItem: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryTextColor)
            CoinImageView(coin: vm.coin)
                .frame(width: 25,
                       height: 25)
        }
    }
    
    private var overViewTitle: some View {
        Text(overViewTitleText)
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text(additionDetailsText)
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accentColor)
            .frame(maxWidth: .infinity,
                   alignment: .leading)
    }
    
    private var overViewGrid: some View {
        LazyVGrid(columns: gridColumns,
                  alignment: .center,
                  spacing: gridSpacing,
                  pinnedViews: []) {
            ForEach(vm.overviewStatics) { stat in
                StatisticView(statModel: stat)
            }
        }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: gridColumns,
                  alignment: .center,
                  spacing: gridSpacing,
                  pinnedViews: []) {
            ForEach(vm.additionalStatics) { stat in
                StatisticView(statModel: stat)
            }
        }
    }
    
    private var descriptionView: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryTextColor)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more ..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            }
        }
    }
    
    private var websiteView: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website",
                     destination: url)
            }
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit",
                     destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .font(.headline)
    }
}
