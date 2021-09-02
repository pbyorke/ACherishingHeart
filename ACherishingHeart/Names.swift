//
//  Names.swift
//  Names
//
//  Created by Pete Yorke on 9/1/21.
//

import SwiftUI

struct Names: View {
    var name = ""
    var body: some View {
        HStack {
            Text(name)
                .foregroundColor(.cyan)
            Spacer()
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, alignment: Alignment.bottomLeading)
    }
}
