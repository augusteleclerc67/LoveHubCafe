//
//  HomeView.swift
//  LofeHubCafe
//
//  Created by D K on 25.09.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var isReservShown = false
    @State var reservation: RealmReservation?
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Image("heart")
                    .resizable()
                    .frame(width: 170, height: 170)
                
                Text("LOVE ")
                    .foregroundColor(.white)
                + Text("HUB")
                    .foregroundColor(.semiOrange)
                + Text(" CAFE")
                    .foregroundColor(.white)
                
                Rectangle()
                    .frame(width: size().width - 40, height: 250)
                    .cornerRadius(12)
                    .opacity(0.3)
                    .blur(radius: 3)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white)
                    }
                    .overlay {
                        if reservation == nil {
                            VStack {
                                Image(systemName: "bolt.heart")
                                    .font(.system(size: 72, weight: .ultraLight))
                                
                                Text("You have no active reservations.")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 32, weight: .ultraLight))
                            }
                        } else {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Reserve:")
                                        .font(.system(size: 22, weight: .light))
                                    Text(reservation?.code ?? "12 31 51 54")
                                        .font(.system(size: 24, weight: .bold))
                                    Text(formatDateToDayMonth(reservation?.date ?? Date()))
                                        .font(.system(size: 24, weight: .bold))
                                        .padding(.top, 10)
                                    Text(formatDateToTime(reservation?.date ?? Date()))
                                        .font(.system(size: 24, weight: .bold))
                                    Text("\(reservation?.table ?? "6")TH Table")
                                        .font(.system(size: 24, weight: .bold))
                                    
                                    Spacer()
                                }
                                .padding(.top, 30)
                                
                                Spacer()
                                
                                Rectangle()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(12)
                                    .overlay {
                                        Image(uiImage: DataManager.shared.generateQRCode(from: reservation?.code ?? "12 31 51 54"))
                                            .interpolation(.none)
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                    }
                            }
                            .padding(.horizontal)
                        }
                     
                    }
                
                Spacer()
                
                Button {
                    isReservShown.toggle()
                } label: {
                    Text("reserve a table".uppercased())
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
            }
            .font(.system(size: 32, weight: .black))
            .foregroundColor(.white)
        }
        .onAppear {
            if let reservation = StorageManager.shared.reservations.last {
                self.reservation = reservation
            }
        }
        .fullScreenCover(isPresented: $isReservShown) {
            ReservationView()
                .environmentObject(authViewModel)
                .onDisappear {
                    if let reservation = StorageManager.shared.reservations.last {
                        self.reservation = reservation
                    }
                }
        }
    }
    
    func formatDateToDayMonth(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"  // Формат: 22 April
        dateFormatter.locale = Locale(identifier: "en_US")  // Установка локали для английских названий месяцев
        return dateFormatter.string(from: date)
    }

    func formatDateToTime(_ date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"  // Формат: 08:00
        return timeFormatter.string(from: date)
    }

}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
