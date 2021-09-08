//
//  ItemsView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/17/21.
//

import SwiftUI

struct ItemsView: View {

    var storageService: StorageServiceProtocol = StorageService.shared
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var itemsInFolder: ItemsInFolder
    
    @State private var allItems = [Item]()
    @State private var item = Item.new
    var selecting = false

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(allItems) { item in
                    HStack {
                        if selecting {
                            Button(item.name) {
                                itemsInFolder.append(item)
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            HStack {
                                PrettyLink(label: item.name, destination: ItemView(add: false, item: $item)) { self.item = item }
                                Spacer()
                                Text("\(item.type.title)")
                            }
                        }
                        Spacer()
                    }
                }
            }
        .padding(20)
        }
        .navigationTitle( Text("Items") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                PrettyLink(image: "plus", destination: ItemView(add: true, item: $item)) { self.item = Item.new }
            }
        }
        .onAppear {
            Task.init {
                do {
                    self.allItems = try await storageService.listAllItems()
                }
            }
        }
        if MainView.NAMES {
            Names(name: "ItemsView")
        } // NAMES
    }
}

#if DEBUG
struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
#endif
