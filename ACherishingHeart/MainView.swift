//
//  MainView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/21/21.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                MainPictureView()
                MainTitleView()
                MainMenuView()
                Spacer()
//                DebugView()
                MainMenuBarView()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
