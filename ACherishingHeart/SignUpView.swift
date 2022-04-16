//
//  SignUpView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/28/21.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authenticator: Authenticator

    @State private var showSignupError = false
    @State private var errorMessage = ""
//    @State private var person = Person.new
    @State private var person = Person()

    var erase: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                InputTextFieldView(
                    text: $person.email,
                    placeholder: "Email",
                    keyboardType: .emailAddress,
                    sfSymbol: "envelope"
                )
                InputPasswordView(
                    password: $person.password,
                    placeholder: "Password",
                    sfSymbol: "lock"
                )
                Divider()
                InputTextFieldView(
                    text: $person.firstName,
                    placeholder: "First Name",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                InputTextFieldView(
                    text: $person.lastName,
                    placeholder: "Last Name",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                InputTextFieldView(
                    text: $person.phoneNumber,
                    placeholder: "Phone Number",
                    keyboardType: .default, 
                    sfSymbol: nil
                )
            }
            Spacer()
            ButtonView(title: "Sign Up", background: .blue, foreground: .white, border: .blue) { signUp() }
            .alert(errorMessage, isPresented: $showSignupError) { Button("OK", role: .cancel) { } }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Sign Up")
        .navigationBarHidden(false)
        if MainView.NAMES {
            Names(name: "SignUpView")
        } // NAMES
    }
    
    private func signUp() {
        Task.init {
            do {
                try await authenticator.signup(person: person)
                showSignupError = false
                presentationMode.wrappedValue.dismiss()
            } catch {
                errorMessage = error.localizedDescription
                showSignupError = true
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
                .environmentObject(Authenticator.shared)
        }
    }
}
