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
    @State private var items = [Item]()
    @State private var item = Item.new
    
    var selecting = false
    @Binding var selectedItem: Item
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(items) { item in
                    HStack {
                        if selecting {
                            Button(item.name) {
                                
                                
                                
                                
                                // figure out how to add it to list
                                selectedItem = item
                                
                                
                                
                                
                                
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            PrettyLink(label: item.name, destination: ItemView(add: false, item: $item)) { self.item = item }
                        }
                        Spacer()
                        Text("\(item.type.title)")
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
                if !selecting {
                    NavigationLink(destination: ItemView(add: true, item: $item)) {
                        Image(systemName: "plus")
                    }
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
        if MainView.NAMES {
            Names(name: "ItemsView")
        } // NAMES
    }
}

#if DEBUG
struct ItemsView_Previews: PreviewProvider {
    @State static var selectedItem = Item.new
    static var previews: some View {
        ItemsView(selectedItem: $selectedItem)
    }
}
#endif
