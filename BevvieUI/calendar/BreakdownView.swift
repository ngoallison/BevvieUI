//
//  BreakdownView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//
//  calendar view pop up modal that displays information about the bevvie purchased on a specific date

import SwiftUI

struct BreakdownView: View {
    
    @Binding var breakdown: Bool
    @Binding var hadBev: Bool
    
    var bevDate: Date
    var bev: Bev
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter
    }()
    
    var body: some View {
        ZStack {
            if breakdown {
                // PopUp background color
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                // PopUp Window
                VStack {
                    ZStack {
                        
                        // rectangle card
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 300, height: ConstModel().height*0.57)
                            .cornerRadius2(25, corners: .allCorners)
                        VStack {
                            
                            // header 
                            ZStack {
                                Rectangle()
                                    .fill(ColorModel().lightGreen)
                                    .frame(width: 300, height: 50)
                                    .cornerRadius2(25, corners: [.topLeft, .topRight])
                                Text("BEVVIE BREAKDOWN")
                                    .font(Font.custom("Young", size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorModel().darkGreen)
                                    .multilineTextAlignment(.center)
                            }
                            VStack (spacing: 10){
                                Text("\(dateFormatter.string(from: bevDate))")
                                    .font(Font.custom("Young", size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorModel().darkGreen)
                                
                                // show bev information
                                if hadBev {
                                    Image(bev.type! == "Boba" ? "breakdown-boba" : "coffee-cup")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:80)
                                        .padding(5)
                                    VStack (alignment: .leading, spacing: 13){
                                        
                                        // name stack
                                        VStack (alignment: .leading) {
                                            Text("Order")
                                                .font(Font.custom("Young", size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(ColorModel().darkGreen)
                                            Text("\(bev.name!)")
                                                .font(Font.custom("Cardium A Regular", size: 15))
                                                .fontWeight(.bold)
                                                .foregroundColor(ColorModel().darkGreen)
                                        }
                                        Divider()
                                        
                                        // type and temperature stack
                                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],alignment: .leading, spacing: 0) {
                                            VStack (alignment: .leading){
                                                Text("Type")
                                                    .font(Font.custom("Young", size: 18))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                                Text("\(bev.type!)")
                                                    .font(Font.custom("Cardium A Regular", size: 15))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                            }
                                            
                                            VStack (alignment: .leading){
                                                Text("Temperature")
                                                    .font(Font.custom("Young", size: 18))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                                Text("\(bev.temp!)")
                                                    .font(Font.custom("Cardium A Regular", size: 15))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                            }
                                            
                                        }
                                        Divider()
                                        
                                        // location and price stack
                                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],alignment: .leading, spacing: 0) {
                                            VStack (alignment: .leading){
                                                Text("Location")
                                                    .font(Font.custom("Young", size: 18))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                                Text("\(bev.location!)")
                                                    .font(Font.custom("Cardium A Regular", size: 15))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                            }
                                            
                                            VStack (alignment: .leading){
                                                Text("Price")
                                                    .font(Font.custom("Young", size: 18))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                                Text("$\(String(format: "%.2f", bev.price!))")
                                                    .font(Font.custom("Cardium A Regular", size: 15))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(ColorModel().darkGreen)
                                            }
                                            
                                        }
                                        Divider()
                                    }
                                    
                                    // satisfaction stack
                                    HStack(spacing: 15.0) {
                                        ForEach(ConstModel().faces, id: \.self) { face in
                                            Image(face).resizable()
                                                .frame(width: 30, height: 30)
                                                .opacity(bev.satisfaction! == face ? 1.0 : 0.3)
                                        }
                                        
                                    }
                                
                                // otherwise state that no was drunk
                                } else {
                                    Divider()
                                    VStack (spacing: 30){
                                        Text("Oh no! You didn't drink a bevvie today.")
                                            .font(Font.custom("Young", size: 18))
                                            .foregroundColor(ColorModel().darkGreen)
                                            .multilineTextAlignment(.center)
                                            .padding(5)
                                        Image("cup-spill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width:120)
                                            .padding(15)
                                        VStack (spacing: 5){
                                            Text("forgot to track a bevvie? go back to the main menu to add a bevvie!")
                                                .font(Font.custom("Young", size: 14))
                                                .foregroundColor(ColorModel().darkGreen)
                                                .multilineTextAlignment(.center)
                                                .padding(5)
                                        }
                                    }
                                    
                                }
                                
                            }.padding(.horizontal, 20)
                            Spacer()
                            
                            // close modal button
                            ZStack {
                                Button(action: {
                                    self.breakdown.toggle()
                                }, label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(ColorModel().mediumGreen)
                                            .frame(width: 300, height: 50)
                                            .cornerRadius2(25, corners: [.bottomRight, .bottomLeft])
                                        Text("CLOSE")
                                            .font(Font.custom("Kiona", size: 20))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                            .multilineTextAlignment(.center)
                                    }
                                })
                            }
                        }
                    }
                }.frame(width: 300, height: 175)
                
            }
        }
    }
}

struct BreakdownView_Previews: PreviewProvider {
    static var previews: some View {
        BreakdownView(breakdown: .constant(true), hadBev: .constant(true), bevDate: (Calendar.current.date(byAdding: .day, value: 1, to: Date())!), bev: Bev(uid: "0", name: "Taro Milk Tea", location: "OMOMO", temp: "ICED", price: 5.00, type: "Boba", size: "Large", satisfaction: "sad-face"))
    }
}
