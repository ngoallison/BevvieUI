//
//  ScrollCalendar.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/9/23.
//
//  calendar view component

import SwiftUI

struct ScrollCalendar: View {
    
    @Binding var selectedDate: Date
    @Binding var breakdown: Bool
    @Binding var hadBev: Bool
    @State private var scrollToIndex: Int? = 16
    
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
            ScrollViewReader { proxy in
                ScrollView {
                    Spacer()
                    
                    // number of columns and months to display
                    let columns = Array(repeating: GridItem(.flexible()), count: 7)
                    let months = getMonths()
                    
                    VStack {
                        
                        // for each stack
                        ForEach(Array(months.enumerated()), id: \.element) { index, month in
                            VStack (spacing: 0) {
                                
                                // display month and year
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
                            }.id(index)
                            
                            // grid to display all days of month, white space for non aligned days
                            LazyVGrid(columns: columns, spacing: 10) {
                                let dates = monthDates(month: month)
                                ForEach(dates, id: \.self) { date in
                                    if date == .distantPast || date == .distantFuture {
                                        Color.clear.frame(width: 60, height: 60)
                                    } else {
                                        
                                        // toggle bevvie breakdown when date is clicked
                                        Button(action: {
                                            breakdown.toggle()
                                            self.selectedDate = date
                                            
                                            // check if current date is in array of all bev dates
                                            if bevDates.contains(date) {
                                                hadBev = true
                                            }
                                            else {
                                                hadBev = false
                                            }
                                        }, label: {
                                            
                                            // highlight dates if bev was purchased
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
                    }.onAppear {
                        if let index = scrollToIndex {
                            withAnimation {
                                proxy.scrollTo(index, anchor: .top)
                            }
                            scrollToIndex = nil
                        }
                    }
                }
                
            }.background(ColorModel().darkTan)
            
        }
    }
    
    // function to get array of months as date objects
    func getMonths() -> [Date] {
        
        var months: [Date] = []
        
        //var startDate = calendar.date(byAdding: .month, value: -12, to: Date())!
        var startDate = Date()
        let endDate = calendar.date(byAdding: .month, value: 12, to: Date())!
        
        
        // get the next 12 months
        while startDate <= endDate {
            months.append(startDate)
            startDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
        }
        
        return months
        
    }
    
    // function to get each of the dates per month
    func monthDates(month: Date) -> [Date] {
        
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: startOfMonth))!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        // append dates until end of the month, otherwise add padding
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
