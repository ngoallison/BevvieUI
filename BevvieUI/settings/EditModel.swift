//
//  EditModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/9/23.
//

import SwiftUI

struct EditModel: View {
    
    @Binding var show: Bool
    @Binding var editPresent: Bool
    
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
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
                            ZStack {
                                Button(action: {
                                    self.show = false
                                    editPresent = false
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
//                                Rectangle()
//                                    .fill(ColorModel().mediumGreen)
//                                    .frame(width: 300, height: 50)
//                                    .cornerRadius2(25, corners: [.bottomRight, .bottomLeft])
//                                Text("CLOSE")
//                                    .font(Font.custom("Kiona", size: 20))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color.white)
//                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }.frame(width: 300, height: 175)
                
            }
        }
    }
}

struct EditModel_Previews: PreviewProvider {
    static var previews: some View {
        EditModel(show: .constant(true), editPresent: .constant(false))
    }
}
