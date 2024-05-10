//
//  FiltersView.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 09.05.2024.
//

import SwiftUI

struct FiltersView: View {
    
    private enum Constants {
        static let verdana = "Verdana"
        static let backImage = "chevron.left"
        static let rightImage = "chevronRight"
        static let title = "Filters"
        static let category = "Category"
        static let more = "More"
        static let prices = "Prices"
        static let color = "Color -"
        static let bedIcon = "bedIcon"
        static let sofaIcon = "sofaIcon"
        static let chairIcon = "chairIcon"
        static let dollarSign = "$"
        static let priceRange = 500.0...5000.0
        static let step = 500.0
        static let currentPrice = 3500.0
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var filterViewModel = FilterViewModel()
    
    @State private var customSelection: ClosedRange<CGFloat> = 1000...5000
    @State var columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
    ]
    
    @State private var priceProgress = Constants.currentPrice
    
    var icons = [Constants.bedIcon, Constants.sofaIcon, Constants.chairIcon]
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(colors:
                                [.lightGreen,
                                 .darkGreen],
                               startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .all)
                .frame(height: 70)

            }
            headerView
            categoryView
            pricesSliderView
            colorsView
            Spacer().frame(height: 28)
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
                    self.presentationMode.wrappedValue.dismiss()

                }) {
                    Image(systemName: Constants.backImage)
                        .foregroundColor(.white)
                }
            }
        }
        Spacer()
    }
    
    var headerView: some View {
        HStack {
            Text(Constants.category)
                .font(.custom(Constants.verdana, size: 24))
                .bold()
                .foregroundStyle(.gray)
            Spacer()
            HStack {
                Text(Constants.more)
                    .font(.custom(Constants.verdana, size: 24))
                    .bold()
                    .foregroundStyle(.lightGray)
                Button(action: {}) {
                    Image(Constants.rightImage)
                }
                .padding()
            }
        }
    }
    
    var categoryView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(icons.indices, id: \.self) { element in
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 120, height: 80)
                            .shadow(radius: 1, x: 2, y: 4)
                            .foregroundColor(.goodsBackground)
                            .padding(.bottom)
                        Image(icons[element])
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
    }
    
    private var pricesSliderView: some View {
            VStack(alignment: .leading) {
                Text(Constants.prices)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                    .foregroundStyle(.gray)
                    .padding(.leading)
                Slider(value: $priceProgress, in: Constants.priceRange, step: Constants.step)
                    .padding(.horizontal)
                    .overlay(
                        Text("$\(Int(priceProgress))")
                            .foregroundColor(.white)
                            .font(.headline)
                            .offset(x: sliderOffset(for: priceProgress))
                    )
                
                HStack {
                    let minAmount = String(Int(Constants.priceRange.lowerBound))
                    let maxAmount = String(Int(priceProgress))
                    Text(Constants.dollarSign + minAmount)
                    Spacer()
                    Text(Constants.dollarSign + maxAmount)
                }
                .padding(.horizontal)
                .font(.system(size: 18))
                .offset(y: -10)
                
                HStack {
                    Text("Color -")
                        .font(.custom(Constants.verdana, size: 24))
                        .bold()
                        .foregroundStyle(.gray)
                        .padding()
                    Text(filterViewModel.colorName)
                        .padding(.all)
                        .font(.custom(Constants.verdana, size: 24))
                        .bold()
                        .foregroundStyle(.gray)
                    Spacer()
                }
            }
    }
    
    var colorsView: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(filterViewModel.colors.indices, id: \.self) { index in
                makeCircleSectionColor(color: filterViewModel.colors[index], index: index)
            }
        }
    }
    
    func sliderOffset(for value: CGFloat) -> CGFloat {
        let sliderWidth = UIScreen.main.bounds.width - 32
        let range = Constants.priceRange.upperBound - Constants.priceRange.lowerBound
        let progress = (value - Constants.priceRange.lowerBound) / range
        let offset = progress * sliderWidth
        return offset
    }

    
    func makeCircleSectionColor(color: String, index: Int) -> some View {
        Button {
            filterViewModel.makeColor(index)
        } label: {
            Circle()
                .frame(width: 49, height: 40)
                .foregroundColor(Color(color))
                .overlay {
                    Circle()
                        .stroke(.gray)
                }
        }
    }
    
}
#Preview {
    FiltersView()
}
