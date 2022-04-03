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
    
    var label: String? = ""
    var image: String? = ""
    var spacer: Bool? = false
    var destination: Target
    var action: Handler
    
    var body: some View {
        HStack {
            NavigationLink(destination: destination) {
                if let label = label {
                    if label != "" {
                        Text(label)
                    }
                }
                if let image = image {
                    if image != "" {
                        Image(systemName: image)
                    }
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                action()
            })
            if let spacer = spacer {
                if spacer {
                    Spacer()
                }
            }
        }
    }
}

struct PrettyLink_Previews: PreviewProvider {
    static var previews: some View {
        PrettyLink(label: "Dummy", destination: Text("Dummy")) { }
        .preview(with: "some string")
    }
}
