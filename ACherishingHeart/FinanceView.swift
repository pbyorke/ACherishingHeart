//
//  FinanceView.swift
//  FinanceView
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct FinanceView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    PrettyLink(label: "Payments", destination: PaymentsView()) { }
                    Spacer()
                }
            }
            .padding(20)
        }
        .navigationTitle( Text("Finance Administrator") )
        .font(.title2)
    }
}

#if DEBUG
struct FinanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceView()
    }
}
#endif
