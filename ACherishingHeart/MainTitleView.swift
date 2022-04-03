//
//  MainTitleView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 7/21/21.
//

import SwiftUI

struct MainTitleView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text("A")
                Text("Cherishing")
                Text("Heart")
            }
            .font(.largeTitle)
            .padding(.trailing, 20)
        }
    }
}

// MARK: - Preview

struct MainTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MainTitleView()
            .preview(with: "Main Title")
    }
}
