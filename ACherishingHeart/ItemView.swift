//
//  ItemView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct ItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var storageService: StorageServiceProtocol = StorageService.shared

    var add: Bool
//    = false
    @Binding var item: Item
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                InputTextFieldView(
                    text: $item.name,
                    placeholder: "Name",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                HStack {
                    InputTextFieldView(
                        text: $item.url,
                        placeholder: "URL",
                        keyboardType: .default,
                        sfSymbol: nil
                    )
                    NavigationLink(destination: CloudFilesView(url: $item.url)) {
                        Image(systemName: "arrow.right")
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 0)
                }
                Group {
                    VStack(alignment: .leading) {
                        HStack {
                            Button("Music") { item.type = .music }
                            .font(item.type == .music ? .body.bold() : .body)
                            .foregroundColor(item.type == .music ? .green : .blue)
                            Spacer()
                        }
                        HStack {
                            Button("Video") { item.type = .video }
                            .font(item.type == .video ? .body.bold() : .body)
                            .foregroundColor(item.type == .video ? .green : .blue)
                            Spacer()
                        }
                        HStack {
                            Button("Document") { item.type = .document }
                            .font(item.type == .document ? .body.bold() : .body)
                            .foregroundColor(item.type == .document ? .green : .blue)
                            Spacer()
                        }
                        HStack {
                            Button("Unknown") { item.type = .unknown }
                            .font(item.type == .unknown ? .body.bold() : .body)
                            .foregroundColor(item.type == .unknown ? .green : .blue)
                            Spacer()
                        }
                    }
                    .padding(20)
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
            if MainView.NAMES {
                Names(name: "ItemView")
            } // NAMES
        }
    }
    
    private func update() {
        Task.init {
            do {
                if add {
                    try await storageService.createItem(item)
                } else {
                    try storageService.updateItem(item)
                }
            } catch { }
        }
        presentationMode.wrappedValue.dismiss()
    }
    
}

#if DEBUG
struct ItemView_Previews: PreviewProvider {
    @State static var item = Item.new
    static var previews: some View {
        ItemView(add: false, item: $item)
            .preview(with: "Add or update an Item")
    }
}
#endif
