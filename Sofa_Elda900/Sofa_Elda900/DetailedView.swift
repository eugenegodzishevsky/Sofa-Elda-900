//
//  DetailedScreen.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 07.05.2024.
//

import SwiftUI

struct DetailedView: View {
    
    private enum Constants {
        static let modelName = "Sofa Elda 900"
        static let verdana = "Verdana"
        static let heart = "heart"
        static let cornerRadius = 12.0
        static let rectangleHeight = UIScreen.main.bounds.height * (474.0 / 844.0)
        static let article = "Article: "
        static let articleValue = "283564"
        static let description = "Description: "
        static let descriptionValue = "A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design."
        static let buyNow = "Buy now"
        static let review = "Review"
        static let price = "Price: 999$"
        static let maxLength = 300
        static let nothing = "Nothing yet"
    }
    
    @State var reviewText = Constants.nothing
    @State var reviewCount = 0
    @State var lastText = ""
    
    @Environment(\.dismiss) var dismiss
    
    var productDetailModel: GoodsModel
    
    var body: some View {
        VStack {
            
            Spacer()
                .frame(height: 44)
            HeaderView()
            
            Spacer()
                .frame(height: 32)
            Image(.sofa)
            
            PriceView()
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
                .frame(height: Constants.rectangleHeight)
                .overlay (
                    VStack(spacing: 9) {
                        Spacer()
                            .frame(height: 24)
                        HStack {
                            Text(articleText)
                            Spacer()
                        }
                        
                        Text(descriptionText)
                        
                        Text(Constants.review)
                            .fontWeight(.bold)
                        
                        HStack(alignment: .top) {
                            TextEditor(text: $reviewText)
                                .scrollContentBackground(.hidden)
                                .onChange(of: reviewText, perform: { value in
                                    if lastText.count < Constants.maxLength {
                                        lastText = value
                                    } else {
                                        reviewText = lastText
                                    }
                                })
                                .onTapGesture(perform: {
                                    if reviewText == Constants.nothing {
                                        reviewText = ""
                                    }
                                })
                            
                            Text(countText)
                                .frame(width: 70)
                        }
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            Spacer()
                            Text(Constants.buyNow)
                                .font(.custom(Constants.verdana, size: 20))
                                .fontWeight(.bold)
                                .foregroundStyle(.linearGradient(colors: [.darkButton, .lightButton], startPoint: .top, endPoint: .bottom))
                            
                            Spacer()
                        }
                        .background(Capsule()
                            .fill(.white)
                            .frame(height: 55)
                            .padding(.horizontal, 25)
                            .shadow(radius: 4, y: 4))
                        
                        Spacer()
                            .frame(height: 48)
                    }
                        .padding(.horizontal, 20)
                        .font(.custom(Constants.verdana, size: 16))
                        .foregroundStyle(.white)
                )
        }
        .navigationBarBackButtonHidden()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private var articleText: AttributedString {
        makeBoldAttributedString(Constants.article) + makeRegularAttributedString(Constants.articleValue)
    }
    
    private var descriptionText: AttributedString {
        makeBoldAttributedString(Constants.description) + makeRegularAttributedString(Constants.descriptionValue)
    }
    
    private var countText: String {
        if reviewText == Constants.nothing {
            return ""
        }
        if reviewText.count > 0 {
            return "\(reviewText.count)/\(Constants.maxLength)"
        }
        return ""
    }
    
    func makeBoldAttributedString(_ string: String) -> AttributedString {
        var result = AttributedString(string)
        result.font = .custom(Constants.verdana, size: 16).bold()
        return result
    }
    
    func makeRegularAttributedString(_ string: String) -> AttributedString {
        AttributedString(string)
    }
    
    @available(iOS 16.0, *)
    struct HeaderView: View {
        var body: some View {
            HStack {
                Text(Constants.modelName)
                Spacer()
                Image(systemName: Constants.heart)
                
            }
            .font(.custom(Constants.verdana, size: 20))
            .bold()
            .padding(.horizontal, 20)
        }
    }
    
    @available(iOS 16.0, *)
    struct PriceView: View {
        var body: some View {
            HStack {
                Spacer()
                
                Rectangle()
                    .fill(.price)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 44)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 10)))
                    .overlay {
                        Text(Constants.price)
                            .font(.custom(Constants.verdana, size: 20))
                            .bold()
                    }
            }
        }
    }
    
}

//#Preview {
//    DetailedView()
//}



