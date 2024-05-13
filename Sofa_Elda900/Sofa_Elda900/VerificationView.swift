//
//  VerificationScreen.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 08.05.2024.
//

import SwiftUI

struct VerificationView: View {
    
    private enum Constants {
        static let title = "Verification"
        static let verdana = "Verdana"
        static let verdanaBold = "verdana-Bold"
        static let buttonTitle = "Continue"
        static let didntReceive = "Didn’t receive sms"
        static let sendAgain = "Send sms again"
        static let alert = "Fill in from message"
        static let smsCode = "9893"
        static let verificationCode = "Verification code"
        static let gradientHeight = 118.0
        static let backImage = "chevron.backward"
        static let checkTheSMS = "Check the SMS"
        static let messageToGetCode = "message to get verification code"
        static let cancel = "Cancel"
        static let ok = "OK"
        
    }
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel = VerificationViewModel()
    
    @State private var smsNumbers = ["", "", "", ""]
    @State private var isAlertShown = false
    @State private var isSmsResendShown = false
    @State private var isContinued = false
    @State private var tempSmsCode = [String]()

    @FocusState var fieldId: Int?
    
    private var smsCode: [String] {
        var characters = [String]()
        for _ in 0..<smsNumbers.count {
            characters.append(String(Int.random(in: 0...9)))
        }
        tempSmsCode = characters
        return characters
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
                    .frame(height: Constants.gradientHeight)
                Color.white
            }
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Image(.mail)
                    .padding(.top, Constants.gradientHeight)
                    .frame(width: 200, height: 200)
                
                Text(Constants.verificationCode)
                    .font(.custom(Constants.verdana, size: 20))
                
                HStack(spacing: 8) {
                    ForEach(0..<smsNumbers.count, id: \.self) { index in
                        TextField("", text: $smsNumbers[index])
                            .focused($fieldId, equals: index)
                            .multilineTextAlignment(.center)
                            .font(.custom(Constants.verdana, size: 40))
                            .frame(width: 60, height: 60)
                            .border(.secondary)
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                fieldId = index
                            }
                            .onChange(of: smsNumbers[index], { oldValue, newValue in
                                fieldId = index
                                
                                smsNumbers[index] = newValue
                                
                                if newValue.count > 0 {
                                    fieldId = index + 1
                                } else {
                                    fieldId = index - 1
                                }
                                if newValue.count > 1 {
                                    smsNumbers[index] = oldValue
                                }
                            })
                            .onSubmit {
                                if fieldId != nil{
                                    fieldId! += 1
                                } else {
                                    fieldId = 0
                                }
                            }
                    }
                }
                
                Text(Constants.checkTheSMS)
                    .font(.custom(Constants.verdanaBold, size: 20))
                    .foregroundStyle(.gray)
                
                
                Text(Constants.messageToGetCode)
                    .font(.custom(Constants.verdana, size: 16))
                    .offset(y: -20)
                
                Button(action: continueAction) {
                    Spacer()
                    ZStack {
                        Text(Constants.buttonTitle)
                            .font(.custom(Constants.verdana, size: 20))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .opacity(isContinued ? 0 : 1)
                        
                        ProgressView()
                            .opacity(isContinued ? 1 : 0)
                    }
                    Spacer()
                }
                .background(Capsule()
                    .fill(
                        LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing))
                        .frame(height: 55))
                .padding(.horizontal, 45)
                
                
                Group {
                    Text(Constants.didntReceive)
                        .font(.custom(Constants.verdana, size: 20))
                        .offset(y: 20)
                    
                    Button(action: {
                        viewModel.generateSmsCode()
                        withAnimation {
                            isAlertShown = true
                        }
                    }, label: {
                        Text(Constants.sendAgain)
                            .font(.custom(Constants.verdanaBold, size: 20))
                            .foregroundStyle(.gray)
                    })
                    .padding()
                    
                    Divider()
                        .overlay(.black)
                        .padding(.horizontal, 115)
                        .offset(y: -25)
                }
                .opacity(isSmsResendShown ? 1 : 0)
                
                
                Spacer()
            }
            .foregroundStyle(.darkButton)
            .navigationBarBackButtonHidden()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: Constants.backImage)
                            .tint(.darkButton)
                    }
                    
                }
                
                ToolbarItem(placement: .principal) {
                    Text(Constants.title)
                        .font(.custom(Constants.verdana, size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.darkButton)
                }
            })
            .blur(radius: isAlertShown ? 10 : 0)
            
            if isAlertShown {
                alertView
                    .transition(.slide)
            }
        }
        .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        .onAppear() {
            fieldId = 0
        }
        
    }
    
    private var alertView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.lightGray)
            .frame(width: 300, height: 100)
            .shadow(radius: 4, y: 4)
            .overlay (
                VStack(spacing: 8) {
                    Group {
                        Text(Constants.alert)
                            .bold()
                        Text(String(viewModel.randomSmsCode.map({Character($0)})))
                    }
                    .font(.custom(Constants.verdana, size: 20))
                    .padding(.top, 8)
                    Divider()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.linear(duration: 1)) {
                                isAlertShown = false
                            }
                            
                        }, label: {
                            Text(Constants.cancel)
                        })
                        Spacer()
                        Divider()
                        Spacer()
                        Button(action: {
                            fillInCode()
                            isAlertShown = false
                        }, label: {
                            Text(Constants.ok)
                                .bold()
                        })
                        .padding(8)
                        Spacer()
                    }
                    
                }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.goodsBackground)
                    )
                
            )
        
    }
    
    private func continueAction() {
        
        isContinued = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            isContinued = false
            withAnimation {
                isSmsResendShown = true
            }
        })
    }
    
    private func fillInCode() {
        smsNumbers = viewModel.randomSmsCode
        
    }
}

#Preview {
    VerificationView()
}
