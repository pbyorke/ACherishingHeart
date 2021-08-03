//
//  Authenticator.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/22/21.
//

import Foundation
import FirebaseAuth

protocol AuthenticatorProtocol {
    func signin() async throws
    func signup() async throws
    func signout() async throws
    var email: String { set get }
    var password: String { set get }
}

final class Authenticator: ObservableObject, AuthenticatorProtocol {
    
    @Published var isLoggedIn: Bool = false
    private var currentId = ""
    @Published var currentPerson: Person?
    
    var email = ""
    var password = ""
    var firstName = ""
    var lastName = ""
    var phoneNumber = ""
    
    var isMedia: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isMedia
        } else {
            return false
        }
    }
    
    var isMaster: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isMaster
        } else {
            return false
        }
    }
    
    var authService: AuthServiceProtocol = AuthService.shared
    var storeService: StoreServiceProtocol = StoreService.shared
    
    func setup() {
        Task.init {
            do {
                if let user = Auth.auth().currentUser {
                    currentId = user.uid
                    let person = try await storeService.getOneById(collection: .users, type: Person.self, id: currentId)
                    DispatchQueue.main.async {
                        self.currentPerson = person
                        self.isLoggedIn = true
                    }
                } else {
                    isLoggedIn = false
                }
            } catch {
                print(error)
            }
        }
    }
    
    func signin() async throws {
        do {
            print("* * *  \"\(email.trim())\" \"\(password.trim())\"")
            currentId = try await authService.signin(email: email.trim(), password: password.trim())
            currentPerson = try await storeService.getOneById(collection: .users, type: Person.self, id: currentId)            
            isLoggedIn = true
        } catch {
            throw(error)
        }
    }

    func signup() async throws {
        do {
            let uid = try await authService
                .signup(email: email.trim(), password: password.trim())
            let person = Person(
                id: uid,
                email: email.trim(),
                password: password.trim(),
                firstName: firstName.trim(),
                lastName: lastName.trim(),
                phoneNumber: phoneNumber.trim(),
                isMedia: false,
                isMaster: false
            )
        try await storeService
                .create(person, collection: .users)
            isLoggedIn = true
        } catch {
            throw error
        }
    }

    func signout() async throws {
        do {
            try await authService.signout()
            isLoggedIn = false
            currentPerson = nil
        } catch {
            throw error
        }
    }

}
