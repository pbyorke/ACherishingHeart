//
//  MusicListOfSongsModel.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/21/21.
//
// https://designcode.io/swiftui-advanced-handbook-firebase-storage
// https://www.codegrepper.com/code-examples/swift/play+an+audio+file+swift+5
//

import SwiftUI

class MusicListOfSongsModel: NSObject, ObservableObject {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    var musicPlayerService: PlayerProtocol = MusicPlayerService.shared
    
    @Published var state: PlayerState = .waiting
    @Published var songs = [Item]()
    @Published var selectedSong: Item?

    private var priorSelectedSong: Item?

    func select(_ song: Item) {
        priorSelectedSong = selectedSong
        selectedSong = song
        state = .playing
        musicPlayerService.play(selectedSong)
    }
    
    func playPause() {
        switch state {
        case .playing:
            state = .paused
            musicPlayerService.pause()
        case .paused:
            state = .playing
            musicPlayerService.play()
        default:
            break
        }
    }
    
    func getSongs(folder: Folder) async throws {
        do {
            DispatchQueue.main.async {
                Task {
                    self.songs = try await self.storageService.itemsInFolder(folderId: folder.id)
                }
            }
        }
    }
    
    func icon(_ song: Item) -> Image {
        if song == selectedSong {
            return Image(systemName: "pause.fill")
        } else {
            return Image(systemName: "play.fill")
        }
    }
    
}
