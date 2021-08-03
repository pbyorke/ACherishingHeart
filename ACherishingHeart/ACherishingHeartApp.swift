//
//  ACherishingHeartApp.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/21/21.
//
// ACherishingHeart/                active
// TheCherishingHeart.oldStyle/     most complete
// ACherishingHeart.2/              tundsdev version
//

import SwiftUI
import Firebase

@main
struct ACherishingHeartApp: App {

//    @StateObject var authenticator = Authenticator()
    var authenticator = Authenticator()

    init() {
        configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authenticator)
        }
    }
    
    private func configure() {
        FirebaseApp.configure()
//        authenticator = Authenticator()
        authenticator.setup()
    }
    
}
