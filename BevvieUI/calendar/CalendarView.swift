//
//  CalendarView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import Foundation
import SwiftUI


struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var showSheet: Bool = false;
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    private let monthFormatter: DateFormatter = {
        let mFormatter = DateFormatter()
        mFormatter.dateFormat = "LLLL"
        return mFormatter
    }()
    
    @ObservedObject private var bevModel = BevViewModel()
    var allbevDates: [Date] = []
    let days: [String] = ["S", "M", "T", "W", "TH", "F", "SA"]

    //isWaterDate: waterDates.contains(date)
    
    var body: some View {
        let bevDates: [Date] = bevModel.getDates()
        ZStack {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            VStack {
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
                        let cols = Array(repeating: GridItem(.flexible()), count: 7)
                        LazyVGrid(columns: cols, spacing: 10) {
                                ForEach(days, id: \.self) { day in
                                    Text(day)
                                        .foregroundColor(ColorModel().darkGreen)
                                        .fontWeight(.bold)
                                        .font(Font.custom("Kiona", size: 20))
                                        .padding(.top, 25)
                                }
                        }.padding(.horizontal, 20)
                        Divider().frame(height:2)
                        Spacer()
                    }
                }
            }
            VStack {
                ScrollView {
                    Spacer()
                    let columns = Array(repeating: GridItem(.flexible()), count: 7)
                    ForEach(getMonths(), id: \.self) { month in
                        VStack (spacing: 0) {
                            HStack {
                                Text("\(calendar.monthSymbols[calendar.component(.month, from: month)-1])".uppercased())
                                    .font(Font.custom("Young", size: 25))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorModel().darkGreen)
                                //\(calendar.component(.year, from: month)-1)
                                let year = String(calendar.component(.year, from: month))
                                Text(year)
                                    .font(Font.custom("Young", size: 28))
                                    .fontWeight(.bold)
                                    .foregroundColor(ColorModel().darkGreen)
                                Spacer()
                            }.padding(.leading, 20)
                            Divider()
                                .frame(height: 1)
                                .overlay(ColorModel().darkGreen)
                                .padding()
                        }
                        //                    Text(monthFormatter.string(from: month))
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(monthDates(month: month), id: \.self) { date in
                                if date == .distantPast {
                                    // Empty view for padding at the beginning of the month
                                    Color.clear
                                        .frame(width: 60, height: 60)
                                } else if date == .distantFuture {
                                    // Empty view for padding at the end of the month
                                    Color.clear
                                        .frame(width: 60, height: 60)
                                } else {
                                    ZStack {
                                        if bevDates.contains(date) {
//                                        if calendar.isDate(date, inSameDayAs: selectedDate) {
                                            Button(action: {
                                                self.showSheet.toggle()
                                            }, label: {
                                                Circle()
                                                    .fill(ColorModel().lightGreen)
                                                    .opacity(0.5)
                                                    .frame(width: 38, height: 38)
                                                
                                            }).buttonStyle(PlainButtonStyle())
                                                .sheet(isPresented: (self.$showSheet)) {
                                                    BreakdownView()
                                                }
                                                
                                            }
//                                            Circle()
//                                                .fill(ColorModel().lightGreen)
//                                                .opacity(0.5)
//                                                .frame(width: 38, height: 38)
//                                                .onTapGesture {
//                                                    print("hi");
//                                                    self.showSheet.toggle()
//                                                }
//                                                .sheet(isPresented: (self.showSheet)) {
//                                                        BreakdownView()
//                                                    }
//
//                                        }
//                                        }
                                            
                                        Text(dateFormatter.string(from: date))
                                            .font(Font.custom("Young", size: 22))
                                            .foregroundColor(ColorModel().darkGreen)
                                    }
                                    .frame(width: 60, height: 60)
                                }
                                
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                    }
                }
            }.frame(height: ConstModel().deviceHeight*0.80).padding(.top, 100)
        }
    }
    
    private func getMonths() -> [Date] {
        
        var months: [Date] = []
        var futureDateComponent = DateComponents()
        futureDateComponent.month = 1
        
        var pastDateComponent = DateComponents()
        pastDateComponent.month = -1
        
        var currentDate = Date()
        var startDate = Date()
        //var startDate = calendar.date(byAdding: .month, value: -12, to: currentDate)!
        var endDate = calendar.date(byAdding: .month, value: 12, to: currentDate)!

        
//        while currentDate <= endDate {
//            months.append(currentDate)
//            currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
//        }
        
        while startDate <= endDate {
            months.append(startDate)
            startDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
        }
        
        return months
        
    }
    
    private func monthDates(month: Date) -> [Date] {
        
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfMonth))!
        
        var dates: [Date] = []
        var currentDate = startDate

        while currentDate <= endOfMonth {
            if calendar.isDate(currentDate, equalTo: startOfMonth, toGranularity: .month) || calendar.isDate(currentDate, equalTo: endOfMonth, toGranularity: .month) {
                dates.append(currentDate)
            } else {
                dates.append(.distantPast) // Empty date to pad the beginning or end of the month
            }
            
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        if dates.count % 7 != 0 {
            let paddingCount = 7 - (dates.count % 7)
            for _ in 0..<paddingCount {
                dates.append(.distantFuture) // Empty date to pad the end of the month
            }
        }
        
        return dates
//
//        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
//        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
//        let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfMonth))!
//        var dates: [Date] = []
//        var currentDate = startDate
//
//        while currentDate <= endOfMonth {
//            dates.append(currentDate)
//            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
//        }
//
//        return dates
    }
}

struct CalendarView_Preview: PreviewProvider {
    static var previews: some View {
        CalendarView().previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
    }
}
