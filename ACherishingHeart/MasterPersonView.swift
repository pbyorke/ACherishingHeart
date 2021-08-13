//
//  MasterPersonView.swift
//  MasterPersonView
//
//  Created by Peter Yorke on 8/4/21.
//

import SwiftUI

struct MasterPersonView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    
    @State private var id = ""
    @State private var userUID = ""
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var isMedia = false
    @State private var isMaster = false
    @State private var isAdmin = false
    @State private var isJoyCoach = false
    @State private var isJCTeacher = false
    @State private var isJCStudent = false
    
    var personId: String
    
    var body: some View {
        VStack {
            Group {
                TitledInputTextFieldView (
                    title: "ID",
                    text: $id,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "userUID",
                    text: $userUID,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "Email Address",
                    text: $email,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "Password",
                    text: $password,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "First Name",
                    text: $firstName,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "Last Name",
                    text: $lastName,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "Phone Number",
                    text: $phoneNumber,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
            }
            Group {
                Toggle("Is Media", isOn: $isMedia)
                Toggle("Is Master", isOn: $isMaster)
                Toggle("Is Admin", isOn: $isAdmin)
                Toggle("Is Joy Coach", isOn: $isJoyCoach)
                Toggle("Is Joy Coach Teacher", isOn: $isJCTeacher)
                Toggle("Is Joy Coach Student", isOn: $isJCStudent)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Edit Person")
        .toolbar {
            Button("Save") { save() }
        }
        .task {
            do {
                if let person = try await authenticator.getPersonBy(recordId: personId) {
                    id = person.id
                    userUID = person.userUID
                    email = person.email
                    password = person.password
                    firstName = person.firstName
                    lastName = person.lastName
                    phoneNumber = person.phoneNumber
                    isMedia = person.isMedia
                    isMaster = person.isMaster
                    isAdmin = person.isAdmin
                    isJoyCoach = person.isJoyCoach
                    isJCTeacher = person.isJCTeacher
                    isJCStudent = person.isJCStudent
                }
            } catch {
            }
        }
    }
    
    private func save() {
        let person = Person(
            id: id,
            userUID: userUID,
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            isMedia: isMedia,
            isMaster: isMaster,
            isAdmin: isAdmin,
            isJoyCoach: isJoyCoach,
            isJCTeacher: isJCTeacher,
            isJCStudent: isJCStudent
        )
    }
    
}

struct MasterPersonView_Previews: PreviewProvider {
    static var previews: some View {
        MasterPersonView(personId: "dummy")
    }
}
