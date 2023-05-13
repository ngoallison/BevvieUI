//
//  AnalyticsBox.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/10/23.
//

import Foundation
import SwiftUI

struct AnalyticsBox: View {
    
    var size: CGFloat? = 130
    var title: String
    var header: String?
    var sub: String?
    var image: String? 
    
    var body: some View {
        VStack (spacing: 10) {
            Text(title)
                .foregroundColor(ColorModel().darkGreen)
                .font(Font.custom("Young", size: 17))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            ZStack {
                Rectangle().fill(ColorModel().darkTan)
                    .frame(width: ConstModel().width * 0.42, height: size!)
                    .cornerRadius(10)
                VStack {
                    if header != nil {
                        Text(header!)
                            .foregroundColor(ColorModel().darkGreen)
                            .font(Font.custom("Kiona", size: 30))
                            .fontWeight(.bold)
                    }
                    if image != nil {
                        Image(image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:80)
                    }
                    if sub != nil {
                        Text(sub!)
                            .foregroundColor(ColorModel().darkGreen)
                            .font(Font.custom("Kiona", size: 18))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }.padding()
    }
}

//struct AnalyticsBox_Preview: PreviewProvider {
//    static var previews: some View {
//            AnalyticsView()
//            .environmentObject(AnalyticsModel())
//            .environmentObject(BevModel())
//    }
//}

struct AnalyticsBox_Previews: PreviewProvider {
    static var previews: some View {
            AnalyticsView()
            .environmentObject(AnalyticsModel())
            .environmentObject(BevModel())
    }
}
