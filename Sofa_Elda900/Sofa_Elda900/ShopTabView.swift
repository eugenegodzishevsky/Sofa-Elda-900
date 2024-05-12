//
//  ShopTabView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import SwiftUI

struct ShopTabView: View {
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            GoodsView()
                .tabItem {
                    let image: UIImage = .shop.withRenderingMode(.alwaysTemplate)
                    Image(uiImage: image)
                }
            
            BasketView()
                .tabItem {
                    let image: UIImage = .basket.withRenderingMode(.alwaysTemplate)
                    Image(uiImage: image)
                }
            
            ProfileView()
                .tabItem {
                    let image: UIImage = .face.withRenderingMode(.alwaysTemplate)
                    Image(uiImage: image)
                }
        }
        
        .tint(.lightGreen)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
ShopTabView()
}
