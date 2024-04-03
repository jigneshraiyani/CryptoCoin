//
//  PortfolioView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/30/24.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var dashboardvm: DashBoardViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    let screenTitle = "Edit Portfolio"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading,
                       spacing: 0) {
                    SearchBarView(searchText: $dashboardvm.searchBarText)
                    coinList
                    
                    if selectedCoin != nil {
                        protfolioInputSection
                    }
                }
            }
            .background (
                Color.theme.backgroundColor
                    .ignoresSafeArea()
            )
            .navigationTitle(screenTitle)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    xMarkButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            })
            .onChange(of: dashboardvm.searchBarText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.dashboardvm)
    }
}

extension PortfolioView {
    var xMarkButton: some View{
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
    
    var coinList: some View {
        ScrollView(.horizontal,
                   showsIndicators: false) {
            LazyHStack {
                ForEach(dashboardvm.searchBarText.isEmpty ?
                        dashboardvm.portfolioCoins : dashboardvm.allCoins) { coin in
                    CoinView(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoins(coin: coin)
                            }
                        }
                        .background (
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id
                                        ? Color.theme.greenColor : Color.clear,
                                        lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 10)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoins(coin: Coin) {
        selectedCoin = coin
        
        if let portfolioCoin = dashboardvm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    func getCurrentValue() -> Double {
        if let quantiy = Double(quantityText) {
            return quantiy * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
        
    }
    
    private var protfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.convertCurrencyWith6Decimal() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex. 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().convertCurrencyWith2Decimal())
            }
            
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10, content: {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
        })
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText) else { return }
        
        // Show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // Save to Portfolio
        dashboardvm.updatePortfolio(coin: coin,
                                    amount: amount)
        
        // Hide keyboard
        UIApplication.shared.endEditing()
        
        // Hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
        
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        dashboardvm.searchBarText = ""
    }
}
