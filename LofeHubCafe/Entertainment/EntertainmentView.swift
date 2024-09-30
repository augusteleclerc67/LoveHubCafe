//
//  EntertainmentView.swift
//  LofeHubCafe
//
//  Created by D K on 26.09.2024.
//

import SwiftUI

struct EntertainmentView: View {
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150, maximum: 250))
    ]
    var selection = ["100 \nQuestions", "I have \nnever", "Truth or \ndare", "Fun \nfacts", "Who \nam i", "Find the \nmatch"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    HStack {
                        Text("Entertainment")
                            .foregroundColor(.white)
                            .font(.system(size: 32, weight: .black))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVGrid(columns: adaptiveColumn, spacing: 30) {
                            ForEach(selection, id:\.self) { type in
                                NavigationLink {
                                    switch type {
                                    case "100 \nQuestions": QuestionsView().navigationBarBackButtonHidden()
                                    case "I have \nnever": HaveNever().navigationBarBackButtonHidden()
                                    case "Truth or \ndare": TruthOrDateView().navigationBarBackButtonHidden()
                                    case "Fun \nfacts": FunFactView().navigationBarBackButtonHidden()
                                    case "Who \nam i": WhoAmIView().navigationBarBackButtonHidden()
                                    case "Find the \nmatch": MatchView().navigationBarBackButtonHidden()
                                    default: QuestionsView().navigationBarBackButtonHidden()
                                    }
                                        
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.white.opacity(0.1))
                                            .frame(width: 170, height: 170)
                                            .cornerRadius(12)
                                        
                                        VStack {
                                            
                                            
                                            Text(String(describing: type).uppercased())
                                                .foregroundStyle(Color.white)
                                                .font(.system(size: 22, weight: .bold))
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 100)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.bottom, 70)
                }
            }
        }
    }
}

#Preview {
    EntertainmentView()
}
