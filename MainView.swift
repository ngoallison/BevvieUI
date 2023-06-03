//
//  MainView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//
//  overarching app view

import Foundation
import SwiftUI

struct MainView: View {
    
    
    @Binding var isLoggedIn: Bool
    @Binding var isSignedUp: Bool
    @State var addPresent: Bool = false
    
    
    @State var selectedIndex = 0
    @State var settingsPresent = false
    
    var icons = ["house", "bell", "plus", "calendar", "chart.line.uptrend.xyaxis"]
    
    var body: some View {
        if settingsPresent {
            SettingsView(settingsPresent: $settingsPresent, isLoggedIn: $isLoggedIn, isSignedUp: $isSignedUp)
        } else {
            ZStack {
                VStack {
                    
                    // display view depending on navi button that was clicked
                    VStack(spacing: 0.0) {
                        ZStack {
                            
                            switch selectedIndex {
                            case 0:
                                HomeView(addPresent: $addPresent, settingsPresent: $settingsPresent)
                            case 1:
                                AchievementView()
                            case 2:
                                HomeView(addPresent: $addPresent, settingsPresent: $settingsPresent)
                            case 3:
                                CalendarView(selectedDate: Date())
                            case 4:
                                AnalyticsView()
                            default:
                                HomeView(addPresent: $addPresent, settingsPresent: $settingsPresent)
                            }
                        }
                    }
                    VStack(spacing: 0.0) {
                        Divider()
                        HStack(alignment: .center, spacing: 0.0) {
                            
                            // navi bar
                            ForEach(0..<5, id: \.self) { number in
                                Spacer()
                                Button(action: {
                                    if number == 2 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation(.spring()) {
                                                addPresent = true
                                            }
                                        }
                                    }
                                    else {
                                        self.selectedIndex = number
                                    }
                                }, label: {
                                    if number == 2 {
                                        Image(systemName: icons[number])
                                            .foregroundColor(.white)
                                            .frame(width: 40, height: 40)
                                            .background(Color(red:0.59, green:0.65, blue:0.55))
                                            .cornerRadius(30)
                                        
                                    }
                                    else {
                                        Image(systemName: icons[number])
                                            .font(.system(size:29))
                                            .foregroundColor(selectedIndex == number ? .black.opacity(0.9) : Color(UIColor.lightGray))
                                    }
                                })
                                Spacer()
                            }
                        }.frame(height: ConstModel().height * 0.07).background(.white)
                        
                    }
                }.blur(radius: addPresent ? 5 : 0)
                Color(.black)
                    .opacity(addPresent ? 0.4 : 0)
                    .ignoresSafeArea()
                if addPresent {
                    AddViewModal(addPresent: $addPresent)
                        .transition(.move(edge: .top))
                        .zIndex(1)
                }
            }
        }
    }
    
}


struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            MainView(isLoggedIn: .constant(true), isSignedUp: .constant(true), addPresent: false)
                .environmentObject(UserModel())
                .environmentObject(AnalyticsModel())
                .environmentObject(BevModel())
        }
    }
    
}
