//
//  EditModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/9/23.
//
//  settings view pop up modal that appears when user saves changes to their profile

import SwiftUI

struct EditModal: View {
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            
            // PopUp Window
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 300, height: 175)
                        .cornerRadius2(25, corners: .allCorners)
                    VStack {
                        Spacer()
                        Text("Your profile has successfully been changed! :)")
                            .font(Font.custom("Young", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(ColorModel().darkGreen)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                        
                        // stack containing button
                        ZStack {
                            Button(action: {
                                self.show = false
                            }, label: {
                                ZStack {
                                    Rectangle()
                                        .fill(ColorModel().mediumGreen)
                                        .frame(width: 300, height: 50)
                                        .cornerRadius2(25, corners: [.bottomRight, .bottomLeft])
                                    Text("CLOSE")
                                        .font(Font.custom("Kiona", size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                }
                            })
                        }
                    }
                }
            }.frame(width: 300, height: 175)
            
        }
    }
}

struct EditModal_Previews: PreviewProvider {
    static var previews: some View {
        EditModal(show: .constant(true))
    }
}
