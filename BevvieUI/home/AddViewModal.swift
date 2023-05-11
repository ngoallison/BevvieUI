//
//  AddViewModal.swift
//  BevvieUI
//
//  Created by Allison Ngo on 5/10/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddViewModal: View {
    
    let db = Firestore.firestore()
    
    @Binding var showSheet: Bool
    
    var temp = ["ICED", "HOT"]
    let options = ["Boba", "Coffee", "Tea", "Smoothie", "Other"]
    var faces = ["cheery-face", "happy-face", "meh-face", "sad-face"]
    
    @State var name = ""
    @State var location = ""
    @State var type = ""
    @State var size = ""
    @State var selectedIndex = 1
    @State var selectedTemp = 0
    @State private var selection = "Boba"
    
    @State var price: Double = 0
    
    @State private var bevDate = Date()
    @EnvironmentObject var bevModel: BevModel
    
    
    func updateBev() {
        
        // adds item to bevs document
        if name != "" {
            
            let user = Auth.auth().currentUser
            let formatter = DateFormatter()
            
            formatter.dateFormat = "MM/dd/yyyy"
            
            let result = formatter.string(from: bevDate)
            
            db.collection("bevs").addDocument(data: ["name": name, "location": location, "type": type, "size": size, "price": price, "temp": temp[selectedTemp], "date": result, "satisfaction": faces[selectedIndex], "uid": user!.uid])
            { (error) in
                if error != nil {
                    print("there was an error!")
                } else {
                    self.showSheet.toggle()
                    updateUser()
                    bevModel.getBev()
                }
            }
            
        }
    }
    
    func updateUser() {
        
        db.collection("analytics").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (snapshot, error) in
            
            if error != nil {
                print("there was an error!")
                // Some error occured
            } else if snapshot!.documents.count != 1 {
                // Perhaps this is an error for you?
            } else {
                let document = snapshot!.documents.first
                
                let new_numbevs = document!.data()["numbevs"] as! Int + 1
                let new_exp = document!.data()["exp"] as! Int + 1
                let new_money = document!.data()["money"] as! Double + price
                
                if (new_exp % 10 == 0) {
                    let new_level = document!.data()["level"] as! Int + 1
                    document!.reference.updateData([
                        "level": new_level
                    ])
                }
                
                document!.reference.updateData([
                    "numbevs": new_numbevs,
                    "exp": new_exp,
                    "money": new_money
                ])
                return
            }
            
        }
    }
    var body: some View {
        ZStack {
            if showSheet {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: ConstModel().width*0.9, height: ConstModel().height*0.7)
                            .cornerRadius2(25, corners: .allCorners)
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(ColorModel().mediumGreen)
                                    .frame(height: 50)
                                    .cornerRadius2(25, corners: [.topLeft, .topRight])
                                Text("ADD A BEVVIE")
                                    .font(Font.custom("Young", size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                            VStack (spacing: 15) {
                                Group {
                                    VStack(alignment: .leading, spacing: 8.0) {
                                        Text("NAME")
                                            .fontWeight(.heavy)
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 20))
                                        CustomTextfield(placeholder: Text("Wintermelon Milk Tea..."), username: $name)
                                    }
                                    VStack(alignment: .leading, spacing: 5.0) {
                                        Text("LOCATION")
                                            .fontWeight(.heavy)
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 20))
                                        CustomTextfield(placeholder: Text("OMOMO..."), username: $location)
                                    }
                                    HStack {
                                        Text("PRICE")
                                            .fontWeight(.heavy)
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 20))
                                        Spacer()
                                        Text("$\(price, specifier: "%.2f")")
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 17))
                                    }
                                    Slider(value: $price, in: 0...10)
                                        .accentColor(ColorModel().mediumGreen)
                                    HStack {
                                        ForEach(0..<2, id: \.self) { number in
                                            Button(action: {
                                                self.selectedTemp = number
                                            }, label: {
                                                ZStack {
                                                    Rectangle()
                                                        .fill(selectedTemp == number ? ColorModel().mediumGreen : ColorModel().mediumGreen.opacity(0.5))
                                                        .frame(height: 40)
                                                        .cornerRadius(10)
                                                    
                                                    Text(temp[number])
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.white)
                                                        .font(Font.custom("Young", size: 17))
                                                }
                                            })
                                        }
                                    }
                                    Group {
                                        HStack(spacing: 20.0) {
                                            VStack(alignment: .leading, spacing: 5.0) {
                                                Text("TYPE")
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 20))
                                                
                                                ZStack {
                                                    Rectangle()
                                                        .fill(ColorModel().darkTan)
                                                        .cornerRadius(15)
                                                        .frame(height: 40)
                                                    HStack {
                                                        Menu {
                                                            Picker(selection: $selection) {
                                                                ForEach(options, id: \.self) {
                                                                    Text($0)
                                                                        .font(Font.custom("Cardium A Regular", size: 17))
                                                                    
                                                                }
                                                            } label: {}
                                                        } label: {
                                                            Text("Boba...")
                                                                .font(Font.custom("Cardium A Regular", size: 17))
                                                                .padding(.leading, 5)
                                                                .foregroundColor(ColorModel().darkGreen)
                                                                .opacity(0.5)
                                                        }
                                                        Spacer()
                                                    }.padding(.leading, 5)
                                                }
                                                
                                                //                                    CustomTextfield(placeholder: Text("Boba..."), username: $type)
                                            }
                                            VStack(alignment: .leading, spacing: 5.0) {
                                                Text("DATE")
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 20))
                                                ZStack {
                                                    Rectangle()
                                                        .fill(ColorModel().darkTan)
                                                        .cornerRadius(15)
                                                        .frame(height: 40)
                                                    HStack {
                                                        
                                                        DatePicker("", selection: $bevDate, displayedComponents: .date)
                                                            .fixedSize()
                                                            .clipped()
                                                            .labelsHidden()
                                                            .accentColor(ColorModel().mediumGreen)
                                                            .datePickerStyle(CompactDatePickerStyle())
                                                        Spacer()
                                                    }.padding(.leading, 5)
                                                }
                                                
                                                
                                            }
                                        }
                                    }
                                    HStack {
                                        ForEach(0..<4, id: \.self) { number in
                                            Button(action: {
                                                self.selectedIndex = number
                                            }) {
                                                Image(faces[number]).resizable()
                                                    .frame(width: 30, height: 30)
                                                    .opacity(selectedIndex == number ? 1.0 : 0.3)
                                                    .padding(.horizontal, 5)
                                            }
                                        }
                                        
                                    }.padding(.vertical, 10)
                                }
                                
                            }.padding(.horizontal, 20)
                            Spacer()
                            HStack(spacing: 0.0)  {
                                Button(action: {
                                    self.showSheet.toggle()
                                }, label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(ColorModel().mediumGreen)
                                            .frame(height: 50)
                                            .cornerRadius2(25, corners: [.bottomLeft])
                                        
                                        Text("BACK")
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .font(Font.custom("Young", size: 17))
                                    }
                                })
                                Button(action: {
                                    updateBev()
                                }, label: {
                                    ZStack {
                                        Rectangle()
                                            .fill(ColorModel().lightGreen)
                                            .frame(height: 50)
                                            .cornerRadius2(25, corners: [.bottomRight])
                                        
                                        Text("ADD")
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                            .font(Font.custom("Young", size: 17))
                                    }
                                })
                            }
                        }.frame(width: ConstModel().width*0.9, height: ConstModel().height*0.7)
                    }
                    
                    
                    
                }
                
                
            }
        }
    }
}

struct AddViewModal_Previews: PreviewProvider {
    static var previews: some View {
        AddViewModal(showSheet: .constant(true))
        
    }
}
