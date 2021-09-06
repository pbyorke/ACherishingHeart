//
//  ItemsInFolderView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/27/21.
//

import SwiftUI

struct ItemsInFolderView: View {

    @EnvironmentObject var itemsInFolder: ItemsInFolder

    var body: some View {
        VStack {
            if MainView.NAMES {
                Text("ItemsInFolderView").foregroundColor(.cyan)
            } // NAMES
            ZStack {
                Text("Items in this Folder")
                    .font(.title)
                HStack {
                    Spacer()
                    PrettyLink(image: "plus", destination: ItemsView(selecting: true)) { }
                }
            }
            List(itemsInFolder.items, id: \.id) { item in
                Text("\(item.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Swipe(symbol: "minus.square.fill", color: .red) { delete(item: item) }
                        Swipe(symbol: "arrow.down.square.fill", color: .green) { moveDown(item: item) }
                        Swipe(symbol: "arrow.up.square.fill", color: .green) { moveUp(item: item) }
                    }
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .font(.body)
    }
    
    private func delete(item: Item) {
        print("* * *  delete")
    }
    
    private func  moveUp(item: Item) {
        print("* * *  up")
    }
    
    private func  moveDown(item: Item) {
        print("* * *  down")
    }
    
}

#if DEBUG
struct ItemsInFolderView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsInFolderView()
    }
}
#endif
