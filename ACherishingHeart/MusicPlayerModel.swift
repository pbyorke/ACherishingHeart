//
//  MusicPlayerModel.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/21/21.
//
// https://designcode.io/swiftui-advanced-handbook-firebase-storage
// https://www.codegrepper.com/code-examples/swift/play+an+audio+file+swift+5
//

import SwiftUI
import AVFoundation
import Firebase

class MusicPlayerModel: NSObject, ObservableObject {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    private var priorSelectedSong: Item?
    private var player: AVAudioPlayer?
    @Published var songs = [Item]()
    
    @Published var selectedSong: Item? {
        didSet {
            if selectedSong == priorSelectedSong {
                selectedSong = nil
                priorSelectedSong = nil
                pause()
            } else {
                priorSelectedSong = selectedSong
                play()
            }
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
    
    private func play() {
        if let fullPath = selectedSong?.fullPath {
            let storageRef = Storage.storage().reference().child(fullPath)
            print("* * *  storageRef \(storageRef)")
            Task {
                do {
                    let url = try await storageRef.downloadURL()
                    print("* * *  url \(url)")
                    async let (data, _) = URLSession.shared.data(from: url)
                    try await print("* * *  data size \(data.count)")
                    player = try await AVAudioPlayer(data: data)
                    player?.numberOfLoops = 0
                    player?.delegate = self
                    player?.prepareToPlay()
                    print("* * *  starting play")
                    player?.play()
                } catch {
                    print("* * *  \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    func pause() {
        print("* * *  pausing")
        player?.pause()
    }

}

// MARK: - AVAudioPlayerDelegate

extension MusicPlayerModel: AVAudioPlayerDelegate {
    
}
