//
//  RootView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabHomeView()
                    .environmentObject(viewModel)
            } else {
                AuthView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    RootView()
}
