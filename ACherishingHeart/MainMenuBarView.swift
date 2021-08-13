//
//  MainMenuBarView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/26/21.
//

import SwiftUI

struct MainMenuBarView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    
    @State private var showSignIn = false
    @State private var showSignUp = false
    @State private var showSignOut = false
    @State private var showAccount = false
    @State private var showWhy = false

    var body: some View {
        HStack(spacing: 10) {
            if authenticator.isLoggedIn {
                HStack(spacing: 10) {
                    Spacer()
                    NavigationLink(destination: SignInView()) {
                        Button("Sign Out") {
                            signOut()
                        }
                    }
                    NavigationLink("Account", destination: AccountView())
                }
            } else {
                HStack(spacing: 10) {
                    NavigationLink("Why", destination: WhyView())
                    Spacer()
                    NavigationLink("Sign In", destination: SignInView())
                    NavigationLink("Sign Up", destination: SignUpView())
                    NavigationLink(destination: SignInView()) {
                        Button("Sign Out") {
                            signOut()
                        }
                    }
                }
            }
        }
        .font(.footnote)
        .foregroundColor(.blue)
        .padding(.bottom,  40)
        .padding(.trailing, 20)
        .padding(.leading, 20)
    }
    
    private func signOut() {
        Task.init {
            do {
                try await authenticator.signout()
            } catch { print(error) }
        }
    }
    
}

#if DEBUG

let authenticator = Authenticator()

struct MainMenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuBarView()
            .environmentObject(authenticator)
    }
}

#endif
