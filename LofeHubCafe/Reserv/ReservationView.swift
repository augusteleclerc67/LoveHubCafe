//
//  ReservationView.swift
//  LofeHubCafe
//
//  Created by D K on 26.09.2024.
//

import SwiftUI

struct ReservationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var name = ""
    @State var phone = ""
    @State var email = ""
    @State var date = Date()
    @State var selectedType = "Man"
    @State var isShown = false
    
    @State var alerted = false
    
    var types = ["Man", "Woman", "Other"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    Spacer()
                }
                .padding(.top, 12)
                .padding(.leading, 20)
                Spacer()
            }
            
            VStack {
                Text("Reservation")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .black))
                
                ScrollView {
                    VStack(spacing: 20) {
                        TextField("", text: $name, prompt: Text("Name").foregroundColor(.gray))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.semiOrange)
                            }
                        
                        TextField("", text: $phone, prompt: Text("Phone").foregroundColor(.gray))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.semiOrange)
                            }
                        
                        TextField("", text: $email, prompt: Text("Email").foregroundColor(.gray))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.semiOrange)
                            }
                        
                        DatePicker("Date", selection: $date, in: Date()...)
                            .foregroundColor(.white)
                            .colorMultiply(.white)
                            .tint(.white)
                            .preferredColorScheme(.dark)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.semiOrange)
                            }
                        
                        HStack {
                            Text("I am looking for a")
                            
                            Spacer()
                            
                            Picker("", selection: $selectedType) {
                                ForEach(types, id: \.self) { type in
                                    Text(type)
                                        
                                }
                            }
                            .tint(.semiOrange)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 2)
                                .foregroundColor(.semiOrange)
                        }
                            
                        
                        Button {
                            if !name.isEmpty && !email.isEmpty {
                                withAnimation {
                                    isShown.toggle()
                                }
                            } else {
                                alerted.toggle()
                            }
                            
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 70)
                                    .cornerRadius(12)
                                    .foregroundColor(.orange.opacity(0.3))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.semiOrange)
                                    }
                                
                                Text("Make a reserve".uppercased())
                                    .font(.system(size: 22, weight: .black))
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding()
                        .padding(.top)
                    }
                   
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal)
            }
        }
        .onAppear {
            name = authViewModel.currentuser?.name ?? ""
            email = authViewModel.currentuser?.email ?? ""
        }
        .alert("Please fill in all fields", isPresented: $alerted) {
            Button {
                
            } label: {
                Text("OK")
                    .foregroundStyle(.black)
            }
        }
        .overlay {
            if isShown {
                CustomAlertView {
                    StorageManager.shared.saveReservation(date: date, name: name)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ReservationView()
        .environmentObject(AuthViewModel())
}
