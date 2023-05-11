//
//  BreakdownView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import SwiftUI

struct BreakdownView: View {
    
    let faces: [String] = ["cheery-face", "happy-face", "meh-face", "sad-face"]

    @Binding var breakdown: Bool
    @Binding var hadBev: Bool
    var bevDate: Date
    var bev: Bev
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter
    }()
    
   
    //let dateString = dateFormatter.string(from: Date())
   
    
    var body: some View {
        ZStack {
            if breakdown {
                // PopUp background color
                Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                // PopUp Window
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 300, height: ConstModel().height*0.57)
                            .cornerRadius2(25, corners: .allCorners)
                        VStack {
                            Button(action: {
                                //self.breakdown = false
                            }, label: {
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
                            })
                            VStack (spacing: 10){
                                Text("\(dateFormatter.string(from: bevDate))")
                                    .font(Font.custom("Young", size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorModel().darkGreen)
                                    .padding(5)
                                //Divider().padding(.horizontal, 10)
                                if hadBev {
                                    Image(bev.type! == "Boba" ? "breakdown-boba" : "coffee-cup")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:80)
                                        .padding(5)
                                    VStack (alignment: .leading, spacing: 13){
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
                                    HStack(spacing: 15.0) {
                                        ForEach(0..<4, id: \.self) { number in
                                            Image(faces[number]).resizable()
                                                .frame(width: 30, height: 30)
                                                .opacity(number == 0 ? 1.0 : 0.3)
                                            
                                            
                                        }
                                        
                                    }
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
//                                            Button(action: {
//
//                                            }) {
//                                                Text("ADD A BEVVIE")
//                                                    .padding(.all)
//                                                    .frame(width: 150, height: 40)
//                                                    .background(ColorModel().mediumGreen)
//                                                    .foregroundColor(.white)
//                                                    .cornerRadius(12.0)
//                                                    .font(Font.custom("Young", size: 17))
//                                            }
                                            
                                        }
                                    }
                                    
                                }
                                
                            }.padding(.horizontal, 20)
                            Spacer()
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
        BreakdownView(breakdown: .constant(true), hadBev: .constant(true), bevDate: (Calendar.current.date(byAdding: .day, value: 1, to: Date())!), bev: Bev(uid: "0", name: "Taro Milk Tea", location: "OMOMO", temp: "ICED", price: 5.00, type: "Boba", size: "Large", satisfaction: "happy-face"))
    }
}
