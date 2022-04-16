//
//  Authenticator.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/22/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class Authenticator: ObservableObject {

    static let shared = Authenticator()    
    private let dataStore = DataStore()
    private let authService: AuthServiceProtocol = AuthService.shared
    private let firestoreService: FirestoreServiceProtocol = FirestoreService.shared
    
    @Published var isLoggedIn: Bool = false
    @Published var currentPerson: Person?
    @Published var persons = [Person]()
    
    private var currentId = ""
    private var personListener: ListenerRegistration?
    
    var isAnonymous: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.anonymous
        } else {
            return false
        }
    }
    
    var isInactive: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.inactive
        } else {
            return false
        }
    }
    
    var isDelinquent: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.delinquent
        } else {
            return false
        }
    }
    
    var isMedia: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.media
        } else {
            return false
        }
    }
    
    var isMaster: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.master
        } else {
            return false
        }
    }
    
    var isAdmin: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.admin
        } else {
            return false
        }
    }
    
    var isFinance: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.finance
        } else {
            return false
        }
    }
    
    var isSubscriber: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.subscriber
        } else {
            return false
        }
    }
    
    var isJoyCoach: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.joyCoach
        } else {
            return false
        }
    }
    
    var isJCTeacher: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.JCTeacher
        } else {
            return false
        }
    }
    
    var isJCStudent: Bool {
        if let currentPerson = currentPerson {
            return currentPerson.JCStudent
        } else {
            return false
        }
    }
    
    private init() { }
    
    func setup() {
        Task.init {
            if let user = Auth.auth().currentUser {
                currentId = user.uid
                isLoggedIn = true
                listenAllPersons()
            } else {
                if let person = dataStore.getDefaultPerson() {
                    print("* * *  there was a default person")
                    currentId = person.userUID
                    isLoggedIn = true
                    listenAllPersons()
                } else {
                    do {
                        let authResult = try await Auth.auth().signInAnonymously()
                        let user = authResult.user
                        let uid = user.uid
                        let email = "thecherishingplaceapp+\(uid)@gmail.com"
                        let password = "password"
                        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
                        try await user.link(with: credential)
                        let person = Person(userUID: uid, email: email, password: password, anonymous: true, promisedRate: 0)
                        try await firestoreService.create(person, collection: .persons)
                        await dataStore.setDefaultPerson(person)
                        DispatchQueue.main.async { [self] in
                            currentId = person.userUID
                            isLoggedIn = true
                            listenAllPersons()
                        }
                    } catch {
                        print("* * *  Authenticator setup error \"\(error.localizedDescription)\"")
                    }
                }
            }
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
                DispatchQueue.main.async { [self] in
                    persons = objects
                    let person = self.persons.first { $0.userUID == self.currentId }
                    currentPerson = person
                }
            } catch {
                print("* * *  listenAllPersons error \"\(error.localizedDescription)\"")
            }
        }
    }
    
    func signin(person: Person) async throws {
        do {
            currentId = try await authService.signin(email: person.email, password: person.password)
            DispatchQueue.main.async {
                self.isLoggedIn = true
                self.listenAllPersons()
            }
        } catch {
            throw(error)
        }
    }

    func signup(person: Person) async throws {
        do {
            let uid = try await authService.signup(email: person.email, password: person.password)
//            let person = Person.namedPerson(
            let person = Person(
                userUID: uid,
                email: person.email,
                password: person.password,
                firstName: person.firstName,
                lastName: person.lastName,
                phoneNumber: person.phoneNumber,
                promisedRate: person.promisedRate
            )
//            let person = Person(
//                id:             "",
//                userUID:        uid,
//                email:          person.email,
//                password:       person.password,
//                firstName:      person.firstName,
//                lastName:       person.lastName,
//                phoneNumber:    person.phoneNumber,
//                anonymous:      false,
//                inactive:       false,
//                delinquent:     false,
//                media:          false,
//                master:         false,
//                admin:          false,
//                finance:        false,
//                subscriber:     false,
//                joyCoach:       false,
//                JCTeacher:      false,
//                JCStudent:      false,
//                promisedRate:   person.promisedRate
//            )
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
    
//    Auth.auth().currentUser?.updateEmail(to: email) { error in
//      // ...
//    }
    
//    Auth.auth().currentUser?.sendEmailVerification { error in
//      // ...
//    }
    
//    Auth.auth().currentUser?.updatePassword(to: password) { error in
//      // ...
//    }
        
//    Auth.auth().sendPasswordReset(withEmail: email) { error in
//      // ...
//    }
        
}
