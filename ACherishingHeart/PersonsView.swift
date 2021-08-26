//
//  PersonsView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct PersonsView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    
    var masterView: Bool
    
    var body: some View {
        List {
            ForEach(authenticator.persons) { person in
                NavigationLink(destination: PersonView(person: person, masterView: masterView)) {
                    Button("\(person.firstName) \(person.lastName)") { }
                }
            }
        }
        .padding()
        .navigationTitle(Text("Persons"))
    }
}

#if DEBUG
struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView(masterView: true)
    }
}
#endif
