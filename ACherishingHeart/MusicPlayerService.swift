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

    private var player: AVAudioPlayer?
    var delegate: MusicPlayerDelegate?
    var position: Double { get { player?.currentTime ?? 0 } }
    var length: Double { get { player?.duration ?? 0 } }

    func play(_ song: Item?) {
        if let fullPath = song?.fullPath {
            let storageRef = Storage.storage().reference().child(fullPath)
            Task {
                do {
                    let url = try await storageRef.downloadURL()
                    async let (data, _) = URLSession.shared.data(from: url)
                    player = try await AVAudioPlayer(data: data)
                    if let player = player {
                        player.numberOfLoops = 0
                        player.delegate = self
                        player.prepareToPlay()
                        setLength(player.duration)
                        player.play()
                    }
                } catch { }
            }
        }
        
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
}

// MARK: - AVAudioPlayerDelegate

extension MusicPlayerService: AVAudioPlayerDelegate {
    
    func setLength(_ length: TimeInterval) {
        delegate?.setLength(length)
    }
    
}
