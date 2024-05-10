//
//  GoodsView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import SwiftUI

struct GoodsView: View {
    
    private enum Constants {
        static let gradientHeight = 118.0
        static let verdana = "Verdana"
        static let search = "Search..."
        static let filter = "filter"
        static let rectPrice = "rectPrice"
        static let totalPrice = "Your total price"
        static let minus = "minus"
        static let plus = "plus"
        
    }
    
    @ObservedObject var  goodsViewModel = GoodsViewModel()
    
    @State var textFild = ""
    @State var quantities = [Int]()
    
    var body: some View{
        VStack {
            ZStack {
                LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .leading, endPoint: .trailing)
                    .frame(height: Constants.gradientHeight)
                    .ignoresSafeArea()
                    .frame(height: 10)
                searchTextFieldView
                searchAndFilterView
            }
            Spacer()
            sumView
                .padding().frame(height: 80)
            scrollView
        }
        .navigationBarBackButtonHidden(true)
    }
    var searchTextFieldView: some View {
        HStack {
            TextField(Constants.search, text: $textFild)
                .padding(.leading, 40)
                .frame(width: 312, height: 48)
                .background(.white)
                .cornerRadius(24)
        }
    }
    
    var searchAndFilterView: some View {
        HStack {
            Image(.search)
                .padding(.leading, 50)
            Spacer()
            NavigationLink(destination: FiltersView()) {
                Image(Constants.filter)
                    .padding(.trailing, 10)
            }
        }
    }
    
    var sumView: some View {
        ZStack {
            Image(Constants.rectPrice)
                .offset(x: 46)
            HStack {
                Text(Constants.totalPrice)
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                Text("\(goodsViewModel.sumPrice)")
                    .font(.custom(Constants.verdana, size: 22))
                    .bold()
                    .foregroundStyle(.gray)
            }
        }
    }
    
    var scrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(goodsViewModel.goods.indices, id: \.self) { furniture in
                VStack {
                    HStack {
                        Image(goodsViewModel.goods[furniture].nameImage)
                            .frame(width: 140, height: 140)
                        
                        VStack(alignment: .leading) {
                            Text(goodsViewModel.goods[furniture].nameText)
                                .font(.custom(Constants.verdana, size: 24))
                                .bold()                                .foregroundColor(.gray)
                            
                            HStack {
                                Text("$\(goodsViewModel.goods[furniture].price)")
                                    .font(.custom(Constants.verdana, size: 24))
                                    .bold()
                                    .foregroundStyle(.greenCost)
                                
                                Text("$\(goodsViewModel.goods[furniture].lastPrice)")
                                    .foregroundStyle(.gray)
                                    .font(.custom(Constants.verdana, size: 24))
                                    .strikethrough(true, color: .black)
                            }
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 24)
                                        .frame(width: 115, height: 40)
                                        .foregroundColor(.goodsBackground)
                                    HStack {
                                        Button(action: {
                                            goodsViewModel.plusPrice(item: furniture)
                                        }) {
                                            Image(systemName: Constants.minus)
                                        }
                                        Text("\(goodsViewModel.goods[furniture].amount)")
                                            .padding()
                                        Button(action: {
                                            goodsViewModel.minusPrice(item: furniture)
                                            
                                        }) {
                                            Image(systemName: Constants.plus)
                                        }
                                    }
                                    .foregroundColor(.gray)
                                    .font(.custom(Constants.verdana, size: 18))
                                    .bold()
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        goodsViewModel.goods[furniture].isBool.toggle()
                    }
                    .sheet(isPresented: $goodsViewModel.goods[furniture].isBool, content: {
                        DetailedView(productDetailModel: goodsViewModel.goods[furniture])
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    GoodsView()
}
