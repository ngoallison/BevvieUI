//
//  PrivacyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//
//  settings page that shows mock privacy conditions

import SwiftUI
import Firebase

struct PrivacyView: View {
    
    @Binding var privacyPresent: Bool
    
    var body: some View {
        ZStack {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            VStack (spacing: 20) {
                
                // back button
                HStack {
                    Button(action: {
                        privacyPresent = false
                    }, label: {
                        Image(systemName: "arrow.left").font(.title).foregroundColor(.black)
                    })
                    Spacer()
                }
                .padding(.leading)
                Text("Privacy Policy")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 27))
                    .frame(width: ConstModel().width, alignment: .leading)
                
                // text blocks
                VStack(spacing: 30) {
                    Text(ConstModel().policy1)
                        .fontWeight(.bold)
                        .foregroundColor(ColorModel().darkGray)
                        .font(Font.custom("Young", size: 16))
                        .lineSpacing(7)
                    
                        .frame(width: ConstModel().width * 0.90, alignment: .leading)
                    Text(ConstModel().policy2)
                        .fontWeight(.bold)
                        .foregroundColor(ColorModel().darkGray)
                        .font(Font.custom("Young", size: 16))
                        .lineSpacing(7)
                        .frame(width: ConstModel().width * 0.90, alignment: .leading)
                }
                Spacer()
            }.padding(20)
            
            
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView(privacyPresent: .constant(true))
    }
}

