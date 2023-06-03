//
//  AchievementIcons.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/8/23.
//
//  achievements view component that displays achivement icon and name as button to toggle details

import SwiftUI

struct AchievementIcons: View {

    @State private var showAchievement = false
    @State private var achievementName: String = ""
    @State private var achievementIcon: String = ""
    @State private var achievementGoal: String = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: (ConstModel().width)/3))
            ]) {
                // use index to identify each achivement numerically
                ForEach(ConstModel().icons.indices, id: \.self) { index in
                    VStack {
                        Button(action: {
                            
                            // set achievemnt information to be displayed
                            self.achievementName = ConstModel().names[index]
                            self.achievementIcon = ConstModel().icons[index]
                            self.achievementGoal = ConstModel().goal[index]
                            self.showAchievement.toggle()
                          }) {
                              
                              // displays icon
                              Image(ConstModel().icons[index])
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .padding(20)
                          }.buttonStyle(PlainButtonStyle())
                                .sheet(isPresented: (self.$showAchievement)) {
                                    
                                    // pass to details view
                                    AchievementDetails(
                                        showAchievement: $showAchievement,
                                        achievementName: $achievementName,
                                        achievementIcon: $achievementIcon,
                                        achievementGoal: $achievementGoal
                                    )
                                }
                        
                        // displays name
                        Text(ConstModel().names[index])
                            .multilineTextAlignment(.center)
                            .font(Font.custom("Young", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(ColorModel().darkGreen)
                        Spacer()
                    }
                    
                }.padding(20)
            }
        }.background(ColorModel().darkTan)
    }
}

struct AchievementIcons_Previews: PreviewProvider {
    static var previews: some View {
        AchievementIcons()
    }
}
