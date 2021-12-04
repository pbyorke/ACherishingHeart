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
        ScrollView {
            VStack(spacing: 10) {
//                PrettyLink(label: "Music", spacer: true, destination: FoldersView(type: .play)) { }
                PrettyLink(label: "Music", spacer: true, destination: MusicListView()) { }
                if authenticator.isMaster {
                    PrettyLink(label: "Master", spacer: true, destination: MasterView()) { }
                }
                if authenticator.isMedia {
                    PrettyLink(label: "Media", spacer: true, destination: MediaView(type: .edit)) { }
                }
                if authenticator.isAdmin {
                    PrettyLink(label: "Admin", spacer: true, destination: PersonsView(masterView: false)) { }
                }
                if authenticator.isFinance {
                    PrettyLink(label: "Finance", spacer: true, destination: FinanceView()) { }
                }
                if authenticator.isJoyCoach {
                    PrettyLink(label: "Joy Coach", spacer: true, destination: Text("Joy Coach")) { }
                }
                if authenticator.isJCTeacher {
                    PrettyLink(label: "Joy Coach Teacher", spacer: true, destination: Text("Joy Coach Teacher")) { }
                }
                if authenticator.isJCStudent {
                    PrettyLink(label: "Joy Coach Student", spacer: true, destination: Text("Joy Coach Student")) { }
                }
                if authenticator.isSubscriber {
                    PrettyLink(label: "Subscriber", spacer: true, destination: Text("Subscriber")) { }
                }
            }
            .padding(20)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}

#if DEBUG
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .environmentObject(authenticator)
            .preview(with: "Main Menu")
    }
}
#endif
