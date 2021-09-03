//
//  FinanceView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct FinanceView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                PrettyLink(label: "Payments", spacer: true, destination: PaymentsView()) { }
            }
            .padding(20)
        }
        .navigationTitle( Text("Finance Administrator") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        if MainView.NAMES {
            Names(name: "FinanceView")
        } // NAMES
    }
}

#if DEBUG
struct FinanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceView()
    }
}
#endif
