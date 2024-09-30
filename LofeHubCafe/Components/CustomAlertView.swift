//
//  CustomAlertView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI

struct CustomAlertView: View {
    
    @State var isShown = false
    var completion: () -> ()
    
    var body: some View {
        Rectangle()
            .frame(width: size().width - 40, height: 250)
            .cornerRadius(12)
            .blur(radius: 3)
            .foregroundColor(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.semiOrange)
                
                if !isShown {
                    ProgressView()
                        .controlSize(.large)
                        .colorMultiply(.semiOrange)
                } else {
                    VStack {
                        Text("The reservation message has been sent. You will be contacted at the number or email you provided.")
                            .foregroundStyle(.black)
                            .font(.system(size: 22, weight: .light))
                            .padding(.horizontal)
                        
                        Button {
                            completion()
                        } label: {
                            Text("OK")
                                .foregroundColor(.black)
                        }
                        .padding(.top)
                    }
                    
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShown.toggle()
                }
            }
    }
}

#Preview {
    CustomAlertView(){}
        
}
