//
//  FolderView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct FolderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var itemsInFolder: ItemsInFolder
    var storageService: StorageServiceProtocol = StorageService.shared

    var add = false
    @Binding var folder: Folder

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                InputTextFieldView(
                    text: $folder.name,
                    placeholder: "Name",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                ItemsInFolderView()
                Spacer()
                if MainView.NAMES {
                    Names(name: "FolderView")
                } // NAMES
            }
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
        .navigationTitle("Folder")
    }
    
    private func update() {
        Task.init {
            do {
                if add {
                    try await storageService.createFolder(folder)
//                    try await storageService.rewriteItemsForFolder(folder, items.items)
                } else {
                    try storageService.updateFolder(folder)
                }
            } catch { }
        }
        presentationMode.wrappedValue.dismiss()
    }
    
}

#if DEBUG
struct FolderView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        FolderView(add: false, folder: $folder)
            .preview(with: "Add or update a Folder")
    }
}
#endif
