//
//  ErrorView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 6/3/23.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var showError: Bool
    @Binding var errorText: String
    
    var body: some View {
        ZStack {
            if showError {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                // PopUp Window
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 300, height: 175)
                            .cornerRadius2(25, corners: .allCorners)
                        
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(ColorModel().lightGreen)
                                    .frame(height: 40)
                                    .cornerRadius2(25, corners: [.topLeft, .topRight])
                                Text("ERROR")
                                    .font(Font.custom("Young", size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            Text(errorText)
                                .font(Font.custom("Young", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(ColorModel().darkGreen)
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                            
                            // stack containing button
                            ZStack {
                                Button(action: {
                                    self.showError = false
                                }, label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(ColorModel().mediumGreen)
                                            .frame(width: 300, height: 40)
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
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(showError: .constant(false), errorText: .constant("Something went wrong :("))
    }
}
