//
//  PrettyLink.swift
//  PrettyLink
//
//  Created by Peter Yorke on 8/21/21.
//
// https://developer.apple.com/forums/thread/652980
//

import SwiftUI

struct PrettyLink<TargetView: View>: View {
    var text: String
    var action: TargetView
    var body: some View {
        NavigationLink(destination: action) {
            HStack {
                Text(text)
                Spacer()
            }
        }
    }
}

#if DEBUG
struct PrettyLink_Previews: PreviewProvider {
    static var previews: some View {
        PrettyLink(text: "Dummy", action: Text("Dummy"))
    }
}
#endif
