//
//  GoodsModel.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import Foundation
struct GoodsModel: Identifiable {
    ///id
    var id = UUID()
    /// название картинки
    var nameImage: String
    /// название дивана
    var nameText: String
    /// цена cо скидкой
    var price: Int
    /// цена без скидки
    var lastPrice: String
   ///  сумма товаров
    var amount: Int
    /// переменная Booll
        var isBool: Bool
}
