//
//  DashBoardView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import SwiftUI

struct DashBoardView: View {
    let infoIcon = "info"
    let plusIcon = "plus"
    let chevIcon = "chevron.right"
    let priceTitle = "Live Prices"
    let portfolioTitle = "Portfolio"
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea(.all)
            VStack {
                dashBoardheader
                Spacer(minLength: 0)
            }
        }
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DashBoardView()
                .navigationBarHidden(true)
        }
    }
}

extension DashBoardView {
    var dashBoardheader: some View {
        HStack {
            CircleButton(iconName: showPortfolio ? plusIcon : infoIcon)
                .animation(.none)
                .background(
                    CircleButtonAnimation(animation: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? portfolioTitle : priceTitle)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accentColor)
                .animation(.none)
            Spacer()
            CircleButton(iconName: chevIcon)
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
