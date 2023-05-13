//
//  EmptyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/12/22.
//

import SwiftUICharts
import SwiftUI
import Charts


struct EmptyView: View {
    
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var anaModel: AnalyticsModel
    @EnvironmentObject var bevModel: BevModel
    
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    let colors: [Color] = [ColorModel().lightGreen, ColorModel().darkGreen, ColorModel().mediumGreen]
    var temp: [bevMonth] = [
        .init(month: "Jan", count: 1),
        .init(month: "Feb", count: 0),
        .init(month: "Mar", count: 4),
        .init(month: "Apr", count: 5),
        .init(month: "May", count: 8),
        .init(month: "Jun", count: 3),
        .init(month: "Jul", count: 1),
        .init(month: "Aug", count: 0),
        .init(month: "Sep", count: 4),
        .init(month: "Oct", count: 5),
        .init(month: "Nov", count: 8),
        .init(month: "Dec", count: 3),
    ]
    
    var body: some View {
        
        let data = bevModel.getPerMonth()
        let linedata = bevModel.getLineMonth()
        let lineMoney = bevModel.getLineMoney()
                    
        let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: ColorModel().mediumGreen, secondGradientColor: ColorModel().lightGreen, textColor: ColorModel().darkGreen, legendTextColor: ColorModel().darkGreen, dropShadowColor: ColorModel().darkGreen.opacity(0.5) )

        ZStack {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading, spacing: 15){
                Text("GRAPHS")
                    .font(Font.custom("Young", size: 25))
                    .foregroundColor(ColorModel().darkGreen)
                    .padding(.horizontal, 15)
//                Chart {
//                    ForEach(temp) { month in
//                        BarMark (
//                            x: .value("Month", month.month),
//                            y: .value("Bevs", month.count)
//                        ).foregroundStyle(ColorModel().lightGreen)
//                            .cornerRadius(5)
//                        
//                    }
//                }
//                    
                
                HStack {
                    BarChartView(data: ChartData(values: data), title: "Bevvies Per Month", legend: "Monthly", style: chartStyle, form: ChartForm.medium)
                    MultiLineChartView(data: [(lineMoney, GradientColor(start: ColorModel().darkGreen, end: ColorModel().mediumGreen))], title: "Price", style: chartStyle, dropShadow: true)
                                       
                  
//                    PieChartView(data: [8,23,54,32], title: "Title", legend: "Legendary", style: chartStyle) // legend is optional
                }.padding(10)
                
//                LineChartView(data: lineMoney, title: "Price", legend: "Monthly", style: chartStyle, form: ChartForm.small)
                VStack {
                    LineChartView(data: linedata, title: "Bevvies Over Time", legend: "Monthly", style: chartStyle, form: ChartForm.large).padding(.horizontal, 10) // legend is optional
                    HStack {
                        Text("January 2023").font(Font.custom("Cardium A Regular", size: 12))
                        Spacer()
                        Text("December 2023").font(Font.custom("Cardium A Regular", size: 12))

                    }.padding(.horizontal, 20)
                }
                Spacer()
            }



        }
        
    }
}
struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
        .environmentObject(AnalyticsModel())
        .environmentObject(BevModel())
//        EmptyView().environmentObject(UserModel()).environmentObject(AnalyticsModel()).environmentObject(BevModel())
    }
}
