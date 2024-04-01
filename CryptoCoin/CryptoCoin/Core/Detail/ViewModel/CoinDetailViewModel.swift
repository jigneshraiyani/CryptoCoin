//
//  CoinDetailViewModel.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/31/24.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    @Published var coin: Coin
    @Published var overviewStatics: [Statistic] = []
    @Published var additionalStatics: [Statistic] = []
    
    private let coinDetailService: CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribe()
    }
    
    private func addSubscribe() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatics = returnedArrays.overview
                self?.additionalStatics = returnedArrays.additional
            }
            .store(in: &cancellable)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetail?,
coinModel: Coin) ->
    (overview: [Statistic], additional: [Statistic]) {
        
        let overviewArray = createOverViewArray(coinModel: coinModel)
        let additionalArray = createAdditionalArray(coinDetailModel: coinDetailModel,
                                                    coinModel: coinModel)
        return(overviewArray, additionalArray)
    }
    
    private func createOverViewArray(coinModel: Coin) -> [Statistic] {
        // Overview
        let price = coinModel.currentPrice.convertCurrencyWith2Decimal()
        let priceChange = coinModel.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price",
                                  value: price,
                                  percentage: priceChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization",
                                      value: marketCap,
                                      percentage: marketCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = Statistic(title: "Rank",
                                 value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume",
                                   value: volume)
        
        let overviewArray: [Statistic] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overviewArray
    }
    
    private func createAdditionalArray(coinDetailModel: CoinDetail?,
                                       coinModel: Coin) -> [Statistic] {
        // Additional
        let high = coinModel.high24H?.convertCurrencyWith6Decimal() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coinModel.low24H?.convertCurrencyWith6Decimal() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChangeAdd = coinModel.priceChange24H?.convertCurrencyWith6Decimal() ?? "n/a"
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStatAdd = Statistic(title: "24h Price Change",
                                  value: priceChangeAdd,
                                  percentage: pricePercentageChange)
        
        let marketCapAdd = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChangeAdd = coinModel.marketCapChangePercentage24H
        let marketCapStatAdd = Statistic(title: "24h Market Cap Change",
                                      value: marketCapAdd,
                                      percentage: marketCapChangeAdd)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeStarting = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time",
                                  value: blockTimeStarting)
        
        let hasing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hasingStat = Statistic(title: "Hashing Algorithm",
                                  value: hasing)
        
        let additionalArray: [Statistic] = [
            highStat, lowStat, priceStatAdd, marketCapStatAdd, blockStat, hasingStat
        ]
        return additionalArray
    }
}
