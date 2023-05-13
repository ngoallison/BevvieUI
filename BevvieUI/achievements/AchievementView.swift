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
    
    @State private var selectedStatus = 0
    var status = ["UNLOCKED", "LOCKED"]
    
    
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
                        Spacer()
                        ZStack {
                            Rectangle().fill(ColorModel().lightTan)
                                .cornerRadius2(25, corners: [.topLeft, .topRight])
                                .edgesIgnoringSafeArea(.all).frame(height: ConstModel().height * 0.80)
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
                                    AchievementIcons(achievementName: "", achievementIcon: "", achievementGoal: "")
                                    Spacer()
                                    // she was here before
                                }.edgesIgnoringSafeArea(.all).frame(height: ConstModel().height * 0.80)
                                
                            }
                            
                        }
                    }.frame(height: ConstModel().height * (0.80))
                    
                }
            }
            
        }
    }
}




struct AchievementView_Preview: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserModel())
            .environmentObject(AnalyticsModel())
            .environmentObject(BevModel())
//        AchievementView().previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
