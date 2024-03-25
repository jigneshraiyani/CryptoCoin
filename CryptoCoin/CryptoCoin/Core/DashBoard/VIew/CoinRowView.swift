//
//  CoinRowView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
           rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin,
                        showHoldingColumn: true)
            CoinRowView(coin: dev.coin,
                        showHoldingColumn: true)
            .colorScheme(.dark)
        }
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text("\(coin.name)")
                .font(.headline)
                .foregroundColor(Color.theme.accentColor)
                .padding(.leading, 5)
        }
    }
    
    private var centerColumn: some View {
        VStack (alignment: .trailing){
            Text(coin.currentHoldingsValue.convertCurrencyWith2Decimal())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accentColor)
    }
    
    private var rightColumn: some View {
        VStack (alignment: .trailing){
            Text((coin.currentPrice.convertCurrencyWith6Decimal()))
                .bold()
                .foregroundColor(Color.theme.accentColor)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundColor((coin.priceChangePercentage24H ?? 0 >= 0) ? Color.theme.greenColor : Color.theme.redColor)
        }
        .frame(width: UIScreen.main.bounds.width/3.5,
               alignment: .trailing)
    }
}
