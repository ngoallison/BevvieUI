//
//  AddView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddView: View {
    
    let db = Firestore.firestore()
    
    @Binding var showSheet: Bool

    var faces = ["cheery-face", "happy-face", "meh-face", "sad-face"]
    var temp = ["ICED", "HOT"]

    @State var name = ""
    @State var location = ""
    @State var type = ""
    @State var size = ""
    @State var selectedIndex = 1
    @State var selectedTemp = 0

    @State var price: Double = 0
    
    @State private var bevDate = Date()

    
    func addDB() {
        
        // adds item to bevs document
        if name != "" {
            
            print(name)

            //let user = "slay"
            let user = Auth.auth().currentUser
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let result = formatter.string(from: bevDate)

            
            db.collection("bevs").addDocument(data: ["name": name, "location": location, "type": type, "size": size, "price": price, "temp": temp[selectedTemp], "date": result, "satisfaction": faces[selectedIndex], "uid": user!.uid])
            { (error) in
                if error != nil {
                    print("there was an error!")
                } else {
                    print("success!")
                    self.showSheet.toggle()
                    updateUser()
                }
            }
            
        }
    }
    
    func updateUser() {
        print("in update function")
        db.collection("user").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (snapshot, error) in
            
            if error != nil {
                        print("there was an error!")
                        // Some error occured
                    } else if snapshot!.documents.count != 1 {
                        // Perhaps this is an error for you?
                    } else {
                        let document = snapshot!.documents.first
                        
                        let new_numbevs = document!.data()["numbevs"] as! Int + 1
                        let new_exp = document!.data()["experience"] as! Int + 1
                        
                        if (new_exp % 10 == 0) {
                            let new_level = document!.data()["level"] as! Int + 1
                            document!.reference.updateData([
                                "level": new_level
                            ])
                        }
                        
                        document!.reference.updateData([
                            "numbevs": new_numbevs,
                            "experience": new_exp,
                        ])
                        return
                    }
//        guard let documents = snapshot?.documents else {
//                print("No Documents")
//                return
//            }
//
//            let document = documents[0]
//            let new_numbevs = document.data()["numbevs"] as! Int + 1
//            let new_exp = document.data()["experience"] as! Int + 10
//
//            print(new_numbevs)
//
//            documents.update({
//                "numbevs": new_numbevs,
//                "experience": new_exp
//
//            })

        }
        //self.showSheet.toggle()
    }
    
    var body: some View {
        ZStack {
            Color(red:0.95, green:0.91, blue:0.89).ignoresSafeArea(.all)
            VStack(spacing: 0.0) {
                ZStack {
//                    Rectangle()
//                    .fill(Color(red:0.76, green:0.79, blue:0.74))
//                    .frame(height: 80)
                    Text("ADD A BEVVIE")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .font(Font.custom("Kiona", size: 27))
                        .padding(.all)
                        .frame(width: ConstModel().deviceWidth, height: ConstModel().deviceWidth * 0.15, alignment: .bottom)
                        .background(ColorModel().lightGreen)
                }
                ZStack {
                    Rectangle().fill(Color(red:0.99, green:0.99, blue:0.99))
                    VStack(alignment: .leading, spacing: ConstModel().deviceWidth * 0.07) {
                        Group {
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text("NAME")
                                .fontWeight(.heavy)
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("Kiona", size: 20))
                            CustomTextfield(placeholder: Text("Wintermelon Milk Tea..."), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $name)
                            }
                            VStack(alignment: .leading, spacing: 5.0) {
                                Text("LOCATION")
                                    .fontWeight(.heavy)
                                    .foregroundColor(ColorModel().darkGreen)
                                    .font(Font.custom("Kiona", size: 20))
                                CustomTextfield(placeholder: Text("OMOMO..."), fontName: "Kiona", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $location)
                            }
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
                                //Spacer()
                                Button(action: {
                                    self.selectedTemp = number
                                    print(temp[number])
                                }, label: {
                                    Text(temp[number])
                                        .fontWeight(.medium)
                                        .padding(.all, 30.0)
                                        .frame(height: 40)
                                        .background(selectedTemp == number ? ColorModel().mediumGreen : ColorModel().mediumGreen.opacity(0.5))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .font(Font.custom("Young", size: 17))
                                })
                                //Spacer()
                            }
                        }
                        .padding(.vertical, 5.0)
                        Group {
                            HStack(spacing: 20.0) {
                                VStack(alignment: .leading, spacing: 5.0) {
                                Text("TYPE")
                                .fontWeight(.heavy)
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("Kiona", size: 20))
                                CustomTextfield(placeholder: Text("Boba..."), fontName: "CaviarDreams", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $type)
                            }
                                VStack(alignment: .leading, spacing: 5.0) {
                                Text("SIZE")
                                    .fontWeight(.heavy)
                                    .foregroundColor(ColorModel().darkGreen)
                                    .font(Font.custom("Kiona", size: 20))
                                CustomTextfield(placeholder: Text("Regular..."), fontName: "CaviarDreams", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $size)
                            }
                        }
                        HStack(spacing: 5.0) {
                            Text("DATE")
                                .fontWeight(.heavy)
                                .foregroundColor(ColorModel().darkGreen)
                                .font(Font.custom("Kiona", size: 20))
                            Spacer()
                            DatePicker("", selection: $bevDate, displayedComponents: .date)
                                .accentColor(ColorModel().mediumGreen)
                                .datePickerStyle(CompactDatePickerStyle())
//                            CustomTextfield(placeholder: Text("September 20, 2022..."), fontName: "CaviarDreams", fontSize: 15, fontColor: Color.gray, backgroundColor: Color(red:0.80, green:0.60, blue:0.49), opacity: 0.3, username: $type)
                            }
                        }
                        
                        HStack {
                            ForEach(0..<4, id: \.self) { number in
                                Spacer()
                                Button(action: {
                                    self.selectedIndex = number
                                }) {
                                    Image(faces[number]).resizable()
                                        .frame(width: 50, height: 50)
                                        .opacity(selectedIndex == number ? 1.0 : 0.3)
                                    //.foregroundColor(selectedIndex == number ? .black.opacity(0.9) : Color(UIColor.lightGray))
                                    
                                }
                                Spacer()
                            }
                                
                        }
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing], 20.0)
                }
                HStack(spacing: 0.0)  {
                    Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        Text("BACK")
                            .fontWeight(.bold)
                            .padding(.top)
                            .frame(width: ConstModel().deviceWidth/2, height: ConstModel().deviceHeight * 0.05)
                            .background(ColorModel().mediumGreen)
                            .foregroundColor(.white)
                            .font(Font.custom("Young", size: 20))
                    })
                    Button(action: {
                        addDB()
                    }, label: {
                        Text("ADD")
                            .fontWeight(.bold)
                            .padding(.top)
                            .frame(width: ConstModel().deviceWidth/2, height: ConstModel().deviceHeight * 0.05)
                            .background(ColorModel().lightGreen)
                            .foregroundColor(.white)
                            .font(Font.custom("Young", size: 21))
                    })
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
//red:0.99, green:0.99, blue:0.99

struct AddView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            AddView(showSheet: .constant(false)).previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
        }
    }
}
