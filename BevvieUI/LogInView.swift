//
//  ContentView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/18/22.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    
    @Binding var isSignedUp: Bool
    @Binding var isLoggedIn: Bool 
    @State var isPresenting = false /// 1.
    @State var email: String = ""
    @State var password: String = ""
    @State var isModal: Bool = false
    
    @State var forgotPass = ""
    @State var forgotUser = ""

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
                isSignedUp = true
                isLoggedIn = true
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
                ZStack {
                    Image("cup-coffee")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ConstModel().deviceWidth, height: 375, alignment: .center)
                        .opacity(0.7)
                    Text("BEVVIE").font(Font.custom("Kiona", size: 40)).fontWeight(.regular).foregroundColor(.white)
                        .tracking(5)
                        .multilineTextAlignment(.trailing).padding([.bottom, .trailing], 40.0)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                }
                VStack(alignment: .center, spacing: 5
                ) {
                    VStack(alignment: .leading, spacing: 15) {
                    Text("Log In").font(Font.custom("Kiona", size: 30))
                        VStack(spacing: 30.0) {
                        VStack(spacing: 25.0) {
                        VStack(alignment: .leading, spacing: 0.0) {
                            Text(forgotUser).foregroundColor(.red).font(Font.custom("Kiona", size: 14)).padding(.leading)
                            VStack(alignment: .leading) {
                            

                           CustomTextfield(placeholder: Text("Email"), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $email)
                            Text("forgot email?").font(Font.custom("Cardium A Regular", size: 14)).padding(.leading)
                        }
                        }
                        
                        VStack(alignment: .leading) {
                            CustomSecurefield(placeholder: Text("Password"), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, password: $password)
                                
                                Text("forgot password?").font(Font.custom("Cardium A Regular", size: 14)).padding(.leading)
                        }
                        
                    
                }
 
                Button("Log In") {
                    checkInfo()
                }.padding(.all)
                    .frame(width: 150, height: 40)
                    .background(ColorModel().mediumGreen)
                    .foregroundColor(.white)
                    .cornerRadius(18.0)
                    .font(Font.custom("CaviarDreams", size: 17))
                
                //NavigationLink(destination: HomeView(), isActive: $isPresenting) { FirstView() }
                


                
                
                HStack {
                    Text("Don't have an account?")
                    .font(Font.custom("Cardium A Regular", size: 13))
                    
                    Button(action: {
                        goToSignUp()
                    }, label: {
                        Text("Sign up here!")
                            .font(Font.custom("Cardium A Regular", size: 13))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        })
                    }
                    }
                }
                .frame(width: ConstModel().deviceWidth - 100, height: 475.0)
            
            }
        }
        }
        
    }
    
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            LogInView(isSignedUp: .constant(false), isLoggedIn: .constant(false)).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
        }
        }
    }
}
