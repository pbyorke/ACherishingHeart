//
//  PrettyLink.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/21/21.
//
// https://developer.apple.com/forums/thread/652980
//

import SwiftUI

struct PrettyLink<Target: View>: View {
    typealias Handler = () -> Void
    var label = ""
    var destination: Target
    var action: Handler
    var body: some View {
        HStack {
            NavigationLink(destination: destination) {
                Text(label)
            }
            .simultaneousGesture(TapGesture().onEnded {
                action()
            })
            Spacer()
        }
    }
}

#if DEBUG
struct PrettyLink_Previews: PreviewProvider {
    static var previews: some View {
        PrettyLink(label: "Dummy", destination: Text("Dummy")) { }
        .preview(with: "some string")
    }
}
#endif
