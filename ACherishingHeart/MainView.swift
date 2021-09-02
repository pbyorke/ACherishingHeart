//
//  MainView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/21/21.
//

import SwiftUI

struct MainView: View {
    
    static let NAMES = true

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    MainPictureView()
                    MainTitleView()
                    MainMenuView()
                    Spacer()
//                    DebugView()
                    MainMenuBarView()
                }
                if MainView.NAMES {
                    Names(name: "MainView")
                } // NAMES
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
