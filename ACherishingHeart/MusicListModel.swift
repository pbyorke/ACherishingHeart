//
//  MusicListModel.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 11/21/21.
//

import SwiftUI

class MusicListModel: ObservableObject {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    @Published var albums = [Folder]()
    
    init() {
        do {
            DispatchQueue.main.async {
                Task {
                    self.albums = try await self.storageService.listAllFolders()
                }
            }
        }
    }
    
}
