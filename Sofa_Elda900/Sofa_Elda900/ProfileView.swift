//
//  ProfileView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import SwiftUI

struct ProfileView: View {
    private enum Constants {
        static let name = "Your Name"
        static let verdana = "Verdana"
        static let city = "City"
        static let gradientHeight = 118.0
    }
    
    let cells: [ProfileModel] = [
        .init(name: "City", imageName: "envelope", badge: 3),
        .init(name: "Notification", imageName: "bell-alt", badge: 4),
        .init(name: "Account Details", imageName: "user"),
        .init(name: "My purchases", imageName: "basket-shopping"),
        .init(name: "Settings", imageName: "gear"),
        
    ]

    
    var body: some View {
        
        ZStack {
            
            VStack {
                LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
                    .frame(height: Constants.gradientHeight)
                Color.white
            }
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                    .frame(height: Constants.gradientHeight)
                
                Image(.avatar)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .background(.lightButton.opacity(0.3))
                    .clipShape(Circle())
                
                Spacer()
                    .frame(height: 16)
                
                Text(Constants.name)
                    .font(.custom(Constants.verdana, size: 24))
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                
                HStack {
                    Image(.icon)
                    Text(Constants.city)
                        .font(.custom(Constants.verdana, size: 20))
                        .foregroundStyle(.gray)
                }
                
                List(cells) { cell in
                    //makeCellView(profile)
                    if cell.name == "Settings" {                           NavigationLink(destination: AccountPaymentView()) {
                               makeCellView(cell)
                           }
                       } else {
                           makeCellView(cell)
                       }
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    private func makeCellView(_ item: ProfileModel) -> some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .frame(width: 30, height: 30)
            Text(item.name)
                .font(.custom(Constants.verdana, size: 20))
                .foregroundStyle(.gray)
            
            Spacer()
            
            if let badge = item.badge {
                Circle()
                    .fill(
                        LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text(String(badge))
                            .foregroundStyle(.white)
                            .font(.custom(Constants.verdana, size: 18))
                    )
            }
        }
    }
}


#Preview {
        ProfileView()
}
