//
//  PrivacyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

import SwiftUI

struct TermsView: View {
    
    @Binding var termsPresent: Bool
    
    var body: some View {
        ZStack {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            VStack (spacing: 20) {
                HStack {
                    Button(action: {
                        termsPresent = false
                    }, label: {
                        Image(systemName: "arrow.left").font(.title).foregroundColor(.black)
                    }
                    )
                    Spacer()
                }
                .padding(.leading)
                Text("Terms and Conditions")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 27))
                    .frame(width: ConstModel().width, alignment: .leading)
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
                Text("BEVVIE @ 2022").font(Font.custom("Kiona", size: 20)).foregroundColor(ColorModel().darkGray)
                
            }.padding(20)
            
          
        }
    }
}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsView(termsPresent: .constant(true))
    }
}
