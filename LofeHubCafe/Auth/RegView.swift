//
//  RegView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var confirm = ""
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var isNotificationShown = false
    @State private var switched = true
    @State private var isAlerted = false
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("REGISTRATION")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .black))
                    
                    TextField("", text: $email, prompt: Text("E-mail").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top, 50)
                    
                    TextField("", text: $name, prompt: Text("Name").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    
                    SecureField("", text: $password, prompt: Text("Password").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    
                    SecureField("", text: $confirm, prompt: Text("Confirm password").foregroundColor(.black.opacity(0.6)))
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .tint(.black)
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    
                    Button {
                        if isValid {
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password, name: name)
                            }
                            withAnimation {
                                isAlerted.toggle()
                            }
                        } else {
                            withAnimation {
                                isAlerted.toggle()
                            }
                            isNotificationShown.toggle()
                        }
                    } label: {
                        Text("SIGN UP")
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
                        dismiss()
                    } label: {
                        Text("DO YOU ALREADY ")
                            .foregroundColor(.white)
                            + Text("HAVE")
                                .underline()
                                .foregroundColor(.blue)
                            + Text(" AN ACCOUNT?.")
                            .foregroundColor(.white)
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.top)
                }
            }
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.dark)
        .overlay {
            if isAlerted {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.white.opacity(0.1))
                    
                    if switched {
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
                                    Text("Incorrect data or user with this email already exists.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlerted = false
                                            switched = true
                                            
                                            email = ""
                                            password = ""
                                            name = ""
                                            confirm = ""
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
                        switched = false
                    }
                }
            }
        }
        
    }
}

extension RegistrationView: AuthViewModelProtocol {
    var isValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirm == password
        && !name.isEmpty
        
    }
}
