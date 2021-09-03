//
//  MediaView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/16/21.
//

import SwiftUI

struct MediaView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                PrettyLink(label: "Folders", spacer: true, destination: FoldersView()) { }
                PrettyLink(label: "Items", spacer: true, destination: ItemsView()) { }
                PrettyLink(label: "Courses", spacer: true, destination: CoursesView()) { }
            }
            .padding(20)
        }
        .navigationTitle( Text("Media Administrator") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        if MainView.NAMES {
            Names(name: "MediaView")
        } // NAMES
    }
}

#if DEBUG
struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        MediaView()
    }
}
#endif
