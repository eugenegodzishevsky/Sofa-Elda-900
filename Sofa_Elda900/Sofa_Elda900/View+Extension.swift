//
//  View+Extension.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import SwiftUI

struct RoundedCornerShape: Shape {
    var cornerRadii: CGSize
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        return Path(path.cgPath)
    }
}
