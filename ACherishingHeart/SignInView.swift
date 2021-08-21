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
    
    var erase: Bool = false

    var body: some View {
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
                NavigationLink("Forgot Password", destination: ForgotPasswordView())
            }
            .sheet(isPresented: $showForgotPassword, content: { ForgotPasswordView() })
        }
        .onAppear {
            authenticator.clear()
        }
        .padding(.horizontal, 15)
        .navigationTitle("Sign In")
        .navigationBarHidden(false)
    }
    
    private func signIn() {
        Task.init {
            do {
                try await authenticator.signin()
                showSigninError = false
                presentationMode.wrappedValue.dismiss()
            } catch {
                errorMessage = error.localizedDescription
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
