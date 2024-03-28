//
//  MarketDataService.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/28/24.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketData? = nil
    var marketSubscription: AnyCancellable?
    let url_market_data = "https://api.coingecko.com/api/v3/global"
    
    init(){
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: url_market_data) else { return }
        marketSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketSubscription?.cancel()
            })
    }
}
