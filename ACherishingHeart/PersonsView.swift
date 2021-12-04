//
//  PersonsView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/19/21.
//

import SwiftUI

struct PersonsView: View {
    
    @EnvironmentObject var authenticator: Authenticator
    @EnvironmentObject var coursesInPerson: CoursesInPerson

    var masterView: Bool
    @State private var person = Person.new
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(authenticator.persons) { person in
                    PrettyLink(label: "\(person.firstName) \(person.lastName)", spacer: true, destination: PersonTabView(person: $person, masterView: masterView)) {
                        self.person = person
                        coursesInPerson.setup(person)                        
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle(Text("Persons"))
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        if MainView.NAMES {
            Names(name: "PersonsView")
        } // NAMES
    }
}

#if DEBUG
struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView(masterView: true)
    }
}
#endif
