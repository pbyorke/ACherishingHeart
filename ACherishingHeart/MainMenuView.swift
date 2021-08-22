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
                        PrettyLink(text: "Music", action: Text("Music"))
                        if authenticator.isMaster {
                            PrettyLink(text: "Master", action: MasterView())
                        }
                        if authenticator.isMedia {
                            PrettyLink(text: "Media", action: MediaView())
                        }
                        if authenticator.isAdmin {
                            PrettyLink(text: "Admin", action: PersonsView(masterView: false))
                        }
                        if authenticator.isJoyCoach {
                            PrettyLink(text: "Joy Coach", action: Text("Joy Coach"))
                        }
                        if authenticator.isJCTeacher {
                            PrettyLink(text: "Joy Coach Teacher", action: Text("Joy Coach Teacher"))
                        }
                        if authenticator.isJCStudent {
                            PrettyLink(text: "Joy Coach Student", action: Text("Joy Coach Student"))
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
