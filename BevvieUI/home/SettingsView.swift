//
//  SettingsView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/29/22.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var isPresenting: Bool
    @Binding var isSignedUp: Bool
    
    
    @State var editPresent: Bool = false
    @State var privacyPresent: Bool = false
    @State var termsPresent: Bool = false
    
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var anaModel: AnalyticsModel
    
    func logOut() {
        isPresenting = false
    }
  
    func privacy() {
        privacyPresent = true
    }
    
    func terms() {
        termsPresent = true
    }
    
    func edit() {
        editPresent = true
    }
    
    var body: some View {
        if privacyPresent {
            PrivacyView(privacyPresent: $privacyPresent)
        }
        else if termsPresent {
            TermsView(termsPresent: $termsPresent)
        }
        else if editPresent {
            EditView(editPresent: $editPresent, username: "", isLoading: false)
        }
        else {
        ZStack(alignment: .center)  {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack (alignment: .center) {
                    VStack {
                        HStack {
                            Button(action: {
                                isPresenting = false
                            }, label: {
                                Image(systemName: "arrow.left").font(.title).foregroundColor(.white)
                            }
                            )
                            Spacer()
                        }
                        .padding(.leading)
                          
                              
                      Spacer()
                        Rectangle().fill(.white)
                        .cornerRadius2(25, corners: [.topLeft, .topRight])
                        .edgesIgnoringSafeArea(.all).frame(height: ConstModel().height * (0.85))
                        .shadow(color: ColorModel().brown, radius: 5, x: 0, y: -5)

                              
                    }.frame(maxHeight: .infinity)
                    VStack {
                        Spacer()
                        VStack(spacing: 0.0) {
                            HStack(alignment: .center) {
                                ZStack(alignment: .bottom) {
                                    ColorModel().brown.opacity(0.5).frame(width: 120, height: 120).clipShape(Circle())
                                    Image(userModel.user.icon!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 110, height: 110)
                        
                                        .clipShape(Circle())
                                }
                                .padding(.trailing)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(userModel.user.username!).tracking(2).fontWeight(.medium).foregroundColor(ColorModel().brown).font(Font.custom("Young", size: 23))
                                    Text(userModel.user.title!).foregroundColor(ColorModel().brown).font(Font.custom("Cardium A Regular", size: 17))
                                
                                    Text("lvl. \(anaModel.analytics.level!)").foregroundColor(ColorModel().brown).font(Font.custom("Cardium A Regular", size: 15)).padding(.top)
                                ProgressView(value: CGFloat((anaModel.analytics.exp! % 10))/10).tint(ColorModel().mediumGreen)
                                }
                                Spacer()

                            }.padding([.leading, .bottom, .trailing], 20.0).frame(width: ConstModel().width, height: ConstModel().height * 0.17)
                            Divider()
                            VStack(spacing: 0.0) {
                                CustomSettingsButton(buttonName: "Edit Profile", buttonColor: .clear, clicked: edit)
                                CustomSettingsButton(buttonName: "Privacy Policy", buttonColor: ColorModel().darkGray.opacity(0.1), clicked: privacy)
                                CustomSettingsButton(buttonName: "Terms and Conditions", buttonColor: .clear, clicked: terms)
                                CustomSettingsButton(buttonName: "Theme", buttonColor: ColorModel().darkGray.opacity(0.1), clicked: logOut)
                                CustomSettingsButton(buttonName: "Log Out", buttonColor: .clear, clicked: logOut)
                                
                            }
                            Spacer()
                            Text("BEVVIE @ 2022").font(Font.custom("Kiona", size: 20)).foregroundColor(ColorModel().darkGray)
                            
                        }.padding(.vertical).frame(height: ConstModel().height * (0.85))
                    }
                }
            
            }
        }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isLoggedIn: .constant(true), isPresenting: .constant(false), isSignedUp: .constant(true))
            .environmentObject(UserModel())
            .environmentObject(AnalyticsModel())
        //SettingsView(isPresenting: .constant(true))
    }
}
