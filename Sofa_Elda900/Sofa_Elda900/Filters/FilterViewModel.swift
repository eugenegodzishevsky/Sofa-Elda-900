//
//FilterViewModel.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 10.05.2024.
//

import Foundation

///Модель для экрана фильтрации
class FilterViewModel: ObservableObject {
    @Published var colorName = "purple"
    @Published var colors: [String] = ["white", "black", "gray", "purple","yellow",
                                       "red","blue", "green", "mint","orange",
                                       "mocha", "sea foam", "cayenne", "lime","lavender",
                                       "bubblegum", "spring", "midnight", "teal", "salmon"
                                    ]
    func makeColor(_ index: Int) {
        colorName = "\(colors[index])"
    }
}
