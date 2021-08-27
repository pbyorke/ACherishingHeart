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
                        PrettyLink(label: "Music", destination: Text("Music")) { }
                        if authenticator.isMaster {
                            PrettyLink(label: "Master", destination: MasterView()) { }
                        }
                        if authenticator.isMedia {
                            PrettyLink(label: "Media", destination: MediaView()) { }
                        }
                        if authenticator.isAdmin {
                            PrettyLink(label: "Admin", destination: PersonsView(masterView: false)) { }
                        }
                        if authenticator.isJoyCoach {
                            PrettyLink(label: "Joy Coach", destination: Text("Joy Coach")) { }
                        }
                        if authenticator.isJCTeacher {
                            PrettyLink(label: "Joy Coach Teacher", destination: Text("Joy Coach Teacher")) { }
                        }
                        if authenticator.isJCStudent {
                            PrettyLink(label: "Joy Coach Student", destination: Text("Joy Coach Student")) { }
                        }
                        if authenticator.isSubscriber {
                            PrettyLink(label: "Subscriber", destination: Text("Subscriber")) { }
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
