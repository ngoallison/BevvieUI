//
//  CustomTextField.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/19/22.
//

import SwiftUI

struct CustomTextfield: View {
    //MARK:- PROPERTIES
    var placeholder: Text
    var fontName: String
    var fontSize: CGFloat
    var fontColor: Color
    var backgroundColor: Color
    var opacity: Double
    var foregroundColor: Color?
    var icon: String?
    
    @Binding var username: String
    var editingChanged: (Bool)->() = { _ in }
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
                    //Spacer()
                }
                ZStack {
                    if username.isEmpty {
                        placeholder.foregroundColor(.gray)
                            .font(Font.custom("Cardium A Regular", size: 17))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    TextField("", text: $username,  onEditingChanged: editingChanged, onCommit: commit)
                        .font(Font.custom("Cardium A Regular", size: 17))
                        .foregroundColor((foregroundColor != nil) ?  foregroundColor : Color.primary)
                        .padding(.trailing, 17.0)
                }
            }
            .frame(height: 40.0)
            .padding(.leading, 17.0)
            .background(Color(red:0.80, green:0.60, blue:0.49))
            .opacity(0.3)
            .cornerRadius(15)
        }
    }
}

