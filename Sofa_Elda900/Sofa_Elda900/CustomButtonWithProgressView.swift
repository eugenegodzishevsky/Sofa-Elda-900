//
//  CustomButtonWithProgressView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 08.05.2024.
//

import SwiftUI

struct CustomButtonWithProgressView: View {
    
    @State var isLoading = false
    
    private enum Constants {
        static let buttonTitle = "Continue"
        static let verdana = "Verdana"
    }
    
    var body: some View {
        
        Button(action: {
            isLoading.toggle()
        }) {
            HStack {
                Spacer()
                Text(Constants.buttonTitle)
                    .font(.custom("Verdana", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(isLoading ? .clear : .white)
                Spacer()
            }
            .background(
                Capsule()
                    .fill(
                        LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(height: 55)
                    .padding(.horizontal, 55)
            )
        }
        .overlay(
            GeometryReader { geometry in
                if isLoading {
                    ProgressView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                } else {
                    
                }
            }
                .allowsHitTesting(false)
        )
        //                .disabled(isLoading)
    }
}
