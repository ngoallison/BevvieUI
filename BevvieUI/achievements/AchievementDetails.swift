//
//  AchievementView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//

import Foundation
//
//  HomeView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//

import Foundation
import SwiftUI

struct AchievementDetails: View {

    @Binding var showAchievement: Bool
    @Binding var achievementName: String
    @Binding var achievementIcon: String

    var icons = ["hot-coffee", "heart", "ice-cubes", "boba", "skull", "money", "trash", "therapy", "seven", "stop"]
    var names = ["HOT CROSS BUNS", "LOVER BOY"]//, "ICE ICE BABY", "BOBADDICTION", "SIPPING SHORTAGE", "BROKE A**"]
    
    var body: some View {
        ZStack {
            ColorModel().lightTan.ignoresSafeArea(.all)
            VStack(spacing: 0.0) {
                ZStack {
//                    Rectangle()
//                    .fill(Color(red:0.76, green:0.79, blue:0.74))
//                    .frame(height: 80)
                    VStack(spacing: 0.0) {
                        Text(achievementName)
                        .fontWeight(.medium)
                        .foregroundColor(ColorModel().darkGreen)
                        .font(Font.custom("Kiona", size: 25))
                        .padding(.bottom, 15.0)
                        .frame(width: ConstModel().deviceWidth, height: 80, alignment: .bottom)
                        .background(ColorModel().darkTan.opacity(0.7))
                        Divider()
                        VStack {
                            Spacer()

                            Text("Goal: Purchase at least 175 boba bevvies")        .fontWeight(.regular)
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("Cardium A Regular", size: 25))
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 20.0)
                            Spacer()
                            Image(achievementIcon).resizable().frame(width:175, height: 175)
                            Spacer()
                            Text("75 boba bevvies left!")        .fontWeight(.medium)
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("Cardium A Regular", size: 25))
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 20.0)
                            Spacer()

                        }
                        Spacer()
                        Button(action: {
                            //filename.structname.yourvariable
                            self.showAchievement.toggle()
                        }, label: {
                            Text("BACK")
                                .fontWeight(.bold)
                                .frame(width: ConstModel().deviceWidth, height: 80)
                                .background(ColorModel().mediumGreen)
                                .foregroundColor(.white)
                                .font(Font.custom("Young", size: 24))
                            
                        })
                    }
                }
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea(.all)
        }
    }
}


struct AchivementDetails_Preview: PreviewProvider {
    static var previews: some View {
        AchievementDetails(showAchievement: .constant(false), achievementName: .constant("HOT CROSS BUNS"), achievementIcon: .constant("hot-coffee")).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
    }
}


