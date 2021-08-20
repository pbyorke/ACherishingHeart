//
//  PersonView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/4/21.
//

import SwiftUI

struct PersonView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authenticator: Authenticator
    
    @State private var id = ""
    @State private var userUID = ""
    @State private var isMedia = false
    @State private var isMaster = false
    @State private var isAdmin = false
    @State private var isJoyCoach = false
    @State private var isJCTeacher = false
    @State private var isJCStudent = false
    
    @Binding var person: Person
    
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
                    .disabled(true)
                TitledInputTextFieldView (
                    title: "userUID",
                    text: $userUID,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                    .disabled(true)
                TitledInputTextFieldView (
                    title: "Email Address",
                    text: $authenticator.email,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                    .disabled(true)
                TitledInputTextFieldView (
                    title: "Password",
                    text: $authenticator.password,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                    .disabled(true)
                TitledInputTextFieldView (
                    title: "First Name",
                    text: $authenticator.firstName,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "Last Name",
                    text: $authenticator.lastName,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView (
                    title: "Phone Number",
                    text: $authenticator.phoneNumber,
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
//        .task {
//            do {
//                if let person = try await authenticator.getPersonBy(recordId: personId) {
//                    id = person.id
//                    userUID = person.userUID
//                    authenticator.email = person.email
//                    authenticator.password = person.password
//                    authenticator.firstName = person.firstName
//                    authenticator.lastName = person.lastName
//                    authenticator.phoneNumber = person.phoneNumber
//                    isMedia = person.isMedia
//                    isMaster = person.isMaster
//                    isAdmin = person.isAdmin
//                    isJoyCoach = person.isJoyCoach
//                    isJCTeacher = person.isJCTeacher
//                    isJCStudent = person.isJCStudent
//                }
//            } catch {
//            }
//        }
    }
    
    private func save() {
        let person = Person(
            id: id,
            userUID: userUID,
            email: authenticator.email,
            password: authenticator.password,
            firstName: authenticator.firstName,
            lastName: authenticator.lastName,
            phoneNumber: authenticator.phoneNumber,
            isMedia: isMedia,
            isMaster: isMaster,
            isAdmin: isAdmin,
            isJoyCoach: isJoyCoach,
            isJCTeacher: isJCTeacher,
            isJCStudent: isJCStudent
        )
        do {
            try authenticator.update(person)
            presentationMode.wrappedValue.dismiss()
        } catch { }
    }
    
}

//struct PersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonView(personId: "dummy")
//    }
//}
