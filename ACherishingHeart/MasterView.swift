//
//  MasterView.swift
//  MasterView
//
//  Created by Peter Yorke on 8/2/21.
//

import SwiftUI

struct MasterView: View {
    
    @EnvironmentObject var authenticator: Authenticator

    @State private var person = Person.new

    var body: some View {
        List(authenticator.persons, id: \.id) { person in
//            NavigationLink(destination: MasterPersonView(personId: person.id)) {
//                Text("\(person.firstName) \(person.lastName)")
//            }
            NavigationLink(destination: MasterPersonView(person: $person)) {
                Button("\(person.firstName) \(person.lastName)") {
                    self.person = person
                }
            }
        }
        .padding()
        .navigationTitle(Text("All Persons"))
    }
}

//struct MasterView_Previews: PreviewProvider {
//    static var previews: some View {
//        MasterView()
//    }
//}
