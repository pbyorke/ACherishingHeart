//
//  DebugView.swift
//  DebugView
//
//  Created by Peter Yorke on 8/2/21.
//

import SwiftUI

struct DebugView: View {

    @EnvironmentObject var authenticator: Authenticator

    var body: some View {
        VStack {
            if let person = authenticator.currentPerson {
                HStack {
                    Spacer()
                    Text("\(person.firstName) \(person.lastName)")
                }
                HStack {
                    Spacer()
                    Text("\(person.id)")
                }
                HStack {
                    Spacer()
                    Text("count \(authenticator.persons.count) persons")
                }
            } else {
                HStack {
                    Spacer()
                Text("no currentPerson")
                }
            }
        }
        .padding(.trailing, 20)
        .font(.footnote)
        .foregroundColor(.red)
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
