//
//  CarouselView.swift
//  LofeHubCafe
//
//  Created by D K on 27.09.2024.
//

import SwiftUI

struct ImageItem: Identifiable {
    var id: Int
    var image: String
}

class CarouselViewModel: ObservableObject {
    @Published var items: [ImageItem]
    
    let images = ["1", "2", "3", "4"]
    
    init() {
        items = []
        for i in 0..<images.count {
            let new = ImageItem(id: i, image: images[i])
            items.append(new)
        }
    }
}


struct CarouselView: View {
    @StateObject var viewModel = CarouselViewModel()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        
        ZStack {
            ForEach(viewModel.items, id: \.id) { item in
                Image(item.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .cornerRadius(12)
                    .scaleEffect(1.0 - abs(getdistance(item.id)) * 0.2 )
                    .opacity(1.0 - abs(getdistance(item.id)) * 0.3 )
                    .offset(x: getXOffset(item.id), y: 0)
                    .zIndex(1.0 - abs(getdistance(item.id)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(viewModel.items.count))
                        snappedItem = draggingItem
                    }
                }
        )
    }
    
    func getdistance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(viewModel.items.count))
    }
    
    func getXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(viewModel.items.count) * getdistance(item)
        return sin(angle) * 200
    }
}

#Preview {
    CarouselView()
}
