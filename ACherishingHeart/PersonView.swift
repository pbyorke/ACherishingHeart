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
    @EnvironmentObject var coursesInFolder: CoursesInFolder
    
    var storageService: StorageServiceProtocol = StorageService.shared
    var add = false
    @Binding var person: Person
    var masterView: Bool
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button("Save") { save() }
                    }
                    TitledInputTextFieldView(
                        title: "First Name",
                        text: $person.firstName,
                        placeholder: "",
                        keyboardType: .default,
                        sfSymbol: nil
                    )
                    TitledInputTextFieldView(
                        title: "Last Name",
                        text: $person.lastName,
                        placeholder: "",
                        keyboardType: .default,
                        sfSymbol: nil
                    )
                    TitledInputTextFieldView(
                        title: "Phone Number",
                        text: $person.phoneNumber,
                        placeholder: "",
                        keyboardType: .default,
                        sfSymbol: nil
                    )
                }
                .padding(.trailing, 10)
                VStack {
                    if masterView {
                        Toggle("Inactive", isOn: $person.inactive)
                        Toggle("Delinquent", isOn: $person.delinquent)
                    }
                    Toggle("Media", isOn: $person.media)
                    if masterView {
                        Toggle("Master", isOn: $person.master)
                        Toggle("Admin", isOn: $person.admin)
                        Toggle("Finance", isOn: $person.finance)
                    }
                    Toggle("Joy Coach", isOn: $person.joyCoach)
                    Toggle("Joy Coach Teacher", isOn: $person.JCTeacher)
                    Toggle("Joy Coach Student", isOn: $person.JCStudent)
                    Toggle("Subscriber", isOn: $person.subscriber)
                }
                .padding(.trailing, 10)
                if MainView.NAMES {
                    Names(name: "PersonView")
                } // NAMES
            }
        }
        .padding(15)
        .navigationTitle(person.email)
    }
    
    private func save() {
        do {
            try authenticator.update(person)
            presentationMode.wrappedValue.dismiss()
        } catch { }
    }
    
}

struct PersonView_Previews: PreviewProvider {
    @State static var person = Person.new
    static var previews: some View {
        PersonView(person: $person, masterView: true)
            .environmentObject(Authenticator.shared)
            .preview(with: "Add or update a Person")
    }
}
