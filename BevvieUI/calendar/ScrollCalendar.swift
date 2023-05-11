//
//  ScrollCalendar.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/9/23.
//

import SwiftUI

struct ScrollCalendar: View {
    
    @Binding var selectedDate: Date
    @Binding var breakdown: Bool
    @Binding var hadBev: Bool
    
    @EnvironmentObject var bevModel: BevModel
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    
    var body: some View {
        let bevDates = bevModel.getDates()
        ZStack {
            ScrollView {
                Spacer()
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                let months = getMonths()
                ForEach(months, id: \.self) { month in
                    VStack (spacing: 0) {
                        HStack {
                            
                            let monthStr = calendar.monthSymbols[calendar.component(.month, from: month)-1].uppercased()
                            Text("\(monthStr)")
                                .font(Font.custom("Young", size: 21))
                                .foregroundColor(ColorModel().darkGreen)
                            
                            let year = String(calendar.component(.year, from: month))
                            Text("\(year)")
                                .font(Font.custom("Young", size: 24))
                                .foregroundColor(ColorModel().darkGreen)
                            
                            Spacer()
                        }.padding(.leading, 20)
                        Divider()
                            .frame(height: 1)
                            .overlay(ColorModel().darkGreen)
                            .padding()
                    }
                    LazyVGrid(columns: columns, spacing: 10) {
                        let dates = monthDates(month: month)
                        ForEach(dates, id: \.self) { date in
                            if date == .distantPast || date == .distantFuture {
                                Color.clear.frame(width: 60, height: 60)
                            } else {
                                Button(action: {
                                    breakdown.toggle()
                                    self.selectedDate = date
                                    if bevDates.contains(date) {
                                        hadBev = true
                                    }
                                    else {
                                        hadBev = false
                                    }
                                }, label: {
                                    ZStack {
                                        if bevDates.contains(date) {
                                            Circle()
                                                .fill(ColorModel().darkGreen)
                                                .opacity(0.2)
                                                .frame(width: 38, height: 38)
                                        }
                                        
                                        Text(dateFormatter.string(from: date))
                                            .font(Font.custom("Young", size: 22))
                                            .foregroundColor(ColorModel().darkGreen)
                                    }
                                    .frame(width: 60, height: 60)
                                })
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }.background(ColorModel().darkTan)
        }
    }
    
    func getMonths() -> [Date] {
        
        var months: [Date] = []
        var startDate = Date()
        var endDate = calendar.date(byAdding: .month, value: 12, to: startDate)!
        
        
        // get the next 12 months
        while startDate <= endDate {
            months.append(startDate)
            startDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
        }
        
        return months
        
    }
    
    func monthDates(month: Date) -> [Date] {
        
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
    }
    
    
}

struct ScrollCalendar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollCalendar(selectedDate: .constant(Date()), breakdown: .constant(false), hadBev:.constant(false)).environmentObject(BevModel())
    }
}
