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
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("initialise for coin \(coin.name)")
    }
    
    var body: some View {
        Text("Hello")
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(coin: dev.coin)
    }
}
