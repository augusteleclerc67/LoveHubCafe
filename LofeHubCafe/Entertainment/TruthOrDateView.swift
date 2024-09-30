//
//  TruthOrDateView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI

struct TruthOrDateView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BackgroundView()
    
            //MARK: - TITLE
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.top, 13)
                .padding(.leading, 20)
                Spacer()
            }
            VStack {
                Text("Truth Or Dare")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                Spacer()
            }
            
            ScrollView {
                Text(DataManager.shared.truthRules)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .light))
                    .padding()
                    .background {
                        Rectangle()
                            .cornerRadius(12)
                            .opacity(0.4)
                            .blur(radius: 3)
                            .foregroundColor(.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.semiOrange)
                            }
                    }
                    .padding()
            }
            .padding(.top, 40)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    TruthOrDateView()
}
