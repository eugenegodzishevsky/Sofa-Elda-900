//
//  CustomButton.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 08.05.2024.
//

import SwiftUI

struct CustomButton: View {
    
    private let verdana = "Verdana"
    
    var buttonName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {

            Spacer()
            Text(buttonName)
                .font(.custom(verdana, size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Spacer()
        }
        .background(Capsule()
            .fill(
                LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing))
            .frame(height: 55)
            .padding(.horizontal, 55))
    }
}

#Preview {
    ContentView()
}
