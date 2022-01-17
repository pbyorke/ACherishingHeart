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
// google swiftui Storage.storage()
//
// https://firebase.google.com/docs/storage/ios/upload-files
// https://firebase.google.com/docs/storage/ios/download-files
// https://firebase.google.com/docs/storage/ios/list-files
//
// https://www.youtube.com/watch?v=YaMKOTWdT6U (Building a SwiftUI app for iOS and macOS)
//
// Firebase Storage Rules
//
//rules_version = '2';
//service firebase.storage {
//  match /b/{bucket}/o {
//    match /{allPaths=**} {
//      allow read, write: if request.auth != null;
//    }
//  }
//}
//
// Firebase Firestore Database Rules
//
//rules_version = '2';
//service cloud.firestore {
//  match /databases/{database}/documents {
//    match /{document=**} {
//      allow read, write: if request.auth != null;
//    }
//  }
//}


import SwiftUI
import Firebase

@main
struct ACherishingHeartApp: App {

    var authenticator = Authenticator()
    var itemsInFolder = ItemsInFolder()
    var coursesInFolder = CoursesInFolder()
    var coursesInPerson = CoursesInPerson()

    init() {
        configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authenticator)
                .environmentObject(itemsInFolder)
                .environmentObject(coursesInFolder)
                .environmentObject(coursesInPerson)
        }
    }
    
    private func configure() {
        FirebaseApp.configure()
        authenticator.setup()
    }
    
}
