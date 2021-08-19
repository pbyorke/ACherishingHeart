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
        HStack {
            ScrollView {
                VStack {
                    NavigationLink(
                        destination: Text("Music")) {
                            Text("Music")
                        }
                    if authenticator.isMaster {
                        NavigationLink(
                            destination: MasterView() ) {
                                Text("Master")
                            }
                    }
                    if authenticator.isMedia {
                        NavigationLink(
                            destination: MediaView() ) {
                                Text("Media")
                            }
                    }
                    if authenticator.isAdmin {
                        NavigationLink(
                            destination: AdminView() ) {
                                Text("Admin")
                            }
                    }
                    if authenticator.isJoyCoach {
                        NavigationLink(
                            destination: Text("Joy Coach") ) {
                                Text("Joy Coach")
                            }
                    }
                    if authenticator.isJCTeacher {
                        NavigationLink(
                            destination: Text("Joy Coach Teacher") ) {
                                Text("Joy Coach Teacher")
                            }
                    }
                    if authenticator.isJCStudent {
                        NavigationLink(
                            destination: Text("Joy Coach Student") ) {
                                Text("Joy Coach Student")
                            }
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 40)
        .background(Color(.systemGray6))
        .font(.title2)
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
