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
                    VStack(spacing: 10) {
                        HStack {
                            NavigationLink(
                                destination: Text("Music")) {
                                    Text("Music")
                                }
                            Spacer()
                        }
                        if authenticator.isMaster {
                            HStack {
                                NavigationLink(
                                    destination: MasterView() ) {
                                        Text("Master")
                                    }
                                Spacer()
                            }
                        }
                        if authenticator.isMedia {
                            HStack {
                                NavigationLink(
                                    destination: MediaView() ) {
                                        Text("Media")
                                    }
                                Spacer()
                            }
                        }
                        if authenticator.isAdmin {
                            HStack {
                                NavigationLink(
                                    destination: PersonsView(masterView: false) ) {
                                        Text("Admin")
                                    }
                                Spacer()
                            }
                        }
                        if authenticator.isJoyCoach {
                            HStack {
                                NavigationLink(
                                    destination: Text("Joy Coach") ) {
                                        Text("Joy Coach")
                                    }
                                Spacer()
                            }
                        }
                        if authenticator.isJCTeacher {
                            HStack {
                                NavigationLink(
                                    destination: Text("Joy Coach Teacher") ) {
                                        Text("Joy Coach Teacher")
                                    }
                                Spacer()
                            }
                        }
                        if authenticator.isJCStudent {
                            HStack {
                                NavigationLink(
                                    destination: Text("Joy Coach Student") ) {
                                        Text("Joy Coach Student")
                                    }
                                Spacer()
                            }
                        }
                    }
                }
                .padding(20)
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

#if DEBUG
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
#endif
