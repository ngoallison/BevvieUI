//
//  ContentView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/18/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct SignUpView: View {
    
    @Binding var isSignedUp: Bool
    @Binding var isLoggedIn: Bool
    @State var choosingIcon: Bool
    
    @State private var isLoading = false
    
    @State var isPresenting = false /// 1.
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isModal: Bool = false
    
    @State var forgotPass = ""
    @State var forgotUser = ""

    let db = Firestore.firestore()
    
    func addDB() {
        if username != "" && email != "" {
            db.collection("user").addDocument(data: ["username": username, "email": email])
            { (error) in
                if error != nil {
                    print("there was an error!")
                } else {
                    print("success!")
                }
            }
        }
    }

    func goToLogin() {
        print("hey!")
        isSignedUp = true
    }
    
    func checkInfo() {
        
        if (email == "") || (password == "") {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            }
            else {
                print("checking info...")
                choosingIcon = true
                //isSignedUp = true
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
                VStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Sign Up").font(Font.custom("Kiona", size: 30))
                        VStack(spacing: 30.0) {
                            VStack(spacing: 5) {
                                VStack(alignment: .leading, spacing: 5.0) {
                                    Text(forgotUser).foregroundColor(.red).font(Font.custom("CaviarDreams", size: 14)).padding(.leading)
                                    VStack(alignment: .leading, spacing: 10) {
                                    
                                        CustomTextfield(placeholder: Text("Email Address"), fontName: "Kiona", fontSize: 17, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, icon: "envelope", username: $email)

                                        
                                        CustomTextfield(placeholder: Text("Username"), fontName: "Kiona", fontSize: 17, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, icon: "person", username: $username)
                                        
                                        CustomSecurefield(placeholder: Text("Password"), fontName: "Kiona", fontSize: 17, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, icon: "lock", password: $password)
                                        
                                    }
                                }
                        
                            }
                            
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
                                                .font(Font.custom("Cardium A Regular", size: 17))
                                        }
                                    }
                                    .disabled(isLoading)

                            HStack {
                                Text("Already have an account?")
                                .font(Font.custom("Cardium A Regular", size: 13))
                                
                                Button(action: {
                                    goToLogin()
                                }, label: {
                                    Text("Log in here!")
                                        .font(Font.custom("Cardium A Regular", size: 13))
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                })
                        }
                    }.frame(width: ConstModel().deviceWidth - 100, height: 300)
                }.frame(width: ConstModel().deviceWidth - 100, height: 475)
                    
            
            }
        
        }
        
        }
    }
    
}


struct SignUpView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
//            SignUpView(isSignedUp: .constant(false), isLoggedIn: .constant(false) , chooseIcon: .constant(false)).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
        }
        }
    }
}
