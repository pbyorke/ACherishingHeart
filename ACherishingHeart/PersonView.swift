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
    
    var person: Person
    var masterView: Bool
    
    var body: some View {
        VStack {
            Group {
                Text(person.email)
                TitledInputTextFieldView(
                    title: "First Name",
                    text: $authenticator.firstName,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView(
                    title: "Last Name",
                    text: $authenticator.lastName,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                TitledInputTextFieldView(
                    title: "Phone Number",
                    text: $authenticator.phoneNumber,
                    placeholder: "",
                    keyboardType: .default,
                    sfSymbol: nil
                )
            }
            Group {
                if masterView {
                    Toggle("Inactive", isOn: $authenticator.inactive)
                    Toggle("Delinquent", isOn: $authenticator.delinquent)
                }
                Toggle("Media", isOn: $authenticator.media)
                if masterView {
                    Toggle("Master", isOn: $authenticator.master)
                    Toggle("Admin", isOn: $authenticator.admin)
                }
                Toggle("Joy Coach", isOn: $authenticator.joyCoach)
                Toggle("Joy Coach Teacher", isOn: $authenticator.JCTeacher)
                Toggle("Joy Coach Student", isOn: $authenticator.JCStudent)
                Toggle("Subscriber", isOn: $authenticator.subscriber)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Edit Person")
        .toolbar {
            Button("Save") { save() }
        }
        .onAppear {
            authenticator.fill(person: person)
        }
    }
    
    private func save() {
        let person = Person(
            id: person.id,
            userUID: person.userUID,
            email: authenticator.email,
            password: authenticator.password,
            firstName: authenticator.firstName,
            lastName: authenticator.lastName,
            phoneNumber: authenticator.phoneNumber,
            inactive: authenticator.inactive,
            delinquent: authenticator.delinquent,
            media: authenticator.media,
            master: authenticator.master,
            admin: authenticator.admin,
            joyCoach: authenticator.joyCoach,
            JCTeacher: authenticator.JCTeacher,
            JCStudent: authenticator.JCStudent,
            subscriber: authenticator.subscriber
        )
        do {
            try authenticator.update(person)
            presentationMode.wrappedValue.dismiss()
        } catch { }
    }
    
}

#if DEBUG
struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(
            person: Person.new,
            masterView: true
        )
    }
}
#endif
