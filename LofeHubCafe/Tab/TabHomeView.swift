//
//  HomeView.swift
//  LofeHubCafe
//
//  Created by D K on 25.09.2024.
//

import SwiftUI

enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case home, entertainment, club, profile
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .entertainment:
            return "heart.rectangle.fill"
        case .club:
            return "newspaper.fill"
        case .profile:
            return "person.fill"
        }
    }
}

struct TabHomeView: View {
    
    @State private var selectedTab = Tab.home
    @Namespace var namespace
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
               
                TabView(selection: $selectedTab) {
                    
                   HomeView()
                        .environmentObject(authViewModel)
                        .tag(Tab.home)
                    
                    EntertainmentView()
                        .tag(Tab.entertainment)
                    
                    AboutView()
                        .tag(Tab.club)
                    
                    ProfileView()
                        .environmentObject(authViewModel)
                        .tag(Tab.profile)
                }
                
                HStack(spacing: 0) {
                    TabButton(tab: .home, selectedTab: $selectedTab, namespace: namespace)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(tab: .entertainment, selectedTab: $selectedTab, namespace: namespace)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(tab: .club, selectedTab: $selectedTab, namespace: namespace)
                    
                    Spacer(minLength: 0)
                    
                    TabButton(tab: .profile, selectedTab: $selectedTab, namespace: namespace)
                }
                .padding(.horizontal, 40)
            }
        }
        .tint(.white)
    }
}

#Preview {
    TabHomeView()
        .environmentObject(AuthViewModel())
}

private struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    var namespace: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation {
                selectedTab = tab
                
            }
        } label: {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                        .shadow(radius: 10)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 5)
                                .foregroundColor(.orange.opacity(0.7))
                        }
                        .offset(y: -10)
                        .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                        .animation(.spring(), value: selectedTab)
                }
                
                Image(systemName: tab.icon)
                    .font(.system(size: 26, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? .init(white: 0.9) : .gray)
                    .scaleEffect(isSelected ? 1 : 0.8)
                    .offset(y: isSelected ? -10 : 0)
                    .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                    .frame(width: 50, height: 50)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var isSelected: Bool {
        selectedTab == tab
    }
}
