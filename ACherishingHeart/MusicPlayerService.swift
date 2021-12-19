//
//  MusicPlayerService.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 12/17/21.
//

import Foundation
import AVFoundation
import Firebase

class MusicPlayerService: NSObject, PlayerProtocol {
    
    static let shared = MusicPlayerService()
    var state = PlayerState.waiting
    private var player: AVAudioPlayer?
    
    func play(_ song: Item?) {
        state = .playing
        if let fullPath = song?.fullPath {
            let storageRef = Storage.storage().reference().child(fullPath)
            Task {
                do {
                    let url = try await storageRef.downloadURL()
                    async let (data, _) = URLSession.shared.data(from: url)
                    player = try await AVAudioPlayer(data: data)
                    player?.numberOfLoops = 0
                    player?.delegate = self
                    player?.prepareToPlay()
                    player?.play()
                } catch { }
            }
        }
        
    }
    
    func pause() {
        player?.pause()
    }
    
}

// MARK: - AVAudioPlayerDelegate

extension MusicPlayerService: AVAudioPlayerDelegate {
    
}
