//
//  SecuredTextfieldView.swift.
//  Sofa_Elda900
//
//  Created by Vermut xxx on 13.05.2024.
//

import SwiftUI

fileprivate enum Field: Hashable {
    case showPasswordField
    case hidePasswordField
}

struct SecuredTextFieldView: View {
    
    private enum Constants {
            static let eyeOpen = "eye"
            static let eyeClose = "eye.slash"
        }
        
    enum Opacity: Double {
        case hide = 0
        case show = 1
        
        mutating func toggle() {
            switch self {
            case .hide:
                self = .show
            case .show:
                self = .hide
            }
        }
        
    }
    
    @FocusState private var focusedField: Field?
    
    @State private var isSecured = true
    
    @Binding var text: String
    
    var placeHolder: String
    var maxInputAmount: Int {
        placeHolder.count
    }
    
    var body: some View {
            ZStack {
                securedTextField
                    .overlay(alignment: .trailing) {
                        Button {
                            performToggle()
                        } label: {
                            Image(isSecured ? Constants.eyeClose : Constants.eyeOpen)
                                .tint(.darkButton)
                        }
                    }
                
                

            }
    }
    
    var securedTextField: some View {
        
        Group {
            SecureField("", text: $text, prompt: Text(makeSecuredPlaceholder()))
                .focused($focusedField, equals: .hidePasswordField)
                .opacity(isSecured ? 1 : 0)
            
            TextField("", text: $text, prompt: Text(placeHolder))
                .focused($focusedField, equals: .showPasswordField)
                .opacity(isSecured ? 0 : 1)
        }
        .textInputAutocapitalization(.never)
        .keyboardType(.decimalPad)
        .autocorrectionDisabled()
        .onChange(of: text) { oldValue, _ in
            if text.count > maxInputAmount {
                text = oldValue
            }
        }
        
    }
    
    func makeSecuredPlaceholder() -> String {
        String(repeating: "●", count: placeHolder.count)
    }
    
    
    private func performToggle() {
        isSecured.toggle()
        
        if isSecured {
            focusedField = .hidePasswordField
        } else {
            focusedField = .showPasswordField
        }
    }
}
