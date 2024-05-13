//
//  StartScreen.swift
//  Sofa_Elda900
//
//  Created by Vermut xxx on 07.05.2024.
//

import SwiftUI

struct StartScreenView: View {
    
    private enum Constants {
        static let title = "169.ru"
        static let verdana = "Verdana"
        static let verdanaBold = "verdana-Bold"
        static let getStarted = "Get Started"
        static let dontHaveAccount = "Don't have an account?"
        static let signIn = "Sign in here"
        static let imageError = "Image error"
        static let questionmark = "questionmark"
        static let developersInfo = "東京の夜景は美しいです。高いビルがライトアップされ、夜空には星が輝いています。人々は街を歩き、レストランやバーで楽しい時間を過ごしています。夜の都市の喧騒と静けさが絶妙に混ざり合い、独特の雰囲気を作り出しています。"
        static let getStartedOffsetX = -3500.0
        static let signInOffsetX = 3500.0
    }
    
    @State var isButtonShown = false
    @State var isSignInButtonShown = false
    @State var isDeveloperWindowShown = false
    @State var isNavigationActive = false
    @State var isLoading = false
    
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                withAnimation {
                    isDeveloperWindowShown = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    withAnimation {
                        isDeveloperWindowShown = false
                    }
                })
            }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(colors: [.lightGreen, .darkGreen], startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(height: 40)
                
                Text(Constants.title)
                    .font(.custom(Constants.verdana, size: 40))
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                
                Spacer()
                    .frame(height: 60)
                
                Image(.logo)
                
                Spacer()
                
                HStack {
                    Spacer()
                    ZStack {
                        ProgressView()
                            .opacity(isLoading ? 1 : 0)
                        Text(Constants.getStarted)
                            .opacity(isLoading ? 0 : 1)
                        .foregroundStyle(.linearGradient(colors: [.darkButton, .lightButton], startPoint: .top, endPoint: .bottom))                    }
                    Spacer()
                }
                .background(
                    
                    Capsule()
                        .fill(.white)
                        .frame(height: 55)
                        .padding(.horizontal, 45)
                        .shadow(radius: 4, y: 4)
                    
                )
                .opacity(isButtonShown ? 1 : 0)
                .offset(x: isButtonShown ? 0 : Constants.getStartedOffsetX)
                .onTapGesture {
                    startLoading()
                }
                .gesture(longPressGesture)
                
                NavigationLink(
                    destination: ShopTabView(),
                    isActive: $isNavigationActive,
                    label: {
                        EmptyView()
                    })
                
                Spacer()
                    .frame(height: 75)
                
                Text(Constants.dontHaveAccount)
                    .font(.custom(Constants.verdana, size: 16))
                    .padding(.zero)
                    .opacity(isButtonShown ? 1 : 0)
                
                Spacer()
                    .frame(height: 12)
                
                Button(action: {}, label: {
                    
                    VStack (spacing: 8) {
                        NavigationLink(destination: AuthorizationView()) {
                            Text(Constants.signIn)
                                .font(.custom(Constants.verdana, size: 28))
                                .fontWeight(.bold)
                                .opacity(isSignInButtonShown ? 1 : 0)
                                .offset(x: isSignInButtonShown ? 0 : Constants.signInOffsetX)
                        }
                        
                        Divider()
                            .overlay(.lightGray)
                            .frame(width: 180)
                    }
                })
                
                Spacer()
                    .frame(height: 121)
                
            }
            .foregroundStyle(.gray)
            .blur(radius: isDeveloperWindowShown ? 10 : 0)
            
            developerView
            
        }
        .onAppear {
            withAnimation(.spring()) {
                isButtonShown = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring()) {
                    isSignInButtonShown = true
                }
            }
        }
        
    }
    
    private var developerView: some View {
        Text(Constants.developersInfo)
            .font(.custom(Constants.verdanaBold, size: 20))
            .foregroundStyle(.gray)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.lightGray))
            .opacity(isDeveloperWindowShown ? 1 : 0)
    }
    
    private func startLoading() {
        withAnimation {
            isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            isNavigationActive = true
        })
    }
}


#Preview {
    ContentView()
}
