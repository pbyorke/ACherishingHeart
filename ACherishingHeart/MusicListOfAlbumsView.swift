//
//  MusicListView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/20/21.
//

import SwiftUI

struct MusicListOfAlbumsView: View {
    
    @StateObject private var viewModel = MusicListOfAlbumsModel()
    @State private var folder = Folder.new
    
    var body: some View {
        VStack {
            Text("")
                .navigationTitle( Text("Albums") )
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.albums) { album in
                        HStack {
                            NavigationLink(destination: MusicListOfSongsView(folder: album)) { Text(album.name) }
                            Spacer()
                        }
                    }
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            if MainView.NAMES {
                Names(name: "MusicListOfAlbumsView")
            } // NAMES
        }
    }
}

// MARK: - Preview

struct MusicListView_Previews: PreviewProvider {
    
    static var previews: some View {
        MusicListOfAlbumsView()
    }
}
