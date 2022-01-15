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
                        player.play()
                    }
                } catch { }
            }
        }
        
    }
    
    func play() {
        player?.play()
    }
    
    func playAt(_ position: Double) {
        if let player = player {
            player.currentTime = player.duration * position
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.stop()
    }
    
}

// MARK: - AVAudioPlayerDelegate

extension MusicPlayerService: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.finishedPlaying()
    }
    
}
