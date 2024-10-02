//
//  AuthView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var viewModel: AuthViewModel
    
    @State var email = ""
    @State var password = ""
    
    @State private var isAlertShown = false
    @State private var switcher = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                BackgroundView()
                
                ScrollView {
                    VStack {
                        
                        Image("heart")
                            .resizable()
                            .frame(width: 250, height: 250)
                        
                        Text("LOVE ")
                            .foregroundColor(.white)
                        + Text("HUB")
                            .foregroundColor(.semiOrange)
                        + Text(" CAFE")
                            .foregroundColor(.white)
                        
                        TextField("", text: $email, prompt: Text("E-mail").foregroundColor(.black.opacity(0.6)))
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding()
                            .padding(.vertical, 5)
                            .foregroundColor(.black)
                            .tint(.black)
                            .background {
                                Rectangle()
                                    .cornerRadius(16)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        SecureField("", text: $password, prompt: Text("Password").foregroundColor(.black.opacity(0.6)))
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .padding()
                            .padding(.vertical, 5)
                            .foregroundColor(.black)
                            .tint(.black)
                            .background {
                                Rectangle()
                                    .cornerRadius(16)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)
                        
                        Button {
                            Task {
                                try await viewModel.signIn(email: email, password: password)
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("LOG IN")
                                .foregroundStyle(.black)
                                .font(.system(size: 25, weight: .black))
                        }
                        .padding()
                        .padding(.horizontal, 30)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.top)
                        
                        Button {
                            Task {
                                await viewModel.signInAnonymously()
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("ANONYMOUS LOG IN")
                                .foregroundStyle(.black)
                                .font(.system(size: 18, weight: .black))
                        }
                        .padding()
                        .padding(.horizontal, 30)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.top)
                        
                        NavigationLink {
                            RegistrationView(viewModel: viewModel)
                        } label: {
                            Text("YOU DON'T HAVE AN ACCOUNT YET? ")
                                + Text("SIGN UP")
                                    .underline()
                                    .foregroundColor(.blue)
                                + Text(" NOW.")
                        }
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.top)
                        
                        Spacer()
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
            .overlay {
                if isAlertShown {
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(.white.opacity(0.1))
                        
                        if switcher {
                            Rectangle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white.opacity(0.9))
                                .blur(radius: 5)
                                .cornerRadius(24)
                                .shadow(color: .white.opacity(0.5), radius: 5)
                                .overlay {
                                    ProgressView()
                                        .tint(.semiOrange)
                                        .controlSize(.large)
                                }
                        } else {
                            Rectangle()
                                .frame(width: 290, height: 250)
                                .foregroundColor(.white.opacity(0.9))
                                .blur(radius: 5)
                                .cornerRadius(24)
                                .shadow(color: .white.opacity(0.5), radius: 5)
                                .overlay {
                                    VStack {
                                        Text("Incorrect email or password.")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal)
                                        
                                        Button {
                                            withAnimation {
                                                isAlertShown = false
                                                switcher = true
                                            }
                                        } label: {
                                           Image(systemName: "xmark")
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.black)
                                                .bold()
                                        }
                                        .padding(.top, 30)
                                    }
                                   
                                }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            switcher = false
                        }
                    }
                }
            }
        }
        .tint(.white)
        .preferredColorScheme(.dark)
    }
}


#Preview {
    AuthView(viewModel: AuthViewModel())
}
