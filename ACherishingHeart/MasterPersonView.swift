//
//  MasterPersonView.swift
//  MasterPersonView
//
//  Created by Peter Yorke on 8/4/21.
//

import SwiftUI

struct MasterPersonView: View {
    
    @EnvironmentObject var authenticator: Authenticator
//    @State private var person = Person()
//    var person = Person()
//    @State private var email = ""

    var id: String

    var body: some View {
//        if let pers = person {
        VStack {
//            TextField("Email address", text: $per.email)
//            InputTextFieldView(
//                text: $email,
//                placeholder: "Email",
//                keyboardType: .emailAddress,
//                sfSymbol: "envelope"
//            )
//            Text("\(person?.email ?? "whatever")")
            Text("\(id)")
        }
        .task {
            do {
//            person = try await authenticator.getPerson(id: id)
            } catch { }
        }
        .navigationTitle("Edit Person")
//        }
    }
}

struct MasterPersonView_Previews: PreviewProvider {
    static var previews: some View {
        MasterPersonView(id: "dummy")
    }
}

//struct Personx {
//    var email: String
//    var password: String
//}
//
//extension Personx {
//
//    static var new: Personx {
//        Personx(email: "", password: "")
//    }
//
//}
