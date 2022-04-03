//
//  ForgotPasswordView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/28/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authenticator: Authenticator
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                InputTextFieldView(text: .constant(""),
                                   placeholder: "Email",
                                   keyboardType: .emailAddress,
                                   sfSymbol: "envelope")
                ButtonView(title: "Send Password Reset") {
                    forgotPassword()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .padding(.horizontal, 16)
        .navigationTitle("Reset Password")
        .navigationBarHidden(false)
        if MainView.NAMES {
            Names(name: "ForgotPasswordView")
        } // NAMES
    }
    
    private func forgotPassword() {
        Task.init {
            authenticator.forgotpassword()
            presentationMode.wrappedValue.dismiss()
        }
    }

}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(Authenticator.shared)
    }
}
