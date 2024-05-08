//
//  AuthorizationView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 08.05.2024.
//

import SwiftUI

struct AuthorizationView: View {
    
    private enum Constants {
        static let verdana = "Verdana"
        static let phoneFormat = "+X (XXX) XXX-XX-XX"
        static let alertTitle = "Для восстановления пароля свяжитесь с техподдержкой \n +7 (322) 32-22-22"
        static let password = "Password"
        static let fargot = "Forgot your password?"
        static let checkVerif = "Check Verification"
        static let signUp = "Sign up"
        static let phoneNumber = "Phone number"
        static let eyeOpen = "eye"
        static let eyeClose = "eye.slash"
        static let logIn = "Log in"
    }
    
    @State private var login = ""
    @State private var password = ""
    @State var showAlert = false
    @State var showPassword = false
    
    @FocusState var isPhoneOnFocus
    @FocusState var isPasswordOnFocus
    
    @ObservedObject var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.top)
            Spacer()
                .frame(height: 24)
            
            HStack(spacing: 0) {
                Color.white
                Color.roundedButton
            }
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.roundedButton, lineWidth: 2))
            .overlay(
                HStack {
                    Spacer()
                    Text(Constants.logIn)
                    Spacer()
                    Text(Constants.signUp)
                    Spacer()
                }
                    .font(.custom(Constants.verdana, size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.darkButton, .lightButton], startPoint: .top, endPoint: .bottom))            )
            .frame(height: 55)
            .padding(.horizontal, 45)
            
            
            Spacer()
                .frame(height: 35)
            
            Group {
                Text(Constants.phoneNumber)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField(text: $login, label: {
                    Text(Constants.phoneFormat)
                })
                .keyboardType(.numberPad)
                    .onChange(of: login) { newValue in
                        login = viewModel.formatPhoneNumber(with: Constants.phoneFormat, phone: newValue)
                        viewModel.checkPhoneNumber(count: login.count)
                        isPhoneOnFocus = viewModel.showPhoneNumberKeyboard
                        isPasswordOnFocus = viewModel.showPasswordKeyboard
                    }
                    .focused($isPhoneOnFocus)
                
                Divider()
                    .overlay(.gray)
                Spacer().frame(height: 50)
                
                Text(Constants.password)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    setPasswordTextField()
                        .onChange(of: password) { newValue in
                            viewModel.checkPassword(count: newValue.count)
                            isPasswordOnFocus = viewModel.showPasswordKeyboard
                        }
                        .focused($isPasswordOnFocus)
                    
                    Button(action: {
                        viewModel.updateField()
                    },
                           label: {
                        Image(systemName:  self.viewModel.showPassword ? Constants.eyeOpen : Constants.eyeClose)
                        
                    })
                }
                Divider()
                    .overlay(.gray)
            }
            .font(.custom(Constants.verdana, size: 20))
            .bold()
            .padding(.horizontal, 20)
            .foregroundStyle(.gray)
            
            Spacer()
                .frame(height: 95)
            
            NavigationLink {
                DetailedView()
            } label: {
                HStack {
                    Spacer()
                    Text(Constants.signUp)
                        .font(.custom(Constants.verdana, size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .background(Capsule()
                    .fill(
                        LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing))
                        .frame(height: 55)
                        .padding(.horizontal, 55))
            }
            
            Spacer()
                .frame(height: 24)
            
            Button {
                self.showAlert = true
            } label: {
                Text(Constants.fargot).foregroundStyle(.darkButton)
                    .bold()
            }.alert(isPresented: $showAlert) {
                Alert(title: Text(Constants.alertTitle))
            }
            
            Spacer()
                .frame(height: 18)
            
            NavigationLink(destination: VerificationView()) {
                Text(Constants.checkVerif).foregroundStyle(.darkButton)
                    .bold()
            }
            
            Divider()
                .overlay(.gray)
                .padding(.horizontal, 116)
            
                .font(.custom(Constants.verdana, size: 20))
                .bold()
                .padding(.horizontal, 20)
                .foregroundStyle(.gray)
            Spacer()
                .frame(height: 200)
        }
        
        .navigationBarBackButtonHidden()
        
    }
    
    private func setPasswordTextField() -> some View {
        Group {
            if viewModel.showPassword {
                TextField(Constants.password, text: $password)
            } else {
                SecureField(Constants.password, text: $password)
            }
        }
    }
}


#Preview {
    AuthorizationView()
}
