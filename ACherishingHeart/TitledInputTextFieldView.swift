//
//  TitledInputTextFieldView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/10/21.
//

import SwiftUI

struct TitledInputTextFieldView: View {
    
    let title: String
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TextField(placeholder, text: $text)
                .frame(maxWidth: .infinity, minHeight: 44)
                .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .background(
                    ZStack(alignment: .leading) {
                        if let systemImage = sfSymbol {
                            Image(systemName: systemImage)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.leading, 5)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.gray.opacity(0.25))
                    }
                )
        }
    }
}

#if DEBUG
struct TitledInputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TitledInputTextFieldView(
                title: "email",
                text: .constant(""),
                placeholder: "Email",
                keyboardType: .emailAddress,
                sfSymbol: "envelope"
            )
                .preview(with: "Email Text Input with sfsymbol")
            TitledInputTextFieldView(
                title: "first name",
                text: .constant(""),
                placeholder: "First Name",
                keyboardType: .default,
                sfSymbol: nil
            )
                .preview(with: "First Name Text Input with sfsymbol")
        }
    }
}
#endif
