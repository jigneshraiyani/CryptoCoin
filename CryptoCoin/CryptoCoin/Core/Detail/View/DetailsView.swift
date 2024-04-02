//
//  DetailsView.swift
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
                DetailsView(coin: coin)
            }
        }
    }
    
}

struct DetailsView: View {
    @StateObject var vm: CoinDetailViewModel
    
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
                    overViewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                }
                .padding()
            }
        }
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
        DetailsView(coin: dev.coin)
    }
}

extension DetailsView {
    
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
}
