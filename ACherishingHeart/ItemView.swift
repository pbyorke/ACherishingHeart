//
//  ItemView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct ItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageService: StorageService
    
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
                InputTextFieldView(
                    text: $item.bucket,
                    placeholder: "Bucket",
                    keyboardType: .default,
                    sfSymbol: nil
                )
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
                    .padding()
                }
                Group {
                    EmbeddedCloudFilesView()
                }
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
