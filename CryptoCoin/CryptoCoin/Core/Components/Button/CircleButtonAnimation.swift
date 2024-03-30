//
//  CircleButtonAnimation.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/21/24.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animation: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animation ? 1.0 : 0.0)
            .opacity(animation ? 0.0 : 1.0)
            .animation(animation ?
                       Animation.easeOut(duration: 1.0) : .none)
    }
}

struct CircleButtonAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimation(animation: .constant(false))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}
