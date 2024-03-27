//
//  SearchBarView.swift
//  CryptoCoin
//
//  Created by Raiyani Jignesh on 3/27/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    private let searbarPlaceHolder = "Search by name or symbol..."
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryTextColor : Color.theme.accentColor)
            
            TextField(searbarPlaceHolder,
                      text: $searchText)
            .foregroundColor(Color.theme.accentColor)
            .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.theme.accentColor)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        searchText = ""
                        UIApplication.shared.endEditing()
                    }
                ,alignment: .trailing
            )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.backgroundColor)
                .shadow(
                    color: Color.theme.accentColor.opacity(0.15),
                radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant("test"))
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
            SearchBarView(searchText: .constant(""))

        }
    }
}
