//
//  BreakdownView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import SwiftUI

struct BreakdownView: View {
    
    var faces = ["cheery-face", "happy-face", "meh-face", "sad-face"]
    @State var selectedIndex = 0

    var body: some View {
        ZStack {
            ColorModel().orangeBrown.ignoresSafeArea()
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(ColorModel().lightTan)
                        .frame(width: ConstModel().deviceWidth, height: ConstModel().deviceHeight-120)
                    VStack {
                        Text("Today's bevvie breakdown: ")
                            .foregroundColor(ColorModel().darkGreen)
                            .font(Font.custom("CaviarDreams", size: 23))
                            .fontWeight(.bold)
                        
                        Image("breakdown-boba").resizable().frame(width: 100, height: 100)
                        HStack {
                            Text("ICED")
                                .font(Font.custom("CaviarDreams", size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .padding(.vertical, 5.0)
                                .background(ColorModel().mediumGreen)
                            Text("BOBA")
                                .font(Font.custom("CaviarDreams", size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .padding(.vertical, 5.0)
                                .background(ColorModel().mediumGreen)
                            Text("REGULAR")
                                .font(Font.custom("CaviarDreams", size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .padding(.vertical, 5.0)
                                .background(ColorModel().mediumGreen)
                        }
                        .padding(.all)
                        Divider()
                        VStack(spacing: 20.0) {
                        VStack(alignment: .leading) {
                            Text("Order")
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("CaviarDreams", size: 20))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                            Text("Wintermelon Milk Tea")
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("CaviarDreams", size: 20))
                            Divider()
                            
                        }
                        .padding([.top, .leading])
                        VStack(alignment: .leading) {
                            Text("Location")
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("CaviarDreams", size: 20))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                            Text("OMOMO")
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("CaviarDreams", size: 20))
                            Divider()
                            
                        }
                        .padding(.leading)
                        VStack(alignment: .leading) {
                            Text("Price")
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("CaviarDreams", size: 20))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                            Text("$5.83")
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("CaviarDreams", size: 20))
                            Divider()
                            
                        }
                        .padding(.leading)
                        }
                        HStack(spacing: 15.0) {
                            ForEach(0..<4, id: \.self) { number in
                                Button(action: {
                                    self.selectedIndex = number
                                }) {
                                    Image(faces[number]).resizable()
                                        .frame(width: 50, height: 50)
                                        .opacity(selectedIndex == number ? 1.0 : 0.3)
                                    //.foregroundColor(selectedIndex == number ? .black.opacity(0.9) : Color(UIColor.lightGray))
                                    
                                }
                            }
                                
                        }
                        .padding(.top)
                    
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        }
    }
}

struct BreakdownView_Previews: PreviewProvider {
    static var previews: some View {
        BreakdownView()
    }
}
