//
//  MusicListOfSongsView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/20/21.
//

import SwiftUI

struct MusicListOfSongsView: View {
    
    @StateObject private var model = MusicListOfSongsModel()
    
    @State var position: Double = 0

    var folder: Folder
    
    var body: some View {
        VStack {
            HStack {
                Button {playPause() } label: { Image(systemName: model.state == .paused ? "play.fill" : "pause.fill") }
                .padding(5)
                .frame(width: 40, height: 40)
                .border(Color.black, width: 1)
                .disabled(model.state == .waiting)
//                Button { backward() } label: { Image(systemName: "backward.end") }
//                .padding(5)
//                .frame(width: 30, height: 30)
//                .border(Color.black, width: 1)
//                .disabled(musicListOfSongsModel.state == .waiting)
//                Button { forward() } label: { Image(systemName: "forward.end") }
//                .padding(5)
//                .frame(width: 30, height: 30)
//                .border(Color.black, width: 1)
//                .disabled(musicListOfSongsModel.state == .waiting)
                Slider(value: $position, in: 0...3.45)
                    .padding(5)
                    .frame(height: 40)
                    .border(Color.black, width: 1)
                    .disabled(model.state == .waiting)
//                    .disabled(musicPlayerModel.state == .waiting)
//                Button { shuffle() } label: { Image(systemNam   e: "shuffle.circle") }
//                    .padding(5)
//                    .border(Color.black, width: 1)
//                    .disabled(shuffleEnabled == false)
//                Button { rept() } label: { Image(systemName: "repeat.circle") }
//                    .padding(5)
//                    .border(Color.black, width: 1)
//                    .disabled(reptEnabled == false)
                Text("\(model.length)")
                    .font(.caption)
            }
            .padding()
            .navigationTitle( Text("Songs") )
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(model.songs) { song in
                        HStack {
                            if song == model.selectedSong {
                                Image(systemName: "speaker.wave.3.fill")
                            } else {
                                Image(systemName: "speaker.fill")
                            }
                            Button { tap(song) } label: { Text(song.name) }
                            Spacer()
                        }}
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .onAppear {
                Task {
                    do {
                        try await model.getSongs(folder: folder)
                    }
                }
            }
            if MainView.NAMES {
                Names(name: "MusicListOfSongsView")
            } // NAMES
        }
    }

    private func tap(_ song: Item) {
        model.select(song)
    }
    
    private func playPause() {
        model.playPause()
    }
    
//    private func backward() { }
//    private func forward() { }
//    private func shuffle() { }
//    private func rept() { }

}

// MARK: - Preview

struct MusicListOfSongsView_Previews: PreviewProvider {
    private static var album = Folder.new
    static var previews: some View {
        MusicListOfSongsView(folder: album)
            .preview(with: "Music Player View")
    }
}
