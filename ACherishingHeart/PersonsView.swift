//
//  PersonsView.swift
//  PersonsView
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct PersonsView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    
    @State var selectedPerson: Person = Person.new
    
    var body: some View {
        List {
            ForEach(authenticator.persons) { person in
                NavigationLink(destination: PersonView(person: $selectedPerson)) {
                    Button("\(person.firstName) \(person.lastName)") {
                        selectedPerson = person
                    }
                }
            }
        }
        .padding()
        .navigationTitle(Text("Persons"))
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView()
    }
}
