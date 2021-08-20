//
//  MasterView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/2/21.
//

import SwiftUI

struct MasterView: View {
    
    @EnvironmentObject var authenticator: Authenticator

    @State private var person = Person.new

    var body: some View {
        TabView {
            PersonsView()
                .tabItem{Label("People", systemImage: "person.2") }
            AlbumsView()
                .tabItem{Label("Albums", systemImage: "folder") }
            SongsView()
                .tabItem{Label("Songs", systemImage: "music.quarternote.3") }
        }
//        List(authenticator.persons, id: \.id) { person in
//            NavigationLink(destination: PersonView(person: $person)) {
//                Button("\(person.firstName) \(person.lastName)") {
//                    self.person = person
//                }
//            }
//        }
//        .padding()
//        .navigationTitle(Text("All Persons"))
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
