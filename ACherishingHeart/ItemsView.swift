//
//  ItemsView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/17/21.
//

import SwiftUI

struct ItemsView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared

    @State private var items = [Item]()
    @State private var item = Item.new
    
    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(items) { item in
                            HStack {
                                PrettyLink(label: item.name, destination: ItemView(add: false, item: $item)) { self.item = item }
                                Spacer()
                                Text("\(item.type.title)")
                            }
                        }
                    }
                    .padding(20)
                }
            }
            .navigationTitle( Text("Items") )
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .font(.title2)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ItemView(add: true, item: $item)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                Task.init {
                    do {
                        self.items = try await storageService.listAllItems()
                    }
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
