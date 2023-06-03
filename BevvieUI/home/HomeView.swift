//
//  HomeView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//
//  home view as user dashboard

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct HomeView: View {
    
    // add modal
    @Binding var addPresent: Bool
    
    @Binding var settingsPresent: Bool
    
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var anaModel: AnalyticsModel
    
    var body: some View {
        ZStack(alignment: .center)  {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack (alignment: .center) {
                    VStack {
                        Spacer()
                        Rectangle().fill(ColorModel().lightTan)
                            .edgesIgnoringSafeArea(.all).frame(height: ConstModel().height * (0.65))
                    }.frame(maxHeight: .infinity)
                    VStack(spacing: 0.0) {
                        Spacer()
                        VStack(spacing: 25.0) {
                            VStack(spacing: 10.0) {
                                Text("BEVVIE").font(Font.custom("Kiona", size: 40)).fontWeight(.regular).foregroundColor(.white)
                                    .tracking(5)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                    .padding(.bottom)
                                
                                
                                ZStack {
                                    
                                    // profile card
                                    Rectangle().fill(Color(.white)).frame(width: 300, height: 210).cornerRadius(20)    .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                                    
                                    // stack containing user icon, username, and title
                                    VStack(alignment: .center, spacing: 15.0) {
                                        ZStack(alignment: .bottom) {
                                            ColorModel().brown.opacity(0.5).frame(width: 110, height: 110).clipShape(Circle())
                                            Image(userModel.user.icon!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                            
                                                .clipShape(Circle())
                                        }
                                        VStack(spacing: 0) {
                                            Text(userModel.user.username!
                                            ).tracking(2).fontWeight(.medium).foregroundColor(ColorModel().brown).font(Font.custom("Young", size: 23))
                                            
                                            Text(userModel.user.title!).foregroundColor(ColorModel().brown).font(Font.custom("Cardium A Regular", size: 17))
                                        }.onAppear()
                                    }
                                }
                            }
                            
                            // logging a new bevvie
                            HStack(spacing: 5.0) {
                                Text("Haven’t had a bevvie today? Treat yourself!").fontWeight(.medium).foregroundColor(Color(red:0.66, green:0.49, blue:0.39)).font(Font.custom("Cardium A Regular", size: 17)).lineLimit(15)
                                Spacer()
                                Image("matcha-tea").resizable().frame(width: 120, height: 120)
                            }
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation(.spring()) {
                                        addPresent = true
                                    }
                                }
                            }, label: {
                                Text("Log your Bevvie")
                                    .fontWeight(.medium)
                                    .padding(.all)
                                    .frame(maxWidth: ConstModel().width, maxHeight: 50)
                                    .background(ColorModel().mediumGreen)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .font(Font.custom("AltoneTrial-Regular", size: 20))
                            })
                            
                            // displays user level as progress bar
                            VStack {
                                HStack {
                                    Text("level \(anaModel.analytics.level!)").font(Font.custom("Cardium A Regular", size: 25)).foregroundColor(ColorModel().brown)
                                    Spacer()
                                    Text("\((10 - (anaModel.analytics.exp! % 10))) more bevvies to level up!").font(Font.custom("Cardium A Regular", size: 15)).foregroundColor(ColorModel().brown)
                                }
                                
                                ProgressView(value: CGFloat((anaModel.analytics.exp! % 10))/10).tint(ColorModel().mediumGreen)
                            }.padding(.vertical, 20)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        
                    }.frame(maxWidth: ConstModel().width - 60, maxHeight: .infinity)
                }
            }
            
            // settings button
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        settingsPresent = true
                    }, label: { Image(systemName: "gearshape.fill").font(.title2).foregroundColor(.white)
                    })
                    .padding(.leading)
                    
                    Spacer()
                }
                Spacer()
            }.frame(width: ConstModel().width)
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(addPresent: .constant(false), settingsPresent: .constant(false)).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait).environmentObject(UserModel())
            .environmentObject(AnalyticsModel())
    }
}
