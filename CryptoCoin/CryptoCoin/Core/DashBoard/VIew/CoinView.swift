//
//  CoinView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/30/24.
//

import SwiftUI

struct CoinView: View {
    let coin: Coin
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)

        }
    }
}
