//
//  AccountView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/26/21.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            Text("AccountView")
            DebugView()
        }
        if MainView.NAMES {
            Names(name: "AccountView")
        } // NAMES
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
