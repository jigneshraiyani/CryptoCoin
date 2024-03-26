//
//  CircleButton.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import SwiftUI

struct CircleButton: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .frame(width: 50 , height: 50)
            .foregroundColor(Color.theme.greenColor)
            .background(
                Circle()
                    .foregroundColor(Color.theme.backgroundColor)
            )
            .shadow(
                color: Color.theme.accentColor.opacity(0.25),
                radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButton(iconName: "plus")
                .previewLayout(.sizeThatFits)
            
            CircleButton(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}
