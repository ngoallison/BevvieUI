//
//  SignUpView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/18/22.
//
//  sign up view 

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct SignUpView: View {
    
    @Binding var isSignedUp: Bool
    @Binding var isLoggedIn: Bool
    
    // choosing icon page
    @State var choosingIcon: Bool
    @State private var isLoading = false
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    func checkInfo() {
        
        if (email == "") || (password == "") {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            }
            else {
                choosingIcon = true
            }
        }
    }
    
    var body: some View {
        if (choosingIcon) {
            IconView(isSignedUp: $isSignedUp, isLoggedIn: $isLoggedIn, username: $username, email: $email)
        }
        else {
            ZStack {
                ColorModel().lightTan.edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 0.0) {
                    VStack (spacing: 30){
                        
                        // header image
                        ZStack {
                            Image("cup-coffee")
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: ConstModel().width, height: 375, alignment: .center)
                                .opacity(0.7)
                            Text("BEVVIE").font(Font.custom("Kiona", size: 40)).fontWeight(.regular).foregroundColor(.white)
                                .tracking(5)
                                .multilineTextAlignment(.trailing).padding([.bottom, .trailing], 40.0)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        Spacer()
                        
                        // sign up header
                        HStack {
                            Text("Sign Up").font(Font.custom("Kiona", size: 30))
                            Spacer()
                        }.frame(width: ConstModel().width-100)
                    }.frame(height: ConstModel().height*0.5)
                    Spacer()
                    VStack (spacing: 0){
                        
                        // text fields for user sign up
                        VStack(spacing: 10) {
                            CustomTextfield(placeholder: Text("Email Address"), icon: "envelope", username: $email)
                            CustomTextfield(placeholder: Text("Username"), icon: "person", username: $username)
                            CustomSecurefield(placeholder: Text("Password"), icon: "exclamationmark.lock", password: $password)
                        }.frame(width: ConstModel().width-100, height: ConstModel().height*0.20)
                        
                        // sign up button
                        VStack (spacing: 30){
                            Button(action: {
                                isLoading = true
                                checkInfo()
                            }) {
                                if isLoading {
                                    ProgressView()
                                        .foregroundColor(.white)
                                } else {
                                    Text("Sign Up")
                                        .padding(.all)
                                        .frame(width: 150, height: 40)
                                        .background(ColorModel().mediumGreen)
                                        .foregroundColor(.white)
                                        .cornerRadius(18.0)
                                        .font(Font.custom("Young", size: 17))
                                }
                            }
                            .disabled(isLoading)
                            
                            // toggle to log in view
                            HStack {
                                Text("Already have an account?")
                                    .font(Font.custom(ConstModel().textFont, size: 13))
                                
                                Button(action: {
                                    self.isSignedUp.toggle()
                                }, label: {
                                    Text("Log in here!")
                                        .font(Font.custom(ConstModel().textFont, size: 13))
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                })
                            }
                        }.frame(width: ConstModel().width-100, height: ConstModel().height*0.15)
                    }
                }
                
            }
        }
        
    }
    
    
    struct SignUpView_Preview: PreviewProvider {
        static var previews: some View {
            ZStack {
                SignUpView(isSignedUp: .constant(false), isLoggedIn: .constant(false) , choosingIcon: false).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
            }
        }
    }
}
