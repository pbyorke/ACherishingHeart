//
//  MasterView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/2/21.
//

import SwiftUI

struct MasterView: View {
    
    @State private var person = Person.new

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    PrettyLink(label: "Media", destination: MediaView()) { }
                    Spacer()
                }
                HStack {
                    PrettyLink(label: "People", destination: PersonsView(masterView: true)) { }
                    Spacer()
                }
            }
            .padding(20)
        }
        .navigationTitle("Master")
        .font(.title2)
    }
}

#if DEBUG
struct MasterView_Previews: PreviewProvider {
    static var previews: some View {
        MasterView()
    }
}
#endif
