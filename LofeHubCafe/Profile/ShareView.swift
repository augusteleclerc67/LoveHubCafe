//
//  ShareView.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI

struct ShareView: View {
    @Environment(\.dismiss) var dismiss
    
    var image: UIImage
    @State var showImageSheet = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
    
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
                Text("Share Profile")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                Spacer()
            }
            
            ScrollView {
                VStack {
                    Image(uiImage: image)
                        .resizable()
                    
                    Button {
                        showImageSheet.toggle()
                    } label: {
                        Text("Share".uppercased())
                            .foregroundColor(.white)
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
            }
            .padding(.top, 50)
        }
        .imageShareSheet(isPresented: $showImageSheet, image: image)
    }
}

#Preview {
    ShareView(image: UIImage(named: "heart")!)
}

struct ImageShareSheet: UIViewControllerRepresentable {
    let images: UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let activityViewController = UIActivityViewController(activityItems: [images], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.addToReadingList, .assignToContact]
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension View {
    func imageShareSheet(
        isPresented: Binding<Bool>,
        image: UIImage
    ) -> some View {
        return sheet(isPresented: isPresented, content: { ImageShareSheet(images: image) } )
    }
}
