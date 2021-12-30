//
//  PlayerProtocol.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 12/17/21.
//

protocol PlayerProtocol {
    
    var delegate: MusicPlayerDelegate? { get set }
    var position: Double { get }
    var length: Double { get }

    func play(_ song: Item?)
    func play()
    func playAt(_ position: Double)
    func pause()
    
}
