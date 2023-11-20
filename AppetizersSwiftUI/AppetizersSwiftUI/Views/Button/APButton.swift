//
//  APButton.swift
//  AppetizersSwiftUI
//
//  Created by Anders Lam on 2023-11-19.
//

import SwiftUI

struct APButton: View {

    let title: LocalizedStringKey

    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
    }
}

#Preview {
    APButton(title: "Test Title")
}
