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
    private var service: PlayerProtocol = MusicPlayerService()

    @Published var state: PlayerState = .waiting
    @Published var songs = [Item]()
    @Published var selectedSong: Item?
    @Published var length = ""
    @Published var position: Double = 0

    private var priorSelectedSong: Item?
    private var timer: Timer?
    
    override init() {
        super.init()
        service.delegate = self
    }

    func select(_ song: Item) {
        priorSelectedSong = selectedSong
        selectedSong = song
        state = .playing
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.position = self.service.position / self.service.length
        }
        service.play(selectedSong)
    }
    
    func playPause() {
        switch state {
        case .playing:
            state = .paused
            service.pause()
        case .paused:
            state = .playing
            service.play()
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

// MARK: - MusicPlayerDelegate

extension MusicListOfSongsModel: MusicPlayerDelegate {
    
    func setLength(_ length: Double) {
        let l = Int(length)
        let h = l / 3600
        let m = (l - h * 3600) / 60
        let s = (l - h * 3600) - m * 60
        var ha = ""
        if h > 0 {
            ha = "\(h)h"
        }
        var ma = ""
        if m > 0 {
            ma = "\(m)m"
        }
        var sa = ""
        if s > 0 {
            sa = "\(s)s"
        }
        DispatchQueue.main.async {
            self.length = "\(ha) \(ma) \(sa)"
        }
    }
    
}
