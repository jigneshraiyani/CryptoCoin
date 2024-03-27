//
//  CoinImageView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/27/24.
//

import Foundation
import SwiftUI

struct CoinImageView: View {
    
    @StateObject var coinVM: CoinImageViewModel
    
    init(coin: Coin) {
        _coinVM = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack {
            if let image = coinVM.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if coinVM.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.accentColor)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: DeveloperPreview.shareInstance.coin)
    }
}
