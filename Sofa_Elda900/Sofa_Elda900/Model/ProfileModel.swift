//
//  ProfileModel.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import Foundation
///модель профиля
struct ProfileModel: Identifiable {
    ///идентификатор
    var id = UUID()
    ///имя
    var name: String
    ///картинка
    var imageName: String
    ///уведомление
    var badge: Int?
}
