//
//  PlayerProtocol.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 12/17/21.
//

protocol PlayerProtocol {
    
    var state: PlayerState { get set }
    
    func play(_ song: Item?)
    func pause()
    
}
