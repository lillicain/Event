//
//  EditScreen.swift
//  EventfulApp
//
//  Created by Lilli Cain on 10/21/24.
//

import SwiftUI
import PhotosUI

struct EditScreen: View {
    
    @AppStorage("appearance") var appearance: Bool = false
    @AppStorage("backgroundColors") var backgroundColors: String = ""
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @StateObject var editUserViewModel: EditUserViewModel
    
    init(user: User) {
        self._editUserViewModel = StateObject(wrappedValue: EditUserViewModel(user: user))
    }
    
    @State var size: CGFloat = 17.5
    @State var backgroundColor = AuthenticationViewModel().backgroundColor
    
    @State var backgroundColorSelected = ["0030FF", "CCFF00", "FF3B5B", "480CA8", "FF4500"]
    
    var body: some View {
        ZStack {
            VStack {
                PhotosPicker(selection: $editUserViewModel.selectedImage) {
                    VStack {
                        if let image = editUserViewModel.profileImage {
                            image
                                .resizable()
                                .background(Color(.systemGray))
                                .clipShape(Circle())
                                .padding()
                            
                        } else {
                            ZStack {
                                Circle()
                                    .frame(width: 135)
                                    .foregroundColor(backgroundColor)
                                    .onAppear {
                                        backgroundColor = authenticationViewModel.blue[0]
                                    }
                                Circle()
                                    .frame(width: 130)
                                    .foregroundColor(.white)
                                
                                ZStack {
                                    ProfileImageManager(user: editUserViewModel.user, size: .large)
                                    
                                }
                            }
                        }
                        Text("Edit Profile Picture")
                            .fontWeight(.semibold)
                            .padding(5)
                        
                    }
                    .padding(.vertical)
                }
                
                Form {
                    Section {
                        userInformation
                    }
                    
                    Section {
                        userInformationTwo
                        
                    }
                    Section {
                        userInformationThree
                    }
                    
                    
                    Section {
                        userInformationFour
                            .padding(5)
                    }
                    
                    
                    Section {
                        userInformationFive
                            .padding(5)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            try await editUserViewModel.updateUserData()
                        }
                    } label: {
                        Text("Save")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .background(LinearGradient(colors: [.clear, .clear, .clear, authenticationViewModel.violet[0].opacity(0.15)], startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all))
    }
}

extension EditScreen {
    var userInformation: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(editUserViewModel.user.username)
                    .font(FontOne.medium)
                    .foregroundColor(Color(.systemGray3))
                    .offset(x: -3.5, y: 3.5)
                    .kerning(2.5)
                    .overlay {
                        Text(editUserViewModel.user.username)
                            .font(FontOne.medium)
                            .foregroundColor(authenticationViewModel.backgroundColor)
                            .kerning(2.5)
                    }
                
                Text(editUserViewModel.user.name ?? "")
                
                Text(editUserViewModel.user.email)
                    .lineLimit(1)
            }
            .font(.system(size: size))
            .fontWeight(.semibold)
            .foregroundColor(backgroundColor)
            .kerning(0.5)
        }
    }
    
    var userInformationTwo: some View {
        VStack {
            Toggle(appearance ? "Dark Mode" : "Light Mode", isOn: $appearance)
                .tint(Color(.systemGreen))
                .padding(5)
                .font(.system(size: size))
                .fontWeight(.semibold)
                .modifier(DarkModeViewModifier())
                .onTapGesture {
                    appearance.toggle()
                }
        }
    }
    
    var userInformationThree: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(backgroundColorSelected.hexToColorArray(), id: \.self) { color in
                    Button(action: {
                        backgroundColor = color
                        authenticationViewModel.backgroundColor = color
                        backgroundColors = color.hexString!
                        backgroundColors = color.ColorToString()
                        
                    }, label: {
                        withAnimation(.spring()) {
                            Circle()
                                .fill(color)
                                .frame(width: 50, height: 50)
                                .padding(3.5)
                        }
                    })
                }
            }
        }
    }
    
    var userInformationFour: some View {
        VStack {
            Button {
                authenticationViewModel.changeSignUpState(to: .pangea)
                
                AuthenticationViewModel.shared.signOut()
                
                Task {
                    do {
                        try editUserViewModel.signOut()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                Task {
                    authenticationViewModel.signOut()
                    authenticationViewModel.currentUser = nil
                }
            } label: {
                Text("Sign Out")
                    .fontWeight(.semibold)
            }
            .padding(.all, 5)
        }
    }
    
    var userInformationFive: some View {
        VStack {
            Button(role: .destructive) {
                authenticationViewModel.changeSignUpState(to: .pangea)
                Task {
                    do {
                        try await editUserViewModel.deleteAccount()
                        try await authenticationViewModel.deleteAccount()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Delete Account")
                    .fontWeight(.semibold)
            }
            .padding(.all, 5)
        }
    }
}


