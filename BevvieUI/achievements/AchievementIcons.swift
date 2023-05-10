//
//  AchievementIcons.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/8/23.
//

import SwiftUI

struct AchievementIcons: View {

    @State private var showAchievement = false
    @State var achievementName: String
    @State var achievementIcon: String
    @State var achievementGoal: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: (ConstModel().deviceWidth)/3))
            ]) {
                ForEach(ConstModel().icons.indices, id: \.self) { index in
                    VStack {
                        Button(action: {
                            self.achievementName = ConstModel().names[index]
                            self.achievementIcon = ConstModel().icons[index]
                            self.achievementGoal = ConstModel().goal[index]
                            self.showAchievement.toggle()
                          }) {
                              Image(ConstModel().icons[index])
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .padding(20)
                                  //.frame(width: 90, height: 90)
                          }.buttonStyle(PlainButtonStyle())
                                .sheet(isPresented: (self.$showAchievement)) {
                                    AchievementDetails(
                                        showAchievement: $showAchievement,
                                        achievementName: $achievementName,
                                        achievementIcon: $achievementIcon,
                                        achievementGoal: $achievementGoal
                                    )
                                }
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
        AchievementIcons(achievementName: "", achievementIcon: "", achievementGoal: "")
    }
}
