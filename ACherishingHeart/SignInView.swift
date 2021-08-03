//
//  SignInView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/28/21.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authenticator: Authenticator

    @State private var showForgotPassword = false
    @State private var showSigninError = false
    @State private var errorMessage = ""
//    @State private var email = "" { didSet { authenticator.email = email } }
//    @State private var password = "" { didSet { authenticator.password = password } }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    InputTextFieldView(
                        text: $authenticator.email,
                        placeholder: "Email",
                        keyboardType: .emailAddress,
                        sfSymbol: "envelope"
                    )
                    InputPasswordView(
                        password: $authenticator.password,
                        placeholder: "Password",
                        sfSymbol: "lock"
                    )
                }
                VStack(spacing: 16) {
                    ButtonView(title: "Sign In") { signIn() }
                    .alert(errorMessage, isPresented: $showSigninError) { Button("OK", role: .cancel) { } }
                    ButtonView(title: "Forgot Password", background: .clear, foreground: .blue, border: .clear) { ForgotPasswordView() }
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Sign In")
        }
    }
    
    private func signIn() {
        Task.init {
            do {
                try await authenticator.signin()
                showSigninError = false
                presentationMode.wrappedValue.dismiss()
            } catch {
                errorMessage = error.localizedDescription
                print("* * *  signin \"\(authenticator.email)\"/\"\(authenticator.password)\":\"\(errorMessage)\"")
                showSigninError = true
            }
        }
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView()
        }
    }
}
