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
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        PrettyLink(label: "Music", destination: Text("Music")) { }
                        Spacer()
                    }
                    if authenticator.isMaster {
                        HStack {
                            PrettyLink(label: "Master", destination: MasterView()) { }
                            Spacer()
                        }
                    }
                    if authenticator.isMedia {
                        HStack {
                            PrettyLink(label: "Media", destination: MediaView()) { }
                            Spacer()
                        }
                    }
                    if authenticator.isAdmin {
                        HStack {
                            PrettyLink(label: "Admin", destination: PersonsView(masterView: false)) { }
                            Spacer()
                        }
                    }
                    if authenticator.isFinance {
                        HStack {
                            PrettyLink(label: "Finance", destination: FinanceView()) { }
                            Spacer()
                        }
                    }
                    if authenticator.isJoyCoach {
                        HStack {
                            PrettyLink(label: "Joy Coach", destination: Text("Joy Coach")) { }
                            Spacer()
                        }
                    }
                    if authenticator.isJCTeacher {
                        HStack {
                            PrettyLink(label: "Joy Coach Teacher", destination: Text("Joy Coach Teacher")) { }
                            Spacer()
                        }
                    }
                    if authenticator.isJCStudent {
                        HStack {
                            PrettyLink(label: "Joy Coach Student", destination: Text("Joy Coach Student")) { }
                            Spacer()
                        }
                    }
                    if authenticator.isSubscriber {
                        HStack {
                            PrettyLink(label: "Subscriber", destination: Text("Subscriber")) { }
                            Spacer()
                        }
                    }
                }
                .padding(20)
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .font(.title2)
    }
    
}


#if DEBUG
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
#endif
