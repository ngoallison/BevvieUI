//
//  PrivacyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//
//  settings view that allows user to change details about their profile

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditView: View {
    
    @Binding var editPresent: Bool
    
    @State var username: String = ""
    @State var title: String = ""
    @State var isLoading: Bool = false
    @State var show: Bool = false
    @State private var selectedIndex: Int = -1
    
    let icons: [String] = ["girl-icon", "boy-icon", "old-lady-icon", "old-man-icon", "cat", "pet"]
    
    let db = Firestore.firestore()
    
    // updates firebase with new changes
    func updateProfile() {
        
        db.collection("user").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (snapshot, error) in
            
            if error != nil {
                print("there was an error!")
                // Some error occured
            } else {
                let document = snapshot!.documents.first
                
                // only update if non-empty
                if (username != "") {
                    document!.reference.updateData([
                        "username": username
                    ])
                    username = ""
                }
                
                if (title != "") {
                    document!.reference.updateData([
                        "title": title.lowercased(),
                    ])
                    title = ""
                }
                
                if (selectedIndex != -1) {
                    document!.reference.updateData([
                        "icon": icons[selectedIndex]
                    ])
                    selectedIndex = -1
                }
                return
            }
            
        }
    }
    
    var body: some View {
        ZStack {
            ColorModel().lightTan.edgesIgnoringSafeArea(.all)
            ZStack {
                VStack (alignment: .center, spacing: 20) {
                    HStack {
                        Button(action: {
                            editPresent = false
                        }, label: {
                            Image(systemName: "arrow.left").font(.title).foregroundColor(.black)
                        })
                        Spacer()
                    }
                    .padding(.leading)
                    Text("Edit Profile")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .foregroundColor(ColorModel().darkGray)
                        .font(Font.custom("Young", size: 27))
                        .frame(width: ConstModel().width-50, alignment: .leading)
                    
                    // stack to change username and title
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Change Username").font(Font.custom("Cardium A Regular", size: 14))
                            CustomTextfield(placeholder: Text("Jayson Marie Catsby"), username: $username)
                        }.padding(.bottom)
                        
                        Text("Change Title").font(Font.custom("Cardium A Regular", size: 14))
                        CustomTextfield(placeholder: Text("coffee connoisseur"), username: $title)
                    }.frame(width: ConstModel().width - 50)
                    
                    HStack {
                        Text("Change Icon").font(Font.custom("Cardium A Regular", size: 15))
                        Spacer()
                    }.frame(width:ConstModel().width - 50)
                    
                    // stack displaying different icons
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: (ConstModel().width)/4))
                    ]) {
                        ForEach(icons.indices, id: \.self) { index in
                            Button(action: {
                                self.selectedIndex = index
                            }, label: {
                                ZStack(alignment: .bottom) {
                                    ColorModel().brown.opacity(0.5).frame(width: 80, height: 80).clipShape(Circle())
                                    Image(icons[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(ColorModel().mediumGreen, lineWidth: selectedIndex == index ? 7 : 0))
                                }
                            })
                        }
                    }
                    Spacer()
                    
                    // save changes button, shows confirmation modal
                    Button(action: {
                        isLoading = true
                        updateProfile()
                        isLoading = false
                        show = true
                    }) {
                        if isLoading {
                            ProgressView()
                                .foregroundColor(.white)
                        } else {
                            Text("Save Changes")
                                .padding(.all)
                                .frame(width: 200, height: 40)
                                .background(ColorModel().mediumGreen)
                                .foregroundColor(.white)
                                .cornerRadius(18.0)
                                .font(Font.custom("Cardium A Regular", size: 17))
                        }
                    }.padding()
                        .disabled(isLoading)
                    
                    Spacer()
                }
                
                if show {
                    ZStack {
                        Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                        EditModal(show: $show)
                    }
                }
            }
        }
    }
}

struct EditView_Preview: PreviewProvider {
    static var previews: some View {
        EditView(editPresent: .constant(true))
    }
}
