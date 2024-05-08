//
//  AuthViewModel.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 08.05.2024.
//

import Foundation

final class AuthViewModel: ObservableObject {
    private let phoneFormat = "+X (XXX) XXX-XX-XX"
    
    @Published public var showPassword = false
    @Published public var showPasswordKeyboard = false
    @Published public var showPhoneNumberKeyboard = true
    
    public func updateField() {
        showPassword.toggle()
    }
    
    public func checkPhoneNumber(count: Int) {
        if count == phoneFormat.count {
            showPhoneNumberKeyboard = false
            showPasswordKeyboard = true
        }
    }
    
    public func checkPassword(count: Int) {
        if count == 15 {
            showPasswordKeyboard = false
        }
    }
    
    public func formatPhoneNumber(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
