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
        static let getStarted = "Get Started"
        static let accountQuestion = "Don't have an account?"
        static let signIn = "Sign in here"
        static let imageError = "Image error"
        static let questionmark = "questionmark"
        static let sofaPick = "https://johnlewis.scene7.com/is/image/JohnLewisRender?src=ir(JohnLewisRender/SS16_CROMWELL_LARGE_SOFA?/&obj=main/body&src=237430825&sharpen=1)$rsp-plp-port-320$"
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
                    .foregroundStyle(.white)
                
                Spacer()
                    .frame(height: 60)
                
                Image(.logo)
                AsyncImage(url: URL(string: Constants.sofaPick)) { phase in
                               switch phase {
                               case .empty:
                                   ProgressView()
                                       .tint(.accentColor)
                               case .success(let image):
                                   image
                                       .resizable()
                                       .scaledToFit()
                                       .frame(height: 177)
                                       .clipShape(RoundedRectangle(cornerRadius: 10))
                               case .failure(let error):
                                   VStack {
                                       Image(systemName: Constants.questionmark)
                                       Text(error.localizedDescription)
                                   }
                               @unknown default:
                                   fatalError(Constants.imageError)
                               }
                           }
                           .padding(.horizontal, 45)
                Spacer()

                NavigationLink(destination: DetailedView()) {
                    HStack {
                        Spacer()
                        Text(Constants.getStarted)
                            .foregroundStyle(.linearGradient(colors: [.darkButton, .lightButton], startPoint: .top, endPoint: .bottom))
                        Spacer()
                    }
                    .background(Capsule()
                        .fill(.white)
                        .frame(height: 55)
                        .padding(.horizontal, 45)
                        .shadow(radius: 4, y: 4))
                }
                Spacer()
                    .frame(height: 75)
                
                Text(Constants.accountQuestion)
                    .font(.custom(Constants.verdana, size: 16))
                    .padding(.zero)
                
                Spacer()
                    .frame(height: 12)
                
                NavigationLink(destination: AuthorizationView()) {
                    VStack (spacing: 8) {
                        Text(Constants.signIn)
                            .font(.custom(Constants.verdana, size: 28))
                            .fontWeight(.bold)
                        
                        Divider()
                            .overlay(.lightGreen)
                            .frame(width: 180)
                    }
                }
                Spacer()
                    .frame(height: 121)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ContentView()
}
