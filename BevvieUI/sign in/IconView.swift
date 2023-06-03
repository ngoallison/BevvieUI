//
//  TestView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//
//  icon view that appears after sign up view for the user to select an icon

import SwiftUI

struct IconView: View {
    
    @Binding var isSignedUp: Bool
    @Binding var isLoggedIn: Bool
    
    @Binding var username: String
    @Binding var email: String
    
    var icons = ["girl-icon", "boy-icon", "old-lady-icon", "old-man-icon"]
    @State var buttonsTapped = [false, false, false, false]
    @State private var selectedIndex = -1
    
    @EnvironmentObject var userModel: UserModel
    
    
    var iconGroups: [[String]] = []
    var nameGroups: [[String]] = []
    
    // create new user and toggle signup and logged in
    func createUser() {
        let selectedIcon = icons[selectedIndex]
        NewUserViewModel.createNewUser(username: username, email: email, user_icon: selectedIcon)
        userModel.getUser()
        isSignedUp = true
        isLoggedIn = true
    }
    
    var body: some View {
        ZStack(alignment: .center)  {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            VStack {
                Text("SELECT AN ICON").font(Font.custom("Kiona", size: 30)).fontWeight(.bold).foregroundColor(ColorModel().darkGreen)
                    .tracking(3)
                    .frame(maxWidth: .infinity)
                
                // grid to display all icons
                let columns = Array(repeating: GridItem(.flexible()), count: 2)
                LazyVGrid(columns: columns, spacing: 50) {
                    ForEach(icons.indices, id: \.self) { index in
                        Button(action: {
                            self.selectedIndex = index
                        }, label: {
                            ZStack(alignment: .bottom) {
                                ColorModel().brown.opacity(0.5).frame(width: 110, height: 110).clipShape(Circle())
                                Image(icons[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 110, height: 110)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(ColorModel().mediumGreen, lineWidth: selectedIndex == index ? 7 : 0))
                            }
                        })
                    }
                }.padding(.vertical, 50)
                
                // continue button, create new user upon click
                Button("CONTINUE") {
                    createUser()
                }.padding(.all)
                    .frame(width: ConstModel().width * 0.7, height: ConstModel().height * 0.07)
                    .background(ColorModel().mediumGreen)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .font(Font.custom("Cardium A Regular", size: 20))
            }
            
        }
    }
    
}


struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(isSignedUp: .constant(true), isLoggedIn: .constant(true), username: .constant(""), email: .constant(""))
    }
}
