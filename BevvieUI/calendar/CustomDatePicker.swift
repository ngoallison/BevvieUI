//
//  CustomDatePicker.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    // month update on arrow
    
    @State var currentMonth: Int = 0
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                
                // Days
                
                let days: [String] = ["S","M","T","W","TH","F","ST"]
                
                HStack(spacing: 20) {
                    Spacer()
                    Button(action: {
                        currentMonth -= 1

                    }, label: {
                        Image(systemName: "chevron.left").font(.title).foregroundColor(Color(.white))
                    })
                    Spacer()

                    VStack(alignment: .center, spacing: 0) {
                    Text("CALENDAR").fontWeight(.medium).font(Font.custom("Kiona", size: 25)).foregroundColor(.white)
                        
//                        Text(extraDate()[1].uppercased()).fontWeight(.medium).font(Font.custom("Kiona", size: 25)).foregroundColor(.white)
//                        Text(extraDate()[0]).fontWeight(.medium).font(Font.custom("Kiona", size: 17)).foregroundColor(.white)
                        
                        
                    }
                    Spacer()
                    Button(action: {
                        currentMonth += 1
                    }, label: {
                        Image(systemName: "chevron.right").font(.title).foregroundColor(Color(.white))
                    })
                    Spacer()

                    
                }.padding(.horizontal)
                
                
                VStack(spacing: 0.0) {
                    HStack(spacing: 0) {
                    ForEach(days, id: \.self) { day in
                        Spacer()
                        Text(day)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(Font.custom("Kiona", size: 16))
                        Spacer()
                    }
                }
                    Spacer()
                
                // Dates
                    VStack(spacing: 20.0) {
                        ZStack {
                            Rectangle().fill(ColorModel().lightTan).frame(width: ConstModel().deviceWidth, height: ConstModel().deviceHeight  * 0.85).cornerRadius(15)
                            let columns = Array(repeating: GridItem(.flexible()), count: 7)
                            VStack {
                                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(extractDate()) { value in
                                        CardView(value: value)
                                    }
                                }
                                Spacer()

                            }
                        }
                        
                        
                    }
                }
                
            }.onChange(of: currentMonth) { newValue in
                currentDate = getCurrentMonth()
            }
        }
    }
    
    @ViewBuilder
    
    func CardView(value : DateValue)->some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                .font(Font.custom("CaviarDreams", size: 20))
                .fontWeight(.bold)
                .foregroundColor(ColorModel().darkGreen)
            }
        }.padding(.vertical)
    }
    
    func extraDate()->[String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
        
    }
    
    func getCurrentMonth()->Date{
        
        // Getting Current month date
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate()->[DateValue]{
        

        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
                
        var days =  currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        // offset days
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}


extension Date {
    
    func getAllDates()->[Date] {
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
    
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day-1, to: startDate)!
        }
    }
}
