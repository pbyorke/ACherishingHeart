//
//  MainMenuView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/21/21.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        Form {
            HStack {
                VStack(alignment: .leading) {
                    NavigationLink(
                        destination: Text("Music")) {
                            Text("Music")
                        }
                    if authenticator.isMaster {
                        NavigationLink(
                            destination: Text("Master")) {
                                Text("Master")
                            }
                    }
                    if authenticator.isMedia {
                        NavigationLink(
                            destination: Text("Media")) {
                                Text("Media")
                            }
                    }
                }
                .font(.title2)
                Spacer()
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.bottom, 40)
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
