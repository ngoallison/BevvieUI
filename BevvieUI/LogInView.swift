//
//  ContentView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/18/22.
//

import SwiftUI
import Firebase
struct LogInView: View {
    
    @Binding var isSignedUp: Bool
    @Binding var isLoggedIn: Bool
    @State var isPresenting = false /// 1.
    @State var email: String = ""
    @State var password: String = ""
    @State var isModal: Bool = false
    
    @State var isLoading = false
    @State var forgotPass = ""
    @State var forgotUser = ""
    
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var anaModel: AnalyticsModel
    @EnvironmentObject var bevModel: BevModel

    
    func goToSignUp() {
        isSignedUp = false
    }
    
    func checkInfo() {
        
        if (email == "") || (password == "") {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            }
            else {
                print("logged in, now fetching info")
                isSignedUp = true
                isLoggedIn = true
                userModel.getUser()
                anaModel.getAnalytics()
                bevModel.getBev()
            }
        }
    }
    
    var body: some View {
        if isPresenting {
            MainView()
        }
        else {
            ZStack {
                ColorModel().lightTan.edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 0.0) {
                    VStack (spacing: 30){
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
                    VStack (spacing: 0){
                        
                        VStack(spacing: 10) {
                            VStack(alignment: .leading) {
                                CustomTextfield(placeholder: Text("Email"), icon: "envelope", username: $email)
                                Text("forgot email?").font(Font.custom(ConstModel().textFont, size: 14)).padding(.leading)
                            }
                            
                            VStack(alignment: .leading) {
                                CustomSecurefield(placeholder: Text("Password"), icon: "exclamationmark.lock", password: $password)
                                Text("forgot password?").font(Font.custom(ConstModel().textFont, size: 14)).padding(.leading)
                            }
                        }.frame(width: ConstModel().width-100, height: ConstModel().height*0.20)
                        VStack (spacing: 30){
                            Button(action: {
                                isLoading = true
                                checkInfo()
                            }) {
                                if isLoading {
                                    ProgressView()
                                        .foregroundColor(.white)
                                } else {
                                    Text("Log In")
                                        .padding(.all)
                                        .frame(width: 150, height: 40)
                                        .background(ColorModel().mediumGreen)
                                        .foregroundColor(.white)
                                        .cornerRadius(18.0)
                                        .font(Font.custom("Young", size: 17))
                                }
                            }
                            .disabled(isLoading)
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

}


struct LogInView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            LogInView(isSignedUp: .constant(false), isLoggedIn: .constant(false)).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
        }
    }
}

