//
//  SettingsView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var showingMailWithError = false
    @State private var showingMailWithSuggestion = false
    
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
                Text("Settings")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                Spacer()
            }
            
            ScrollView {
                VStack {
                    Button {
                        if MFMailComposeViewController.canSendMail() {
                            showingMailWithError.toggle()
                        } else {
                        }
                    } label: {
                        Text("Report a bug")
                    }
                    .sheet(isPresented: $showingMailWithError) {
                        MailComposeView(isShowing: $showingMailWithError, subject: "Error message", recipientEmail: "agnesschulz06@gmail.com", textBody: "")
                    }
                    .foregroundColor(.white)
                    .frame(width: size().width - 80)
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
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Button {
                        if MFMailComposeViewController.canSendMail() {
                            showingMailWithSuggestion.toggle()
                        } else {
                        }
                    } label: {
                        Text("Suggest improvement")
                    }
                    .sheet(isPresented: $showingMailWithSuggestion) {
                        MailComposeView(isShowing: $showingMailWithSuggestion, subject: "Improvement suggestion", recipientEmail: "agnesschulz06@gmail.com", textBody: "")
                    }
                    .foregroundColor(.white)
                    .frame(width: size().width - 80)
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
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Button {
                        openPrivacyPolicy()
                    } label: {
                        Text("Privacy Policy")
                    }
                    .foregroundColor(.white)
                    .frame(width: size().width - 80)
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
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Button {
                        authViewModel.signOut()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: size().width - 80, height: 70)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                            
                            Text("Sign Out")
                                .foregroundStyle(.white)
                                .font(.system(size: 22, weight: .semibold, design: .serif))
                        }
                    }
                    .padding(.bottom, authViewModel.currentuser == nil ? 120 : 0)
                    .padding(.top, 40)
                    
                    if authViewModel.currentuser != nil {
                        Button {
                            
                        } label: {
                            Text("Delete Account")
                                .foregroundStyle(.red)
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 120)
                    }
                }
            }
            .padding(.top, 50)
            .scrollIndicators(.hidden)
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://lofehubcafe.shop/com.LofeHubCafe/Auguste_Leclerc/privacy") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
