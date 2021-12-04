//
//  MusicPlayerView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/20/21.
//

import SwiftUI

struct MusicPlayerView: View {
    
    @StateObject private var viewModel = MusicPlayerModel()
    
    var folder: Folder
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.songs) { song in
                    HStack {
                        MusicPlayerCell(song: song, viewModel: viewModel)
                        Spacer()
                    }}
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle( Text("Songs") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .onAppear {
            Task {
                do {
                    try await viewModel.getSongs(folder: folder)
                }
            }
        }
        if MainView.NAMES {
            Names(name: "MusicPlayerView")
        } // NAMES
    }
    
}



struct MusicPlayerView_Previews: PreviewProvider {
    private static var album = Folder.new
    static var previews: some View {
        MusicPlayerView(folder: album)
            .preview(with: "Music Player View")
    }
}
