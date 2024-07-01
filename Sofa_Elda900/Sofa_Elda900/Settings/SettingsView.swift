//
//  SettingsView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 13.05.2024.
//

import SwiftUI

struct AccountPaymentView: View {
    
    private enum Constants {
        static let verdana = "Verdana"
        static let verdanaBold = "verdana-Bold"
        static let backImage = "chevron.backward"
        static let title = "Payment"
        static let buttonTitle = "Add now"
        static let cardNumber = "Card number"
        static let yourName = "Your Name"
        static let cardholder = "Cardholder"
        static let cardholderName = "Cardholder Name"
        static let initialCardNumber = "0000 0000 0000 0000"
        static let cardNumberPlaceholder = "**** **** **** 0000"
        static let maxCardNumberLength = 16
        static let addCard = "Add new card"
        static let month = "Month"
        static let year = "Year"
        static let cvc = "CVC"
        static let cvcPromt = "000"
        static let cvcCVV = "CVC/CVV"
        static let valid = "Valid"
        static let gradientHeight = 118.0
        static let duration = 0.3
        static let cvcText = "cvcText"
        static let cardAdded = "Card is succesfully added"
        static let cvcMustBe = "CVC must be 3 charackters length"
    }
    
    @Environment(\.dismiss) var dismiss
    
    @State var cardNumber = ""
    @State var cardholder = ""
    @State var month = "1"
    @State var year = "2024"
    @State var cvc = ""
    @State var hideKeyboard: ( () -> Void )?
    @State var frontDegree = 0.0
    @State var backDegree = 90.0
    @State var isFlipped = false
    @State var iscvcAlertShown = false
    @State var isSuccessAlertShown = false
    
    private var cardholderPlaceholder: String {
        cardholder.isEmpty ? Constants.cardholder : cardholder
    }
    private var cardNumberSecurePlaceholder: String {
        if cardNumber.count == Constants.maxCardNumberLength {
            let lastSymbols = String(cardNumber.suffix(4))
            return "**** **** ****" + lastSymbols
        }
        return Constants.cardNumberPlaceholder
    }
    
    private var cardNumberPlaceholder: String {
        cardNumber.count == Constants.maxCardNumberLength ? cardNumber : Constants.initialCardNumber
    }
    
    private var cvcPlaceholder: String {
        cvc.count == Constants.cvcPromt.count ? cvc : Constants.cvcPromt
    }
    
    private var date: String {
        let monthInteger = Int(month) ?? 0
        return String(format: "%02d", monthInteger) + "/" + String(year.suffix(2))
        
    }
    
    private enum Field: Hashable {
        case showPasswordField
        case hidePasswordField
    }
    
