//
//  FolderTabView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 9/17/21.
//

import SwiftUI

struct FolderTabView: View {

    @Binding var folder: Folder

    var body: some View {
        TabView {
            FolderInfoView(folder: $folder).tabItem { Label("Info", systemImage: "gearshape.fill")  }
            FolderItemsView().tabItem { Label("Items", systemImage: "music.note") }
            FolderCoursesView().tabItem { Label("Courses", systemImage: "books.vertical.fill") }
            .navigationTitle("Folder")
        }
    }
}

struct FolderTabView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        FolderTabView(folder: $folder)
            .preview(with: "Add or update a Folder")
    }
}
