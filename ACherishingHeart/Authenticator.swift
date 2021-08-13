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
    func forgotpassword() async throws
    func getPersonBy(recordId: String) async throws -> Person?
    func getPersonBy(userUID: String) async throws -> Person?
    var email: String { set get }
    var password: String { set get }
}

final class Authenticator: ObservableObject, AuthenticatorProtocol {
    
    @Published var isLoggedIn: Bool = false
    @Published var currentPerson: Person?
    @Published var persons = [Person]()
    
    private var currentId = ""
    
    @Trimmed var email = ""
    @Trimmed var password = ""
    @Trimmed var firstName = ""
    @Trimmed var lastName = ""
    @Trimmed var phoneNumber = ""
    
    var authService: AuthServiceProtocol = AuthService.shared
    var storeService: StoreServiceProtocol = StoreService.shared
    
    var isMaster: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isMaster
        } else {
            return false
        }
    }
    
    var isAdmin: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isAdmin
        } else {
            return false
        }
    }
    
    var isMedia: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isMedia
        } else {
            return false
        }
    }
    
    var isJoyCoach: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isJoyCoach
        } else {
            return false
        }
    }
    
    var isJCTeacher: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isJCTeacher
        } else {
            return false
        }
    }
    
    var isJCStudent: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.isJCStudent
        } else {
            return false
        }
    }
    
    func setup() {
        Task.init {
            do {
                if let user = Auth.auth().currentUser {
                    currentId = user.uid
                    let persons = try await storeService.getAll(collection: .users, type: Person.self)
                    let person = persons.first { $0.userUID == currentId }
                    DispatchQueue.main.async {
                        self.persons = persons
                        self.currentPerson = person
                        self.isLoggedIn = true
                    }
                } else {
                    isLoggedIn = false
                }
            } catch { }
        }        
    }
    
    func signin() async throws {
        do {
            let userUID = try await authService.signin(email: email, password: password)
            let person = try await storeService.getOneByKey(collection: .users, type: Person.self, key: "userUID", value: userUID)
            let allPersons = try await storeService.getAll(collection: .users, type: Person.self)
            print("")
            DispatchQueue.main.async {
                self.persons = allPersons
                self.currentPerson = person
                self.isLoggedIn = true
            }
        } catch {
            throw(error)
        }
    }

    func signup() async throws {
        do {
            let uid = try await authService.signup(email: email, password: password)
            let person = Person(
                id: "",
                userUID: uid,
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phoneNumber,
                isMedia: false,
                isMaster: false,
                isAdmin: false,
                isJoyCoach: false,
                isJCTeacher: false,
                isJCStudent: false
            )
            try await storeService.create(person, collection: .users)
            DispatchQueue.main.async {
                self.isLoggedIn = true
            }
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
    
    func forgotpassword() {
        authService.forgotpassword()
    }
    
    func getPersonBy(recordId: String) async throws -> Person? {
        do {
            let person = try await storeService.getOneById(collection: .users, type: Person.self, id: recordId)
            return person
        } catch {
            throw error
        }
    }
    
    func getPersonBy(userUID: String) async throws -> Person? {
        do {
            let person = try await storeService.getOneByKey(collection: .users, type: Person.self, key: "userUID", value: userUID)
            return person
        } catch {
            throw error
        }
    }

}
