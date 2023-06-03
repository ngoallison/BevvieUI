//
//  EmptyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/12/22.
//
//  analytics view that contains graphs using user data

import SwiftUICharts
import SwiftUI
import Charts


struct GraphView: View {

    @EnvironmentObject var bevModel: BevModel
    
    let colors: [Color] = [ColorModel().lightGreen, ColorModel().darkGreen, ColorModel().mediumGreen]
    
    var body: some View {
        
        let barData = bevModel.getPerMonth()
        let lineData = bevModel.getLineMonth()
        let lineMoney = bevModel.getLineMoney()
                    
        let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: ColorModel().mediumGreen, secondGradientColor: ColorModel().lightGreen, textColor: ColorModel().darkGreen, legendTextColor: ColorModel().darkGreen, dropShadowColor: ColorModel().darkGreen.opacity(0.5))

        ZStack {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading, spacing: 15){
                Text("GRAPHS")
                    .font(Font.custom("Young", size: 25))
                    .foregroundColor(ColorModel().darkGreen)
                    .padding(.horizontal, 15)
                
                HStack {
                    
                    // bar chart with number of bevs per month, line chart with price over time
                    BarChartView(data: ChartData(values: barData), title: "Bevvies Per Month", legend: "Monthly", style: chartStyle, form: ChartForm.medium)
                    MultiLineChartView(data: [(lineMoney, GradientColor(start: ColorModel().darkGreen, end: ColorModel().mediumGreen))], title: "Price", style: chartStyle, dropShadow: true)
                }.padding(10)

                VStack {
                    
                    // line chart showing number of bevs over time
                    LineChartView(data: lineData, title: "Bevvies Over Time", legend: "Monthly", style: chartStyle, form: ChartForm.large).padding(.horizontal, 10) // legend is optional
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
        .environmentObject(BevModel())
    }
}
