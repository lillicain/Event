//
//  PangeaView.swift
//  EventfulApp
//
//  Created by Lilli Cain on 10/21/24.
//

import SwiftUI

struct PangeaView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            switch authenticationViewModel.currentSignInStatus {
            case .pangea : pangeaView
            case .signIn : SignInView()
            case .signUp : SignUpView()
                
            }
        }
    }
}

extension PangeaView {
    var signUp: some View {
        ZStack {
            Button {
                authenticationViewModel.changeSignUpState(to: .signUp)
                
            } label: {
                withAnimation(.smooth) {
                    Text("Sign Up")
                        .font(FontOne.body)
                        .foregroundColor(.white)
                        .modifier(ButtonViewModifier())
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .kerning(1.5)
                        .offset(x: 0.5, y: 0.5)
                        .overlay {
                            Text("Sign Up")
                                .font(FontOne.body)
                                .kerning(1.5)
                                .foregroundColor(authenticationViewModel.green[0])
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 1.5, y: -1.5)
                        }
                }
            }
        }
    }
    
    var signIn: some View {
        ZStack {
            Button {
                authenticationViewModel.changeSignUpState(to: .signIn)
                
            } label: {
                withAnimation(.smooth) {
                    Text("Sign In")
                        .font(FontOne.body)
                        .foregroundColor(.white)
                        .modifier(ButtonViewModifier())
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .kerning(1.5)
                        .offset(x: 0.5, y: 0.5)
                        .overlay {
                            Text("Sign In")
                                .font(FontOne.body)
                                .kerning(1.5)
                                .foregroundColor(authenticationViewModel.green[0])
                                .shadow(color: .black.opacity(0.25), radius: 1.5, x: 1.5, y: -1.5)
                        }
                }
            }
        }
    }
    
    var pangeaView: some View {
        ZStack {
            LinearGradient(colors: [authenticationViewModel.blue[0], authenticationViewModel.violet[0]], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            Image(systemName: "globe")
                .resizable()
                .frame(width: 300, height: 300)
                .padding(.bottom, 395)
                .offset(x: 7.5, y: 7.5)
                .foregroundColor(authenticationViewModel.green[0])
                .overlay {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 395)
                        .shadow(color: .black.opacity(0.25), radius: 1.5, x: 1.5, y: -1.5)
                        .foregroundColor(authenticationViewModel.violet[0])
                }
            
            VStack(spacing: 100) {
                Text("PANGEA")
                    .font(FontNine.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .kerning(3.0)
                    .offset(x: -1.5, y: 1.5)
                    .overlay {
                        Text("PANGEA")
                            .font(FontNine.title)
                            .scaledToFit()
                            .foregroundColor(authenticationViewModel.green[0])
                            .kerning(3.0)
                            .shadow(color: .black.opacity(0.25), radius: 1.5, x: 1.5, y: -1.5)
                        
                    }
                    .padding(.top, 325)
                
                
                VStack(spacing: 0) {
                    signUp
                    signIn
                }
            }
            
            ZStack {
                Text("Reconnect")
                    .font(FontFour.small)
                    .padding(.top, 135)
                    .kerning(5)
                    .foregroundColor(authenticationViewModel.pink[0])
                    .offset(x: -0.5, y: -0.5)
                    .padding(.leading, 175)
                    .overlay {
                        Text("Reconnect")
                            .font(FontFour.small)
                            .padding(.top, 135)
                            .kerning(5)
                            .foregroundStyle(LinearGradient(colors: [authenticationViewModel.violet[0], authenticationViewModel.pink[0], authenticationViewModel.pink[0], authenticationViewModel.pink[0]], startPoint: .top, endPoint: .center))
                            .shadow(color: .black.opacity(0.25), radius: 0.5, x: 1.5, y: -0.5)
                            .padding(.leading, 175)
                    }
            }
        }
    }
}

