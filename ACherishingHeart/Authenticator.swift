//
//  Authenticator.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/22/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticatorProtocol {
    var email: String { set get }
    var password: String { set get }
    
    func signin() async throws
    func signup() async throws
    func signout() async throws
    func forgotpassword() async throws
    func getPersonBy(recordId: String) async throws -> Person?
    func getPersonBy(userUID: String) async throws -> Person?
    func update(_ person: Person) async throws
    func clear()
}

final class Authenticator: ObservableObject, AuthenticatorProtocol {
    
    @Published var isLoggedIn: Bool = false
    @Published var currentPerson: Person?
    @Published var persons = [Person]()
    
    private var currentId = ""
    private var personListener: ListenerRegistration?
    
    @Trimmed var email = ""
    @Trimmed var password = ""
    @Trimmed var firstName = ""
    @Trimmed var lastName = ""
    @Trimmed var phoneNumber = ""
    
    var authService: AuthServiceProtocol = AuthService.shared
    var firestoreService: FirestoreServiceProtocol = FirestoreService.shared
    
    func clear() {
        email = ""
        password = ""
        firstName = ""
        lastName = ""
        phoneNumber = ""
    }
    
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
            if let user = Auth.auth().currentUser {
                currentId = user.uid
                isLoggedIn = true
                listenAllPersons()
            } else {
                isLoggedIn = false
                personListener?.remove()
            }
        }
    }
    
    func signin() async throws {
        do {
            currentId = try await authService.signin(email: email, password: password)
            DispatchQueue.main.async {
                self.isLoggedIn = true
                self.listenAllPersons()
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
            try await firestoreService.create(person, collection: .persons)
            DispatchQueue.main.async {
                self.listenAllPersons()
                self.currentId = uid
                self.currentPerson = person
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
            personListener?.remove()
        } catch {
            throw error
        }
    }
    
    func forgotpassword() {
        authService.forgotpassword()
    }
    
    func getPersonBy(recordId: String) async throws -> Person? {
        do {
            let person = try await firestoreService.getOneById(collection: .persons, type: Person.self, id: recordId)
            return person
        } catch {
            throw error
        }
    }
    
    func getPersonBy(userUID: String) async throws -> Person? {
        do {
            let person = try await firestoreService.getOneByKey(collection: .persons, type: Person.self, key: "userUID", value: userUID)
            return person
        } catch {
            throw error
        }
    }

    func update(_ person: Person) throws {
        do {
            try firestoreService.update(person, collection: .persons)
        } catch {
            throw error
        }
    }
    
    private func listenAllPersons() {
        personListener = Firestore.firestore().collection("persons").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            do {
                var objects = [Person]()
                for document in snapshot.documents {
                    let object = try document.decode(as: Person.self, includingId: true)
                    objects.append(object)
                }
                DispatchQueue.main.async {
                    self.persons = objects
                    let person = self.persons.first { $0.userUID == self.currentId }
                    self.currentPerson = person
                }
            } catch { }
        }
    }
    
}
