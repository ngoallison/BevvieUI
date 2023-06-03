//
//  Achievement Details.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//
//  pop up window that appears to show the details of a specific achievement when clicked from achievement view

import Foundation
import SwiftUI

struct AchievementDetails: View {
    
    @Binding var showAchievement: Bool
    @Binding var achievementName: String
    @Binding var achievementIcon: String
    @Binding var achievementGoal: String
    
    
    var body: some View {
        ZStack {
            ColorModel().lightTan.ignoresSafeArea(.all)
            VStack(spacing: 0.0) {
                ZStack {
                    VStack(spacing: 0.0) {
                        
                        // stack showing achievement name, goal, icon
                        Text(achievementName)
                            .fontWeight(.medium)
                            .foregroundColor(ColorModel().darkGreen)
                            .font(Font.custom("Young", size: 25))
                            .padding(15.0)
                            .frame(width: ConstModel().width, height: 80, alignment: .center)
                            .background(ColorModel().darkTan.opacity(0.7))
                        Divider()
                        VStack {
                            Spacer()
                            
                            Text("Goal: " + achievementGoal)       .fontWeight(.regular)
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("Cardium A Regular", size: 25))
                                .multilineTextAlignment(.center)
                                .padding(23.0)
                            Spacer()
                            ZStack {
                                VStack {
                                    Spacer()
                                    Ellipse()
                                        .fill(ColorModel().darkTan)
                                        .frame(width: 200, height: 50)
                                }
                                Image(achievementIcon).resizable().frame(width:175, height: 175).frame(height: 200)
                            }.frame(height: 220)
                            Spacer()
                            Spacer()
                            
                        }
                        Spacer()
                        
                        // back button
                        Button(action: {
                            self.showAchievement.toggle()
                        }, label: {
                            Text("BACK")
                                .fontWeight(.bold)
                                .frame(width: ConstModel().width, height: 80)
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
        AchievementDetails(showAchievement: .constant(false), achievementName: .constant("HOT CROSS BUNS"), achievementIcon: .constant("hot-coffee"),
                           achievementGoal: .constant("Order 10 hot bevvies!")).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
    }
}


