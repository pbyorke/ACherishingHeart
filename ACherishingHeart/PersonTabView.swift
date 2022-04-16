//
//  PersonTabView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 9/17/21.
//

import SwiftUI

struct PersonTabView: View {
    
    @Binding var person: Person
    var masterView: Bool

    var body: some View {
        TabView {
            PersonView(person: $person, masterView: masterView).tabItem { Label("Info", systemImage: "gearshape.fill") }
            PersonCoursesView().tabItem { Label("Courses", systemImage: "books.vertical.fill") }
        }
    }
}

struct PersonTabView_Previews: PreviewProvider {
//    @State static var person = Person.new
    @State static var person = Person()
    static var previews: some View {
        PersonTabView(person: $person, masterView: true)
            .preview(with: "Add or update a Person")
    }
}
