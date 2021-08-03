////
////  AuthenticateView.swift
////  ACherishingHeart
////
////  Created by Pete Yorke on 7/26/21.
////
//
//import SwiftUI
//
//struct AuthenticateView: View {
//    
////    var action: AuthenticatorAction
//    @EnvironmentObject var authenticator = Authenticator.shared
//    @State var emailAddress = ""
//    @State var password = ""
//    @State var errorMessage = ""
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section {
//                    TextField("Email address", text: $emailAddress)
//                        .keyboardType(.emailAddress)
//                        .disableAutocorrection(true)
//                        .autocapitalization(.none)
//                    SecureField("Password", text: $password)
//                } // Section
//                Section {
//                    switch action {
//                    case .signIn:
//                        Button("Sign In") {
//                            authenticator.signin(email: emailAddress, password: password)
//                        }
//                    case .signOut:
//                        Button("Sign Out") {
//                            authenticator.signOut()
//                        }
//                    case .signUp:
//                        Button("Sign Up") {
//                            authenticator.signUp(emailAddress: emailAddress, password: password) { result in
//                                switch(result) {
//                                case .success: break
//                                case .failure(let error):
//                                    switch error {
//                                    case .bad1: break
//                                    case .bad2: break
//                                    case .cannotCreate(let message):
//                                        errorMessage = message
//                                    }
//                                }
//                            }
//                        }
//                    } // switch
//                } // Section
//                Section {
//                    Text(errorMessage)
//                } // Section
//            } // Form
//            .navigationBarTitle(
//                action == .signIn ? "Sign In"
//                    : action == .signOut ? "Sign Out"
//                    : "Sign Up"
//            )
//        } //NavigationView
//    } // body
//}
//
//struct AuthenticateView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticateView(action: .signIn)
//    }
//}
