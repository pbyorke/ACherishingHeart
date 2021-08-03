////
////  SignInService.swift
////  ACherishingHeart
////
////  Created by Pete Yorke on 7/29/21.
////
//
////import Combine
//import Foundation
//import FirebaseAuth
//
////enum SignInError: Error {
////    case failed
////}
//
//protocol SignInServiceProtocol {
//    func signin(with credentials: SignInCredentials)  async throws
//}
//
//final class SignInService: SignInServiceProtocol {
//    
//    func signin(with credentials: SignInCredentials) async throws {
//        do {
//            try await Auth
//                .auth()
//                .signIn(withEmail: credentials.email, password: credentials.password)
//        } catch {
//            throw error
//        }
//    }
//    
//}
