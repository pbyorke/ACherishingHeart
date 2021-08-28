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
    @State private var person = Person.new
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(authenticator.persons) { person in
                    HStack {
                        PrettyLink(label: "\(person.firstName) \(person.lastName)", destination: PersonView(person: $person, masterView: masterView)) { self.person = person }
                        Spacer()
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle(Text("Persons"))
        .font(.title2)
    }
}

#if DEBUG
struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView(masterView: true)
    }
}
#endif
