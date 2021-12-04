//
//  MusicPlayerCell.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/24/21.
//

import SwiftUI

struct MusicPlayerCell: View, Identifiable {
    
    var id = UUID().uuidString
    var song: Item
    @ObservedObject var viewModel: MusicPlayerModel
    
    var body: some View {
        HStack {
            Button { tapAction() } label: { viewModel.icon(song) }
            Text(song.name)
        }
    }
    
    private func tapAction() {
        viewModel.selectedSong = song
    }
    
}
