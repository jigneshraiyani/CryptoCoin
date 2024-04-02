//
//  StatisticView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/28/24.
//

import SwiftUI

struct StatisticView: View {
    let statModel : Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(statModel.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(statModel.value)
                .foregroundColor(Color.theme.accentColor)
                .font(.headline)
            HStack(spacing: 5) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:
                                (statModel.percentage ?? 0) >= 0 ? 0 : 180))
                Text(statModel.percentage?.asPercentageString() ?? "")
                    .font(.caption)
                .bold()
            }
            .foregroundColor((statModel.percentage ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
            .opacity(statModel.percentage == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            StatisticView(statModel: DeveloperPreview.shareInstance.statistic1)
                .previewLayout(.sizeThatFits)
            StatisticView(statModel: DeveloperPreview.shareInstance.statistic2)
                .previewLayout(.sizeThatFits)
            StatisticView(statModel: DeveloperPreview.shareInstance.statistic3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
