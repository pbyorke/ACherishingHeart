//
//  AddItemsView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/27/21.
//

import SwiftUI

struct AddItemsView: View {
    
    @Binding var folder: Folder
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#if DEBUG
struct AddItemsView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        AddItemsView(folder: $folder)
    }
}
#endif
