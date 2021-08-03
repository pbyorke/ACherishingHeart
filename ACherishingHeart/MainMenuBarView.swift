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
                    NavigationButtonView(title: "Sign Out", background: .clear, foreground: .blue) { signOut() }
                    NavigationButtonView(title: "Account", background: .clear, foreground: .blue) { showAccount.toggle() }
                    .sheet(isPresented: $showAccount, content: { AccountView() })
                }
            } else {
                HStack(spacing: 10) {
                    NavigationButtonView(title: "Why", background: .clear, foreground: .blue) { showWhy.toggle() }
                    .sheet(isPresented: $showWhy, content: { WhyView() })
                    Spacer()
                    NavigationButtonView(title: "Sign In", background: .clear, foreground: .blue) { showSignIn.toggle() }
                    .sheet(isPresented: $showSignIn, content: { SignInView() })
                    NavigationButtonView(title: "Sign Up", background: .clear, foreground: .blue) { showSignUp.toggle() }
                    .sheet(isPresented: $showSignUp, content: { SignUpView() })
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
                SignInView()
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