    private func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: Constants.duration)) {
                frontDegree = -90
                withAnimation(.linear(duration: Constants.duration).delay(Constants.duration)){
                    backDegree = 0
                }
            }
        } else {
            withAnimation(.linear(duration: Constants.duration).delay(Constants.duration)){
                frontDegree = 0
            }
            withAnimation(.linear(duration: Constants.duration)) {
                backDegree = 90
            }
        }
    }
    
    
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
            .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: Constants.backImage)
                        .tint(.white)
                })
            }
            
            ToolbarItem(placement: .principal) {
                Text(Constants.title)
                    .font(.custom(Constants.verdana, size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
    }
    
    private var mainView: some View {
        VStack(spacing: 30) {
            
            ZStack {
                cardFrontView
                cardBackView
            }
            .onTapGesture {
                flipCard()
            }
            
            cardDataInputView
            CustomButton(buttonName: Constants.buttonTitle, action: addNowAction)
                .padding(.bottom, 45)
                .padding(.horizontal, 25)
        }
        .padding(.horizontal, 20)
        .alert(Constants.cardAdded, isPresented: $isSuccessAlertShown, actions: {})
        .alert(Constants.cvcMustBe, isPresented: $iscvcAlertShown, actions: {})
    }
    
    private var cardDataInputView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 11) {
                
                Text(Constants.addCard)
                    .font(.custom(Constants.verdanaBold, size: 20))
                    .foregroundStyle(.darkButton)
                
                TextField("",
                          text: $cardholder,
                          prompt: Text(Constants.cardholderName)
                    .font(.custom(Constants.verdana, size: 20))
                    .foregroundStyle(.darkButton))
                .font(.custom(Constants.verdana, size: 20))
                .foregroundStyle(.darkButton)
                
                Divider()
                
                Text(Constants.cardNumber)
                    .font(.custom(Constants.verdanaBold, size: 20))
                    .foregroundStyle(.darkButton)
                
                
                TextField("",
                          text: $cardNumber,
                          prompt: Text(Constants.initialCardNumber)
                    .font(.custom(Constants.verdana, size: 20))
                    .foregroundStyle(.darkButton))
                .font(.custom(Constants.verdana, size: 20))
                .foregroundStyle(.darkButton)
                .keyboardType(.decimalPad)
                .onChange(of: cardNumber) { oldValue, _ in
                    if cardNumber.count > Constants.maxCardNumberLength {
                        cardNumber = oldValue
                    }
                }
                
                Divider()
                
                dateSelectionView
                
                Spacer()
                
                Text(Constants.cvc)
                    .font(.custom(Constants.verdanaBold, size: 20))
                    .foregroundStyle(.darkButton)
                    .padding(.top, -15)
                
                SecuredTextFieldView(text: $cvc, placeHolder: Constants.cvcPromt)
                    .font(.custom(Constants.verdana, size: 20))
                    .foregroundStyle(.darkButton)
                
                Divider()
                
            }
        }
    }
    
    private var dateSelectionView: some View {
        HStack {
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Text(Constants.month)
                        .font(.custom(Constants.verdana, size: 20))
                        .foregroundStyle(.darkButton)
                    Spacer()
                    Picker(selection: $month) {
                        ForEach (1...12, id: \.self) {Text("\($0)").tag("\($0)")}
                    } label: {
                        Text(Constants.month)
                    }
                    .pickerStyle(.menu)
                }
                
                Divider()
            }
            .padding(.trailing, 35)
            
            
            VStack(alignment: .leading) {
                HStack {
                    
                    Text(Constants.year)
                        .font(.custom(Constants.verdana, size: 20))
                        .foregroundStyle(.darkButton)
                    
                    
                    Picker(selection: $year) {
                        ForEach (0...10, id: \.self) {Text(String(2024 + $0)).tag(String(2024 + $0))}
                    } label: {
                        Text(Constants.year)
                    }
                    .pickerStyle(.menu)
                    
                }
                
                
                
                Divider()
            }
            .padding(.trailing, 35)
            
        }
        .tint(.darkButton)
        .padding(.zero)
    }
    
    
    private var cardFrontView: some View {
        LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 20)
            .shadow(radius: 4, y: 4)
            .overlay(
                
                VStack(alignment: .leading) {
                    
                    HStack() {
                        Spacer()
                        Image(.mir)
                            .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 29))
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    Group {
                        Text(Constants.cardNumber)
                            .font(.custom(Constants.verdanaBold, size: 20))
                            .foregroundStyle(.white)
                        Text(cardNumberSecurePlaceholder)
                            .font(.custom(Constants.verdanaBold, size: 20))
                            .foregroundStyle(.lightGray)
                        Spacer()
                        Text(Constants.yourName)
                            .font(.custom(Constants.verdanaBold, size: 20))
                            .foregroundStyle(.white)
                        Text(cardholderPlaceholder)
                            .font(.custom(Constants.verdanaBold, size: 20))
                            .foregroundStyle(.lightGray)
                    }
                    
                    .padding(.leading, 50)
                    Spacer()
                    
                }
            )
            .rotation3DEffect(
                Angle(degrees: frontDegree), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private var cardBackView: some View {
        LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 20)
            .shadow(radius: 4, y: 4)
            .overlay(
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(cardNumberPlaceholder)
                        .font(.custom(Constants.verdanaBold, size: 20))
                        .foregroundStyle(.white)
                    HStack {
                        Text(cvcPlaceholder)
                            .font(.custom(Constants.verdanaBold, size: 20))
                            .foregroundStyle(.white)
                        Text(Constants.cvcCVV)
                            .font(.custom(Constants.verdanaBold, size: 16))
                            .foregroundStyle(.lightGray)
                    }
                    Text(date)
                        .font(.custom(Constants.verdanaBold, size: 20))
                        .foregroundStyle(.white)
                    
                    
                }
            )
            .rotation3DEffect(
                Angle(degrees: backDegree), axis: (x: 0.0, y: 1.0, z: 0.0))
        
        
    }
    
    private func addNowAction() {
        print(Constants.cvcText, cvcPlaceholder)
        if cvc.count == 3 {
            isSuccessAlertShown = true
        } else { iscvcAlertShown = true}
    }
    
    
}

#Preview {
    AccountPaymentView()
}
