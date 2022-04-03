//
//  PaymentsView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct PaymentsView: View {
    var body: some View {
        VStack {
            Text("Payments")
        }
        if MainView.NAMES {
            Names(name: "PaymentsView")
        } // NAMES
    }
}

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
    }
}
