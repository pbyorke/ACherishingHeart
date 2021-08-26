//
//  NavigationButtonView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 7/28/21.
//

import SwiftUI

struct NavigationButtonView: View {
    
    typealias ActionHandler = () -> Void
    
    let title: String
    let background: Color
    let foreground: Color
    let handler: ActionHandler
    
    internal init(
        title: String,
        background: Color = .blue,
        foreground: Color = .white,
        handler: @escaping NavigationButtonView.ActionHandler
    ) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler, label: {
            Text(title)
        })
            .background(background)
            .foregroundColor(foreground)
            .font(.system(size: 14, weight: .regular))
    }
}

#if DEBUG
struct NavigationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationButtonView(title: "Primary Button") { }
            .preview(with: "Primary NavigationButton View")
            NavigationButtonView(
                title: "Secondary NavigationButton",
                background: .clear,
                foreground: .blue) { }
                .preview(with: "Secondary NavigationButton View")
        }
    }
}
#endif
