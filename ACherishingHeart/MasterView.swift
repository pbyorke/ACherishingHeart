//
//  MasterView.swift
//  MasterView
//
//  Created by Peter Yorke on 8/2/21.
//

import SwiftUI

struct MasterView: View {
    
    @EnvironmentObject var authenticator: Authenticator

    var body: some View {
        List(authenticator.persons, id: \.id) { person in
            NavigationLink(destination: MasterPersonView(personId: person.id)) {
                Text("\(person.firstName) \(person.lastName)")
            }
        }
        .padding()
        .navigationTitle(Text("All Persons"))
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
