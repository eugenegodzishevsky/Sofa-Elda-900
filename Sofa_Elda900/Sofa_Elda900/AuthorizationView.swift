//
//  AuthorizationView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 08.05.2024.
//

import SwiftUI

struct AuthorizationView: View {
    
    private enum Constants {
        static let login = "Log in"
        static let signUp = "Sign up"
        static let phonePlaceholder = "+●(●●●)●●●-●●-●●"
        static let password = "Password"
        static let passwordPlaceholder = "123456789012345"
        static let verdana = "Verdana"
        static let supportService = "Please call to support service"
        static let supportPhone = "8-800-800-0008"
        static let forgotPassword = "Forgot your password?"
        static let checkVerification = "Check Verification"
        static let gradientHeight = 118.0
    }
    
    @ObservedObject var viewModel = AuthViewModel()
    
    @State private var isErrorShown = false
    @State private var isNavigationActive = false
    @State private var isPasswordForgotten = false
    
    @FocusState private var focusedField: Int?
    
    var body: some View {
        
        VStack {
            LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
                .frame(height: Constants.gradientHeight)
            Color.white
                .overlay(
                    mainView
                )
                .padding(.vertical)
        }
        .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
    
    private var mainView: some View {
        VStack {
            Spacer()
                .frame(height: 37)
            
            HStack(spacing: 0) {
                Color.white
                Color.lightGray
            }
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.lightGray, lineWidth: 2))
            .overlay(
                HStack {
                    Spacer()
                    Text(Constants.login)
                        .font(.custom(Constants.verdana, size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.linearGradient(colors: [.darkButton, .lightButton], startPoint: .top, endPoint: .bottom))

                    Spacer()
                    Text(Constants.signUp)
                        .font(.custom(Constants.verdana, size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.linearGradient(colors: [.darkButton, .lightButton], startPoint: .top, endPoint: .bottom))

                    Spacer()
                }
                    .foregroundStyle(.linearGradient(colors: [.darkButton, .lightButton], startPoint: .top, endPoint: .bottom))
            )
            .frame(height: 55)
            .padding(.horizontal, 45)
            
            Spacer()
                .frame(height: 75)
            
            Group {
                loginTextField
                
                Spacer()
                    .frame(height: 12)
                
                Divider()
                    .overlay(isErrorShown ? .red : .black)
                
                Spacer()
                    .frame(height: 24)
                
                HStack {
                    Text(Constants.password)
                        .font(.custom(Constants.verdana, size: 16))
                        .bold()
                    Spacer()
                }
                
                SecuredTextFieldView(text: $viewModel.password, placeHolder: Constants.passwordPlaceholder)
                    .focused($focusedField, equals: 2)
                    .onSubmit {
                        checkFields()
                    }
            
                Spacer()
                    .frame(height: 12)
                
                Divider()
                    .overlay(isErrorShown ? .red : .black)
            }
            .foregroundStyle(isErrorShown ? .red : .darkButton)
            .offset(y: isErrorShown ? 5 : 0)
            .font(.custom(Constants.verdana, size: 20))
            .bold()
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 95)
            
            Button(action: {
                checkFields()
            }, label: {
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
            })
            
            NavigationLink("", destination: ShopTabView(), isActive: $isNavigationActive)
    
            Spacer()
                .frame(height: 24)
            
            Group {
                Text(Constants.forgotPassword)
                    .onTapGesture {
                        isPasswordForgotten = true
                    }
                
                Spacer()
                    .frame(height: 18)
                
                NavigationLink(destination: VerificationView()) {
                    Text(Constants.checkVerification)
                }
                
                Divider()
                    .overlay(.lightGray)
                    .padding(.horizontal, 116)
            }
            .font(.custom(Constants.verdana, size: 20))
            .fontWeight(.bold)
            .foregroundColor(.gray)
            
            Spacer()
        }
        
        .onAppear() {
            focusedField = 1
        }
        .alert(isPresented: $isPasswordForgotten, content: {
            Alert(title: Text(Constants.supportService), message: Text(Constants.supportPhone))
        })
    }
    
    private var loginTextField: some View {
        TextField("", text: $viewModel.phoneNumber, prompt: Text(Constants.phonePlaceholder)
            .foregroundStyle(isErrorShown ? .red : .darkButton))
        .focused($focusedField, equals: 1)
        .textInputAutocapitalization(.never)
        .keyboardType(.numberPad)
        .autocorrectionDisabled()
        .onChange(of: viewModel.phoneNumber) { _, newValue in
            if newValue.count == 18 {
                focusedField = 2
            }
            viewModel.phoneNumberCheck(with: newValue)
        }
        .onSubmit {
            focusedField = 2
        }
    }
    
    private func checkFields() {
        if viewModel.phoneNumber.isEmpty || viewModel.password.isEmpty {
            withAnimation(.spring(Spring(duration: 0.3, bounce: 0.85), blendDuration: 0.9)) {
                isErrorShown = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                isErrorShown = false
                if viewModel.password.isEmpty {
                    focusedField = 2
                }
                
                if viewModel.phoneNumber.isEmpty {
                    focusedField = 1
                }
            })
        } else {
            isNavigationActive = true
        }
    }
}

#Preview {
        AuthorizationView()
}
