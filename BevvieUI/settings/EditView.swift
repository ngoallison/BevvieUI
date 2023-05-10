//
//  PrivacyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

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
                        }
                        )
                        Spacer()
                    }
                    .padding(.leading)
                    Text("Edit Profile")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .foregroundColor(ColorModel().darkGray)
                        .font(Font.custom("Young", size: 27))
                        .frame(width: ConstModel().deviceWidth-50, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("Change Username").font(Font.custom("Cardium A Regular", size: 14))
                            CustomTextfield(placeholder: Text("Jayson Marie Catsby"), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $username)
                        }.padding(.bottom)
                        
                        Text("Change Title").font(Font.custom("Cardium A Regular", size: 14))
                        CustomTextfield(placeholder: Text("coffee connoisseur"), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $title)
                    }.frame(width: ConstModel().deviceWidth - 50)
                        
                    HStack {
                        Text("Change Icon").font(Font.custom("Cardium A Regular", size: 15))
                        Spacer()
                    }.frame(width:ConstModel().deviceWidth - 50)
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: (ConstModel().deviceWidth)/4))
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
                    Text("BEVVIE @ 2022").font(Font.custom("Kiona", size: 20)).foregroundColor(ColorModel().darkGray)
                }
                EditModel(show: $show, editPresent: $editPresent)
                
            }
            
          
        }
    }
}

struct EditView_Preview: PreviewProvider {
    static var previews: some View {
        EditView(editPresent: .constant(true))
    }
}
