//
//  BackgroundView.swift
//  LofeHubCafe
//
//  Created by D K on 25.09.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            .ignoresSafeArea()
            
            GeometryReader { proxy in
                let size = proxy.size
                Color.black
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color.orange)
                    .padding(50)
                    .blur(radius: 120)
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                
                Circle()
                    .fill(Color.orange)
                    .padding(50)
                    .blur(radius: 150)
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                
                
                Circle()
                    .fill(Color.orange)
                    .padding(50)
                    .blur(radius: 90)
                    .offset(x: size.width / 1.8, y: size.height / 3)
            }
        }
    }
}

#Preview {
    BackgroundView()
}
