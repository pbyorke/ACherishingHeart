//
//  AuthService.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/29/21.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func signin(email: String, password: String) async throws -> String
    func signup(email: String, password: String) async throws -> String
    func signout() async throws
    func forgotpassword()
}

final class AuthService: AuthServiceProtocol {
    
    static let shared = AuthService()
    
    func signin(email: String, password: String) async throws -> String {
        do {
            let result = try await Auth
                .auth()
                .signIn(withEmail: email, password: password)
            return result.user.uid
        } catch {
            throw error
        }
    }
    
    func signup(email: String, password: String) async throws -> String {
        do {
            let result = try await Auth
                .auth()
                .createUser(withEmail: email, password: password)
            return result.user.uid
        } catch {
            throw error
        }
    }
    
    func signout() throws {
        do {
            try Auth
                .auth()
                .signOut()
        } catch {
            throw error
        }
    }
    
    func forgotpassword() {
        Auth
            .auth()
            .sendPasswordReset(withEmail: "pbyorke@gmail.com")
    }
    
}
