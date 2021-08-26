//
//  ItemView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct ItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var authenticator: Authenticator
    @EnvironmentObject var storageService: StorageService

//    var firestoreService: FirestoreServiceProtocol = FirestoreService.shared
    
    @State private var name = ""
    var add = false
    @Binding var item: Item

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                InputTextFieldView(
                    text: $item.name,
                    placeholder: "Name",
                    keyboardType: .default,
                    sfSymbol: nil
                )
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: update) {
                    if add {
                        Image(systemName: "plus")
                    } else {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Item")
    }
    
    private func update() {
        do {
            try storageService.updateItem(item)
        } catch { }
        presentationMode.wrappedValue.dismiss()
    }
    
}

#if DEBUG
struct ItemView_Previews: PreviewProvider {
    @State static var item = Item.new
    static var previews: some View {
        ItemView(add: false, item: $item)
    }
}
#endif
