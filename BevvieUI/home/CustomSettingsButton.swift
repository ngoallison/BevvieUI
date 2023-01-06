//
//  CustomTextField.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/19/22.
//

import SwiftUI
import FirebaseAuth

struct CustomSettingsButton: View {
    
    //MARK:- PROPERTIES
    
    var buttonName: String
    var buttonColor: Color
    var clicked: (() -> Void)

    var body: some View {
        Button(action: clicked) {
            ZStack {
                HStack {
                    Text(buttonName)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(ColorModel().darkGray)
                        .font(Font.custom("Young", size: 20))
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(.black.opacity(0.5))
                    
                }
                .padding(.horizontal)
                Rectangle().fill(buttonColor).frame(width: ConstModel().deviceWidth, height: ConstModel().deviceHeight * 0.08)
                    
            }
        }
    }
}
