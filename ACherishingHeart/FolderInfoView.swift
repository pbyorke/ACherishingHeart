//
//  FolderInfoView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 9/14/21.
//

import SwiftUI

struct FolderInfoView: View {
    
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
                Spacer()
                if MainView.NAMES {
                    Names(name: "FolderInfoView")
                } // NAMES
            }
        }
        .padding(.horizontal, 15)
    }
    
}

#if DEBUG
struct FolderInfoView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        FolderInfoView(folder: $folder)
            .preview(with: "Add or update a Folder")
    }
}
#endif
