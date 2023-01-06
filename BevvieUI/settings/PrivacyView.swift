//
//  PrivacyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

import SwiftUI

struct PrivacyView: View {
    
    @Binding var privacyPresent: Bool
    var policy: String = "I have maybe only 2 or 3 friends who know about this, but I'm going to publicly confess this. I buy bubble tea with pearls and drink the tea, taking special care not to swallow any pearls. I take the pearls home and individually wash them off."
    var policy2: String = "Then I get undressed on the bed, stick the straw in my ass, and individually let the pearls down the straw. Gravity does most of the work, but sometimes they get stuck and I give the straw a little tap. I walk around and get used to the feeling of boba in my ass, and then wait till I need to shit. I have a 96% ejection rate, but I'm not sure where the rest of them go."
    
    var body: some View {
        ZStack {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            VStack (spacing: 20) {
                HStack {
                    Button(action: {
                        privacyPresent = false
                    }, label: {
                        Image(systemName: "arrow.left").font(.title).foregroundColor(.black)
                    }
                    )
                    Spacer()
                }
                .padding(.leading)
                Text("Privacy Policy")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 27))
                    .frame(width: ConstModel().deviceWidth, alignment: .leading)
                VStack(spacing: 30) {
                    Text(policy)
                    .fontWeight(.bold)
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 18))
                    .lineSpacing(7)

                    .frame(width: ConstModel().deviceWidth * 0.90, alignment: .leading)
                Text(policy2)
                    .fontWeight(.bold)
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 18))
                    .lineSpacing(7)
                    .frame(width: ConstModel().deviceWidth * 0.90, alignment: .leading)
                }
                Spacer()
                Text("BEVVIE @ 2022").font(Font.custom("Kiona", size: 20)).foregroundColor(ColorModel().darkGray)
                
            }.padding(20)
            
          
        }
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView(privacyPresent: .constant(true))
    }
}
