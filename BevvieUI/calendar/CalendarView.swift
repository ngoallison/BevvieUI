//
//  CalendarView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import Foundation
import SwiftUI


struct CalendarView: View {
    
    let days: [String] = ["S", "M", "T", "W", "TH", "F", "SA"]

    //isWaterDate: waterDates.contains(date)
    
    var body: some View {
        
        ZStack(alignment: .center)  {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack (alignment: .center) {
                    VStack {
                        Spacer()
                        Text("CALENDAR")
                            .font(Font.custom("Kiona", size: 30))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .tracking(5)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Spacer()
                        ZStack {
                            Rectangle().fill(ColorModel().lightTan)
                                .cornerRadius2(25, corners: [.topLeft, .topRight])
                                .edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * 0.85)
                            VStack {
                                VStack (spacing: 0) {
                                    let cols = Array(repeating: GridItem(.flexible()), count: 7)
                                    LazyVGrid(columns: cols, spacing: 0) {
                                            ForEach(days, id: \.self) { day in
                                                Text(day)
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .fontWeight(.bold)
                                                    .font(Font.custom("Kiona", size: 20))
                                                    .padding(.vertical, 10)
                                            }
                                    }.padding(.horizontal, 20)
                                    Divider()
                                    ScrollCalendar()
                                }.edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * 0.85)
                                
                            }
                            
                        }
                    }.frame(height: ConstModel().deviceHeight * (0.85))
                    
                }
            }
        
        }
        
//        ZStack {
//            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
//            VStack {
//                Text("CALENDAR")
//                    .font(Font.custom("Kiona", size: 30))
//                    .fontWeight(.regular)
//                    .foregroundColor(.white)
//                    .tracking(5)
//                    .multilineTextAlignment(.center)
//                    .frame(maxWidth: .infinity)
//                Spacer()
//                ZStack {
//                    Rectangle().fill(ColorModel().lightTan)
//                        .cornerRadius2(25, corners: [.topLeft, .topRight])
//                        .edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * 0.85)
//                    VStack {
//                        let cols = Array(repeating: GridItem(.flexible()), count: 7)
//                        LazyVGrid(columns: cols, spacing: 10) {
//                                ForEach(days, id: \.self) { day in
//                                    Text(day)
//                                        .foregroundColor(ColorModel().darkGreen)
//                                        .fontWeight(.bold)
//                                        .font(Font.custom("Kiona", size: 20))
//                                        .padding(.top, 25)
//                                }
//                        }.padding(.horizontal, 20)
//                        Divider().frame(height:2)
//                        Spacer()
//                    }
//                }
//            }
//            VStack {
//
//            }.frame(height: ConstModel().deviceHeight*0.80).padding(.top, 100)
//        }
    }
    
}

struct CalendarView_Preview: PreviewProvider {
    static var previews: some View {
        CalendarView().previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
    }
}
