//
//  QuestionsView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//


//@Environment(\.dismiss) var dismiss
//
//var body: some View {
//    ZStack {
//        BackgroundView()
//
//        //MARK: - TITLE
//        VStack {
//            HStack {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.white)
//                }
//                Spacer()
//            }
//            .padding(.top, 13)
//            .padding(.leading, 20)
//            Spacer()
//        }
//        VStack {
//            Text("100 Questions")
//                .foregroundStyle(.white)
//                .font(.system(size: 32, weight: .black))
//            Spacer()
//        }
//    }
//}

import SwiftUI

struct QuestionsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var questions: [String] = []
    @State var question = ""
    
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
                Text("100 Questions")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                Spacer()
            }
            
            VStack {
                Rectangle()
                    .frame(width: size().width - 40, height: 250)
                    .cornerRadius(12)
                    .opacity(0.4)
                    .blur(radius: 3)
                    .foregroundColor(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.semiOrange)
                        
                        Text(question)
                            .foregroundStyle(.white)
                            .font(.system(size: 22, weight: .black))
                            .padding(.horizontal)
                    }
                
                
                
                Button {
                    question = questions.randomElement() ?? ""
                } label: {
                    Text("New question".uppercased())
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
                .font(.system(size: 32, weight: .black))
                .foregroundColor(.white)
                .padding(.top, 60)
                
            }
        }
        .onAppear {
            questions = DataManager.shared.questions
            question = questions.randomElement() ?? ""
        }
    }
}

#Preview {
    QuestionsView()
}
