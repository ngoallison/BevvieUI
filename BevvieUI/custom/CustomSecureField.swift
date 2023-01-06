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
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    var backgroundColor: Color
    var opacity: Double
    var foregroundColor: Color?
    
    @Binding var password: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if password.isEmpty { placeholder.foregroundColor(.gray).font(Font.custom("Cardium A Regular", size: 17)).padding(.leading, 17.0) }
            SecureField("", text: $password, onCommit: commit)
                .font(Font.custom("Cardium A Regular", size: 17))
                .frame(height: 40.0)
                .padding(.leading, 17.0)
                .background(Color(red:0.80, green:0.60, blue:0.49))
                .opacity(0.3)
                .cornerRadius(10)
                .foregroundColor((foregroundColor != nil) ?  foregroundColor : Color.primary)
        }
    }
}
