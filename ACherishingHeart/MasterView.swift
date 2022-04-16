//
//  MasterView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/2/21.
//

import SwiftUI

struct MasterView: View {
    
//    @State private var person = Person.new
    @State private var person = Person()

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                PrettyLink(label: "Media", spacer: true, destination: MediaView(type: .edit)) { }
                PrettyLink(label: "People", spacer: true, destination: PersonsView(masterView: true)) { }
                PrettyLink(label: "Finance", spacer: true, destination: FinanceView()) { }
            }
            .padding(20)
        }
        .navigationTitle("Master")
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        if MainView.NAMES {
            Names(name: "MasterView")
        } // NAMES
    }
}

struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
