//
//  CustomTextField.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/19/22.
//

import SwiftUI

struct CustomSecurefield: View {
    //MARK:- PROPERTIES
    
    var placeholder: Text
    var fontName: String? = ConstModel().textFont
    var fontSize: CGFloat? = 17
    var backgroundColor: Color? = ColorModel().orangeBrown
    var opacity: Double? = 0.3
    var foregroundColor: Color?
    var icon: String?
    
    @Binding var password: String
    //var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                if icon != nil {
                    Image(systemName: icon!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: nil, alignment: .center)
                        .foregroundColor(ColorModel().darkGray)
                        .padding(.trailing, 5)
                }
                ZStack {
                    if password.isEmpty {
                        placeholder.foregroundColor(.gray)
                            .font(Font.custom(fontName!, size: fontSize!))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    SecureField("", text: $password, onCommit: commit)
                        .font(Font.custom(fontName!, size: fontSize!))
                        .foregroundColor((foregroundColor != nil) ?  foregroundColor : Color.primary)
                        .padding(.trailing, 17.0)
                }
            }
            .frame(height: 40.0)
            .padding(.leading, 17.0)
            .background(backgroundColor!)
            .opacity(opacity!)
            .cornerRadius(15)
        }
    }
}
