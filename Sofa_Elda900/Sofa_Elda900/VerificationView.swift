//
//  VerificationScreen.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 08.05.2024.
//

import SwiftUI

struct VerificationView: View {
    
    @State private var isLoading = false
    
    @FocusState private var focusedField: Int?
    
    private enum Constants {
        static let title = "Verification"
        static let verdana = "Verdana"
        static let buttonTitle = "Continue"
        static let didntReceive = "Didn’t receive sms"
        static let sendAgain = "Send sms again"
        static let alert = "Fill in from message"
        static let smsCode = "9696"
        static let gradientHeight = 118.0
        static let backImage = "chevron.left"
        static let getSMS = "message to get verification code"
        static let checkSMS = "Check the SMS"
        static let verificationCode = "Verification code"
        static let ok = "Ok"
        static let cancel = "Cancel"
        
    }
    @Environment(\.dismiss) private var dismiss
    
    @State var smsNumbers = ["0", "0", "0", "0"]
    @State var isAlertShown = false
    
    var body: some View {
        ZStack {
            HeaderGradientView()
            VStack(spacing: 20) {
                Image(.mail)
                    .padding(.top, Constants.gradientHeight)
                    .frame(width: 200, height: 200)
                
                Text(Constants.verificationCode)
                    .font(.custom(Constants.verdana, size: 20))
                
                HStack(spacing: 8) {
                    ForEach(0..<smsNumbers.count, id: \.self) { index in
                        TextField("", text: $smsNumbers[index])
                            .multilineTextAlignment(.center)
                            .font(.custom(Constants.verdana, size: 40))
                            .frame(width: 60, height: 60)
                            .border(.secondary)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: index)
                        
                            .onChange(of: focusedField) { focused in
                                if focused == index {
                                    smsNumbers[index] = ""
                                }
                            }
                        
                            .onChange(of: smsNumbers[index]) { newValue in
                                if newValue.count == 1 {
                                    focusedField = (index == smsNumbers.count - 1) ? nil : index + 1
                                }
                            }
                    }
                }
                
                Text(Constants.checkSMS)
                    .font(.custom(Constants.verdana, size: 20))
                    .bold()
                Text(Constants.getSMS)
                    .font(.custom(Constants.verdana, size: 16))
                    .offset(y: -20)
                
                CustomButtonWithProgressView()
                
                Text(Constants.didntReceive)
                    .font(.custom(Constants.verdana, size: 20))
                    .offset(y: 20)
                
                Button(action: {
                    isAlertShown = true
                }, label: {
                    Text(Constants.sendAgain)
                        .font(.custom(Constants.verdana, size: 20))
                        .bold()
                })
                .padding()
                
                Divider()
                    .overlay(.black)
                    .padding(.horizontal, 115)
                    .offset(y: -25)
                Spacer()
            }
            .foregroundStyle(.darkButton)
            .alert(Constants.alert, isPresented: $isAlertShown) {
                Button(action: {}) {
                    Text(Constants.cancel)
                        .bold()
                }
                Button(action: {
                    setupCode()
                }) {
                    Text(Constants.ok)
                }
                
            } message: {
                Text(Constants.smsCode)
            }
            .navigationBarTitle(Constants.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Constants.title)
                        .font(.custom(Constants.verdana, size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: Constants.backImage)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    func setupCode() {
        let characters = Constants.smsCode.map { String($0) }
        for index in 0..<smsNumbers.count {
            smsNumbers[index] = characters[index]
        }
    }
    
    struct HeaderGradientView: View {
        var body: some View {
            VStack {
                LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
                    .frame(height: Constants.gradientHeight)
                Color.white
            }
            .ignoresSafeArea()
        }
    }
}


#Preview {
    VerificationView()
}

