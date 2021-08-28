//
//  WhyView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/31/21.
//

import SwiftUI

struct WhyView: View {
    var body: some View {
        NavigationView {
            Text("Why")
                .navigationTitle( Text("Why") )
        }
    }
}

#if DEBUG
struct WhyView_Previews: PreviewProvider {
    static var previews: some View {
        WhyView()
    }
}
#endif
