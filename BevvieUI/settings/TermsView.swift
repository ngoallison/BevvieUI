//
//  PrivacyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

import SwiftUI

struct TermsView: View {
    
    @Binding var termsPresent: Bool
    var terms: String = "I’m gonna be honest here - Bubble Tea is overrated. I went to a local Bubble Tea shop yesterday. It’s the first time I’ve tried Bubble Tea. I order mango milk tea with mango pobbles. The wait was about 5 minutes. The tea is cold; you can ask for it warm or hot. Anyway, I take my bubble tea and start drinking it about 5 minutes later when the car is parked."
    var terms2: String = "At first, it tastes delicious. Only until you get the slightly bitter taste of the tea. It honestly tasted like mango juice mixed with milk, it’s nothing special really. The pobbles pop awkwardly in your mouth, it was kind of satisfying as the shell broke and the liquid oozed out. However by the time I got down to the bottom of my regular-sized bubble tea, my tummy felt bad. I think it was upset. The tea was a 6/10, but the after effects were a 0. I could have sharted my pants last night."
    
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
                    .frame(width: ConstModel().deviceWidth, alignment: .leading)
                VStack(spacing: 30) {
                    Text(terms)
                    .fontWeight(.bold)
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 16))
                    .lineSpacing(7)

                    .frame(width: ConstModel().deviceWidth * 0.90, alignment: .leading)
                Text(terms2)
                    .fontWeight(.bold)
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 16))
                    .lineSpacing(7)
                    .frame(width: ConstModel().deviceWidth * 0.90, alignment: .leading)
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
