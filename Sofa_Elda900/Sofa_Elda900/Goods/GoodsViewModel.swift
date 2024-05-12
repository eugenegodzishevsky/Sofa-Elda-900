//
//  GoodsViewModel.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import Foundation
import SwiftUI

class GoodsViewModel: ObservableObject {
    
    @Published var sumPrice = 0
    @Published  var goods: [GoodsModel] = [
        .init(nameImage: "redSofa", nameText: "Sofa", price: 999, lastPrice: "2000", amount: 0, isBool: false),
        .init(nameImage: "armchair", nameText: "Armchair", price: 99, lastPrice: "220", amount: 0, isBool: false),
        .init(nameImage: "bed", nameText: "Bed", price: 1000, lastPrice: "2000", amount: 0, isBool: false),
        .init(nameImage: "table", nameText: "Table", price: 600, lastPrice: "1200", amount: 0, isBool: false),
        .init(nameImage: "chair", nameText: "Сhair", price: 99, lastPrice: "200", amount: 0, isBool: false),
        .init(nameImage:  "wardrobe", nameText: "Wardrobe", price: 899, lastPrice: "1100", amount: 0, isBool: false)
    ]
    
    
    func minusPrice(item: Int) {
        sumPrice += goods[item].price
        goods[item].amount += 1
    }
    
    func plusPrice(item: Int) {
        if goods[item].amount >= 1  {
            sumPrice -= goods[item].price
            goods[item].amount -= 1
        }
        
    }
}
