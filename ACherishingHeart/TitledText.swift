//
//  TitledText.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/20/21.
//

import SwiftUI

struct TitledText: View {
    
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(text)
        }
    }
}

#if DEBUG
struct TitledText_Previews: PreviewProvider {
    static var previews: some View {
        TitledText(title: "title", text: "text")
    }
}
#endif
