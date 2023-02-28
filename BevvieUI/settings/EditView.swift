//
//  PrivacyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

import SwiftUI

struct EditView: View {
    
    @Binding var editPresent: Bool
    var terms: String = "I’m gonna be honest here - Bubble Tea is overrated. I went to a local Bubble Tea shop yesterday. It’s the first time I’ve tried Bubble Tea. I order mango milk tea with mango pobbles. The wait was about 5 minutes. The tea is cold; you can ask for it warm or hot. Anyway, I take my bubble tea and start drinking it about 5 minutes later when the car is parked."
    var terms2: String = "At first, it tastes delicious. Only until you get the slightly bitter taste of the tea. It honestly tasted like mango juice mixed with milk, it’s nothing special really. The pobbles pop awkwardly in your mouth, it was kind of satisfying as the shell broke and the liquid oozed out. However by the time I got down to the bottom of my regular-sized bubble tea, my tummy felt bad. I think it was upset. The tea was a 6/10, but the after effects were a 0. I could have sharted my pants last night."
    
    @State var username: String = ""
    @State var isLoading: Bool = false

    var body: some View {
        ZStack {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            VStack (alignment: .center, spacing: 20) {
                HStack {
                    Button(action: {
                        editPresent = false
                    }, label: {
                        Image(systemName: "arrow.left").font(.title).foregroundColor(.black)
                    }
                    )
                    Spacer()
                }
                .padding(.leading)
                Text("Edit Profile")
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .foregroundColor(ColorModel().darkGray)
                    .font(Font.custom("Young", size: 27))
                    .frame(width: ConstModel().deviceWidth-50, alignment: .leading)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Change Username").font(Font.custom("Cardium A Regular", size: 14))
                        CustomTextfield(placeholder: Text("Jayson Marie Catsby"), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $username)
                    }.padding(.bottom)
                    
                    Text("Change Title").font(Font.custom("Cardium A Regular", size: 14))
                    CustomTextfield(placeholder: Text("coffee connoisseur"), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $username)
                }.frame(width: ConstModel().deviceWidth - 50)
                
                Button(action: {
                            isLoading = true
                        }) {
                            if isLoading {
                                ProgressView()
                                    .foregroundColor(.white)
                            } else {
                                Text("Save Changes")
                                    .padding(.all)
                                    .frame(width: 200, height: 40)
                                    .background(ColorModel().mediumGreen)
                                    .foregroundColor(.white)
                                    .cornerRadius(18.0)
                                    .font(Font.custom("Cardium A Regular", size: 17))
                            }
                        }.padding()
                        .disabled(isLoading)
                        
                Spacer()
                Text("BEVVIE @ 2022").font(Font.custom("Kiona", size: 20)).foregroundColor(ColorModel().darkGray)
                
            }
            
          
        }
    }
}

struct EditView_Preview: PreviewProvider {
    static var previews: some View {
        EditView(editPresent: .constant(true))
    }
}
