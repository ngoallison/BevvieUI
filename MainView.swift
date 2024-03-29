//
//  MasterView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @State private var showSheet = false
    @State var selectedIndex = 0
    @State var isPresenting = false
    
    var icons = ["house", "bell", "plus", "calendar", "chart.line.uptrend.xyaxis"]
    
    var body: some View {
        if isPresenting {
            SettingsView(isLoggedIn: .constant(true), isPresenting: $isPresenting, isSignedUp: .constant(true))
        } else {
        ZStack {
            Color(.black).ignoresSafeArea()
            ZStack {
                VStack(spacing: 0.0) {
                    ZStack {

                        switch selectedIndex {
                            case 0:
                            HomeView(isPresenting: $isPresenting, isLoggedIn: .constant(true))
                            case 1:
                                AchievementView()
                            case 2:
                                HomeView(isPresenting: $isPresenting, isLoggedIn: .constant(true))
                            case 3:
                                CalendarView()
                            case 4:
                                AnalyticsView()
                            default:
                                HomeView(isPresenting: $isPresenting, isLoggedIn: .constant(true))
                        }
                    }
                }
                VStack(spacing: 0.0) {
                    Spacer()
                    Divider()
                    HStack(alignment: .center, spacing: 0.0) {
                        ForEach(0..<5, id: \.self) { number in
                            Spacer()
                            Button(action: {
                                if number == 2 {
                                    self.showSheet = true
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
                            .buttonStyle(PlainButtonStyle())
                                .sheet(isPresented: (self.$showSheet)) {
                                AddView(showSheet: self.$showSheet)
                                }

                            Spacer()
                        }
                    }.frame(height: ConstModel().deviceHeight * 0.07).background(.white)

                }
            }
        }
        }
    }
    
}
    

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            MainView().previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
        }
    }
    
}
