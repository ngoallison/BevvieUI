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

struct AchievementView: View {

    @State private var theName = ""
    @State private var theIcon = ""
    
    @State private var selectedStatus = 0
    
    var icons: [String]
    var names: [String]
    var lines: Int
    var index = 0
    
    var allItems:  [[String : String]]
    var lineItems: [String : String]
    
    var iconGroups: [[String]] = []
    var nameGroups: [[String]] = []
    
    var status = ["UNLOCKED", "LOCKED"]
    
    init() {
        icons = ["hot-coffee", "heart", "ice-cubes", "boba", "skull", "money", "trash", "therapy", "seven", "stop"]
        names = ["HOT CROSS BUNS", "LOVER BOY", "ICE ICE BABY", "BOBADDICTION", "SIPPING SHORTAGE", "BROKE A**", "TRASH TOWN", "BETTER HELP", "7 BEVVIES IN HEAVEN", "CHANGE UP"]
        
        if icons.count % 2 != 0 {
            icons.append("")
            names.append("")
        }
        
        lines = (icons.count)/2
        allItems = []
        lineItems = [:]
        groupItems()
                
    }
    
    mutating func increaseIndex() {
        self.index += 1
    }
    
    mutating func groupItems() {
        
        var tempIcons: [String] = []
        var tempNames: [String] = []
        
        var num = 0
        
        for _ in 0..<lines {
            for _ in 0..<2 {
                if num == icons.count {
                    break
                }
                tempIcons.append(icons[num])
                tempNames.append(names[num])
                num += 1
            }
            iconGroups.append(tempIcons)
            nameGroups.append(tempNames)
            tempIcons = []
            tempNames = []
            //tempDict = [:]
        }

    
        
    }
    
    var body: some View {
        ZStack(alignment: .center)  {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack (alignment: .center) {
                    VStack {
                        Spacer()
                        Text("ACHIEVEMENTS")
                            .font(Font.custom("Kiona", size: 30))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .tracking(2)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            //.padding(.top, 10.0)
                        
                        Spacer()
                        ZStack {
                            Rectangle().fill(ColorModel().lightTan)
                                .cornerRadius2(25, corners: [.topLeft, .topRight])
                                .edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * 0.85)
                            VStack {
                                Spacer()
                                VStack {
                                    HStack {
                                        ForEach(0..<2, id: \.self) { number in
                                            Spacer()
                                            Button(action: {
                                                self.selectedStatus = number
                                            }, label: { Text(status[number]).font(Font.custom("Cardium A Regular", size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(self.selectedStatus == number ? ColorModel().darkGreen : ColorModel().darkGreen.opacity(0.5))
                                            })
                                            Spacer()
                                        }

                                    }.padding(10)
                                    AchievementIcons(achievementName: "", achievementIcon: "", achievementGoal: "").frame(height: ConstModel().deviceHeight * 0.73)
                                    Spacer()
                                    // she was here before
                                }.edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * 0.85)
                                
                            }
                            
                        }
                    }.frame(height: ConstModel().deviceHeight * (0.85))
                    
                }
            }
        
        }
    }
}




struct AchievementView_Preview: PreviewProvider {
    static var previews: some View {
        AchievementView().previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
