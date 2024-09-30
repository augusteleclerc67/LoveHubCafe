//
//  ProfileView.swift
//  LofeHubCafe
//
//  Created by D K on 26.09.2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @State var person: RealmPerson?
    
    @State var age = ""
    @State var phone = ""
    @State var height = ""
    @State var find = ""
    @State var hobby = ""
    @State private var selectedImageData: Data?
    @State var isSettingsShown = false
    
    @State private var selectedItem: PhotosPickerItem?
    
    @State var snapImage: UIImage?
    @State var isTakingSnapshot = false
    @State var isSharingShown = false
    @State var alerted = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                if !isTakingSnapshot {
                    HStack {
                        Text("Profile")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .black))
                        
                        Spacer()
                        
                        Button {
                            if !age.isEmpty && !hobby.isEmpty {
                                isTakingSnapshot.toggle()
                                snapImage = createSnapshot()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    isTakingSnapshot.toggle()
                                    isSharingShown.toggle()
                                }
                            } else {
                                alerted.toggle()
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        
                        Button {
                            isSettingsShown.toggle()
                        } label: {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                }
             
                
                ScrollView {
                    VStack {
                        
                        ZStack {
                            if selectedImageData == nil {
                                Circle()
                                    .frame(width: 250, height: 250)
                                Image(systemName: "person")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 92, weight: .regular))
                            }
                            
                            if let selectedImageData,
                               let uiImage = UIImage(data: selectedImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 250, height: 250)
                                    .clipShape(Circle())
                            }
                            
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                        .overlay {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    
                                    PhotosPicker(
                                        selection: $selectedItem,
                                        matching: .images,
                                        photoLibrary: .shared()) {
                                            Text("+")
                                        }
                                        .foregroundColor(.white)
                                        .font(.system(size: 42))
                                }
                            }
                            
                            
                        }
                        if authViewModel.currentuser != nil {
                            Text("\(authViewModel.currentuser?.name ?? "")")
                                .padding()
                                .font(.system(size: 32, weight: .black))
                                .foregroundColor(.white)
                                .frame(width: size().width - 40)
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundColor(.black)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(.orange)
                                        }
                                }
                                .padding(.horizontal)
                                .padding(.top)
                            
                            Text(authViewModel.currentuser?.email ?? "")
                                .padding()
                                .font(.system(size: 22, weight: .black))
                                .foregroundColor(.white)
                                .frame(width: size().width - 40)
                                .background {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundColor(.black)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(lineWidth: 2)
                                                .foregroundColor(.orange)
                                        }
                                }
                                .padding(.horizontal)
                                .padding(.top)
                        }
                        
                        if !isTakingSnapshot {
                            Text("You can enter your information below to use the cafe's services, as well as for the Share Profile function.")
                                .font(.system(size: 12, weight: .light))
                                .foregroundStyle(.gray)
                                .padding()
                        }
                        
                        TextField("", text: $age, prompt: Text(person?.age ?? "Your age").foregroundColor(.white))
                            .padding()
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .frame(width: size().width - 40)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.black)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.orange)
                                    }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        
                        TextField("", text: $phone, prompt: Text(person?.phone ?? "Phone Number").foregroundColor(.white))
                            .padding()
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .frame(width: size().width - 40)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.black)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.orange)
                                    }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        
                        TextField("", text: $height, prompt: Text(person?.height ?? "Your height").foregroundColor(.white))
                            .padding()
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .frame(width: size().width - 40)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.black)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.orange)
                                    }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        
                        TextField("", text: $find, prompt: Text(person?.find ?? "Who are you looking for").foregroundColor(.white))
                            .padding()
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .frame(width: size().width - 40)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.black)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.orange)
                                    }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        
                        TextField("", text: $hobby, prompt: Text(person?.hobby ?? "Your Hobbies").foregroundColor(.white))
                            .padding()
                            .font(.system(size: 24, weight: .light))
                            .foregroundColor(.white)
                            .frame(width: size().width - 40)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.black)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.orange)
                                    }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        
                        if isTakingSnapshot {
                            VStack {
                                
                            }
                            .padding(.top, 150)
                        }
                        
                        if !isTakingSnapshot {
                            Button {
                                StorageManager.shared.createOrUpdatePerson(age: age, phone: phone, height: height, find: find, hobby: hobby, image: selectedImageData)
                            } label: {
                                Text("save".uppercased())
                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.black)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.orange)
                                    }
                            }
                            .padding(.bottom, 100)
                            .padding(.top, 40)
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .black))
                        }
                        
                    
                        
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.bottom, 80)
                
            }
        }
        .fullScreenCover(isPresented: $isSettingsShown) {
            SettingsView()
                .environmentObject(authViewModel)
        }
        .fullScreenCover(isPresented: $isSharingShown) {
            if let image = snapImage {
                ShareView(image: image)
            }
        }
        .onAppear {
            if let person = StorageManager.shared.persons.first {
                self.person = person
                selectedImageData = person.image
                age = person.age
                phone = person.phone
                height = person.height
                find = person.find
                hobby = person.hobby
            }
        }
        .alert("Please fill in all fields", isPresented: $alerted) {
            Button {
                
            } label: {
                Text("OK")
                    .foregroundStyle(.black)
            }
        }
    }
    
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
