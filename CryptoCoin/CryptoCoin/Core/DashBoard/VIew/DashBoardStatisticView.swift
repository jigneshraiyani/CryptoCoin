//
//  DashBoardStatisticView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/28/24.
//

import SwiftUI

struct DashBoardStatisticView: View {
    
    @EnvironmentObject private var dashboardv : DashBoardViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(dashboardv.statistics) { stat in
                StatisticView(statModel: stat)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

struct DashBoardStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardStatisticView(showPortfolio: .constant(false))
            .environmentObject(dev.dashboardvm)
    }
}
