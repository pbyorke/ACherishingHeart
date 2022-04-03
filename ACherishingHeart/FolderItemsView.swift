//
//  FolderItemsView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/27/21.
//

import SwiftUI

struct FolderItemsView: View {

    @EnvironmentObject var itemsInFolder: ItemsInFolder

    var body: some View {
        VStack {
            ZStack {
                Text("Items")
                    .font(.title)
                HStack {
                    Spacer()
                    PrettyLink(image: "plus", destination: ItemsView(selecting: true)) { }
                }
            }
            List(itemsInFolder.items, id: \.id) { item in
                Text("\(item.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Swipe(symbol: "minus.square.fill", color: .red) { itemsInFolder.delete(item: item) }
                        Swipe(symbol: "arrow.down.square.fill", color: .green) { itemsInFolder.down(item: item) }
                        Swipe(symbol: "arrow.up.square.fill", color: .green) { itemsInFolder.up(item: item) }
                    }
            }
            if MainView.NAMES {
                Text("FolderItemsView").foregroundColor(.cyan)
            } // NAMES
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .font(.body)
    }
    
}

struct FolderItemsView_Previews: PreviewProvider {
    static var previews: some View {
        FolderItemsView()
    }
}
