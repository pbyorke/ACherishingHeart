//
//  Swipe.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct Swipe: View {
    
    var symbol: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button { action() } label: {
            Label("label", systemImage: symbol)
        }
        .tint(color)
    }
}

struct Swipe_Previews: PreviewProvider {
    static var previews: some View {
        Swipe(symbol: "plus", color: .yellow) { }
        .preview(with: "wipe function")
    }
}
