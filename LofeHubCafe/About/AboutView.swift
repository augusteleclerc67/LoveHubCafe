//
//  AboutView.swift
//  LofeHubCafe
//
//  Created by D K on 26.09.2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    Text("About")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .black))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                CarouselView()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Love Hub Cafe - Where connections are made")
                            .font(.system(size: 32, weight: .black))
                        
                        Text("Mission:")
                            .padding(.top)
                            .font(.system(size: 22, weight: .black))
                        Text("""
At Love Hub Cafe, our mission is simple: to create a warm, welcoming space where people can foster meaningful connections over a cup of coffee. We believe in the magic of spontaneous conversations and aim to bridge the gap between strangers, turning them into friends, companions, or even soulmates.
""")
                        
                        Text("Vision:")
                            .padding(.top)
                            .font(.system(size: 22, weight: .black))
                        Text("""
We envision a world where technology and human interaction harmonize. Love Hub Cafe is a place where face-to-face conversations take center stage, yet we embrace innovation by offering an app that enhances the experience, making it easier for people to connect in real life.
""")
                        
                        Text("History:")
                            .padding(.top)
                            .font(.system(size: 22, weight: .black))
                        Text("""
Founded in the heart of Cannes, Love Hub Cafe opened its doors with a unique purpose: to be more than just a cafe. Inspired by the romance and charm of the French Riviera, our founders wanted to create a space that reflects the beauty of chance encounters. What started as a simple coffeehouse has grown into a vibrant community hub, where people from all walks of life come to connect, unwind, and build relationships.
""")
                        
                        Text("What We Offer:")
                            .padding(.top)
                            .font(.system(size: 22, weight: .black))
                        Text("""
At Love Hub Cafe, customers can enjoy carefully curated coffee and artisanal treats while they meet new people. Whether it's through our interactive app, social events, or simple table reservations, we make sure every guest has the opportunity to engage with others in a relaxed, comfortable setting.
""")
                    }
                }
                .padding(.horizontal)
                .foregroundColor(.white)
                .scrollIndicators(.hidden)
                .padding(.bottom, 60)
            }
        }
    }
}

#Preview {
    AboutView()
}
