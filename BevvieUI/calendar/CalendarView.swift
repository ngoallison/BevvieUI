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
    @State var breakdown: Bool = false
    @State var hadBev: Bool = false
    @State var selectedDate: Date = Date()
    
    @EnvironmentObject var bevModel: BevModel

    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    
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
                            .tracking(2)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Spacer()
                        ZStack {
                            Rectangle().fill(ColorModel().lightTan)
                                .cornerRadius2(25, corners: [.topLeft, .topRight])
                                .edgesIgnoringSafeArea(.all).frame(height: ConstModel().height * 0.85)
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
                                    ScrollCalendar(selectedDate: $selectedDate, breakdown: $breakdown, hadBev: $hadBev)
                                }.edgesIgnoringSafeArea(.all).frame(height: ConstModel().height * 0.85)
                                
                            }
                            
                        }
                    }.frame(height: ConstModel().height * (0.85))
                    
                }
            }.blur(radius: breakdown ? 5 : 0)
            BreakdownView(breakdown: $breakdown, hadBev: $hadBev, bevDate: selectedDate, bev: bevModel.getBevFromDate(bevDate: dateFormatter.string(from: selectedDate)))
        
        }
    
    }
    
}

struct CalendarView_Preview: PreviewProvider {
    static var previews: some View {
        CalendarView() .environmentObject(BevModel())
    }
}
