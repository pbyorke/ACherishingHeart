//
//  MainView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/21/21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        NavigationView {
            VStack {
                MainPictureView()
                MainTitleView()
                MainMenuView()
                Spacer()
                DebugView()
                MainMenuBarView()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
