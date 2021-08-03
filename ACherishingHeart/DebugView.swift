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
        HStack {
            Spacer()
            Text("Person: ")
            if let person = authenticator.currentPerson {
                Text("\(person.firstName) \(person.lastName)")
            } else {
                Text("no currentPerson")
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
