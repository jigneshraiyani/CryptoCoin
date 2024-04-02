//
//  CoinDetailDataService.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/31/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetail? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin){
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        let url_coin_detail = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        guard let url = URL(string: url_coin_detail) else {
            return
        }
        
        coinDetailSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
