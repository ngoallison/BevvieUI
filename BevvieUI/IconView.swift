//
//  TestView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.

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

    func createUser() {
        let selectedIcon = icons[selectedIndex]
        print(username)
        print(email)
        print(selectedIcon)
        NewUserViewModel.createNewUser(username: username, email: email, user_icon: selectedIcon)
        userModel.getUser()
        isSignedUp = true
        isLoggedIn = true
    }
    
    var body: some View {
        ZStack(alignment: .center)  {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            VStack {
                Text("SELECT AN ICON").font(Font.custom("Kiona", size: 30)).fontWeight(.bold).foregroundColor(ColorModel().orangeBrown)
                    .tracking(3)
                    .frame(maxWidth: .infinity)
                

                VStack {

                    HStack {
                        Button(action: {
                            self.selectedIndex = 0
                            //self.buttonsTapped[0].toggle()
                            print("girl pressed")
                          }) {
                              ZStack(alignment: .bottom) {
                              ColorModel().brown.opacity(0.5).frame(width: 110, height: 110).clipShape(Circle())
                              Image("girl-icon")
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: 110, height: 110)
                                  .clipShape(Circle())
                                  .overlay(Circle().stroke(ColorModel().mediumGreen, lineWidth: selectedIndex == 0 ? 7 : 0))

                              }
                          }
                        Spacer()
                        Button(action: {
                            self.selectedIndex = 1

                            //self.buttonsTapped[1].toggle()

                            print("boy pressed")
                          }) {
                              ZStack(alignment: .bottom) {
                              ColorModel().brown.opacity(0.5).frame(width: 110, height: 110).clipShape(Circle())
                              Image("boy-icon")
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: 110, height: 110)

                                  .clipShape(Circle())
                                  .overlay(Circle().stroke(ColorModel().mediumGreen, lineWidth: selectedIndex == 1 ? 7 : 0))
                              }
                          }

                        }.frame(width: ConstModel().width * 0.7)
                            .padding(10)


                    HStack {
                        Button(action: {
                            self.selectedIndex = 2

                            //self.buttonsTapped[2].toggle()
                            print("old lady pressed")
                          }) {
                              ZStack(alignment: .bottom) {
                              ColorModel().brown.opacity(0.5).frame(width: 110, height: 110).clipShape(Circle())
                              Image("old-lady-icon")
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: 110, height: 110)

                                  .clipShape(Circle())
                                  .overlay(Circle().stroke(ColorModel().mediumGreen, lineWidth: selectedIndex == 2 ? 7 : 0))
                              }
                          }

                        Spacer()
                        Button(action: {
                            self.selectedIndex = 3
                            //self.buttonsTapped[3].toggle()
                            print("old man pressed")
                          }) {
                              ZStack(alignment: .bottom) {
                              ColorModel().brown.opacity(0.5).frame(width: 110, height: 110).clipShape(Circle())
                              Image("old-man-icon")
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: 110, height: 110)

                                  .clipShape(Circle())
                                  .overlay(Circle().stroke(ColorModel().mediumGreen, lineWidth: selectedIndex == 3 ? 7 : 0))
                              }
                          }

                    }.frame(width: ConstModel().width * 0.7)
                        .padding(10)

                }.frame(height: ConstModel().height * 0.5)
                
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
//        IconView(isSignedUp: .constant(false), isLoggedIn: .constant(false), chooseIcon: .constant(false), username: .constant(""), email: .constant(""))
    }
}
