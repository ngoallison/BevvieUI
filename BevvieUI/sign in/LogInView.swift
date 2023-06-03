//
//  LoginView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/18/22.
//
//  log in view if the user already has an account

import SwiftUI
import Firebase
struct LogInView: View {
    
    // allow to switch between sign up and log in views
    @Binding var isSignedUp: Bool
    @Binding var isLoggedIn: Bool
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoading = false
    @State var showError = false
    
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var anaModel: AnalyticsModel
    @EnvironmentObject var bevModel: BevModel
    
    @State var errorText: String = ""
    
    func clearFields() {
        self.email = ""
        self.password = ""
    }
    
    func findError() {
        self.isLoading = false
        self.showError = true
    }
    
    func checkInfo() {
        
        if (email == "") || (password == "") {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                clearFields()
                findError()
                self.errorText = "Username or password is incorrect."
                return
            }
            else {
                self.isLoading = false
                self.showError = false
                self.isLoggedIn.toggle()
                
                userModel.getUser()
                anaModel.getAnalytics()
                bevModel.getBev()
                return
            }
        }
    }
    
    var body: some View {
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
                    HStack {
                        Text("Log In").font(Font.custom("Kiona", size: 30))
                        Spacer()
                    }.frame(width: ConstModel().width-100)
                }.frame(height: ConstModel().height*0.5)
                Spacer()
                
                // log in text fields
                VStack (spacing: 0){
                    VStack(spacing: 10) {
                        
                        // email field
                        VStack(alignment: .leading, spacing: 3) {
                            CustomTextfield(placeholder: Text("Email"), icon: "envelope", username: $email)
                            Text("forgot email?").font(Font.custom(ConstModel().textFont, size: 14)).padding(.leading)
                        }
                        
                        // password field
                        VStack(alignment: .leading, spacing: 3) {
                            CustomSecurefield(placeholder: Text("Password"), icon: "exclamationmark.lock", password: $password)
                            Text("forgot password?").font(Font.custom(ConstModel().textFont, size: 14)).padding(.leading)
                        }
                        //                        if showError {
                        //                            VStack (spacing: 0) {
                        //                                Text("Username or password is incorrect.").font(Font.custom("Cardium A Regular", size: 12)).foregroundColor(Color.red)
                        //                                    .lineLimit(2)
                        //                                Text("Please try again.").font(Font.custom("Cardium A Regular", size: 12)).foregroundColor(Color.red)
                        //                                    .lineLimit(2)
                        //                            }
                        //                        }
                    }.frame(width: ConstModel().width-100, height: ConstModel().height*0.20)
                    
                    // log in button
                    VStack (spacing: 30){
                        Button(action: {
                            showError = false
                            isLoading = true
                            checkInfo()
                        }) {
                            if isLoading {
                                ProgressView()
                                    .foregroundColor(.white)
                            } else {
                                Text("Log In")
                                //.padding()
                                    .frame(width: 150, height: 40)
                                    .background(ColorModel().mediumGreen)
                                    .foregroundColor(.white)
                                    .cornerRadius(18.0)
                                    .font(Font.custom("Young", size: 17))
                            }
                        }
                        .disabled(isLoading)
                        
                        // button to toggle sign up and log in
                        HStack {
                            Text("Dont' have an account?")
                                .font(Font.custom(ConstModel().textFont, size: 13))
                            
                            Button(action: {
                                self.isSignedUp.toggle()
                                print(isSignedUp)
                            }, label: {
                                Text("Sign up here!")
                                    .font(Font.custom(ConstModel().textFont, size: 13))
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                            })
                        }
                    }.frame(width: ConstModel().width-100, height: ConstModel().height*0.15)
                }
            }
            ErrorView(showError: $showError, errorText: errorText)
        }
    }
    
}


struct LogInView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            LogInView(isSignedUp: .constant(false), isLoggedIn: .constant(false)).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
        }
    }
}

