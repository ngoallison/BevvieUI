//
//  AnalyticsView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import SwiftUI
import FirebaseFirestore

struct AnalyticsView: View {
    
    let db = Firestore.firestore()
    
    @State private var showAchievement = false
    @State private var theName = ""
    @State private var selectedStatus = 0
    
    @ObservedObject private var viewModel = UserViewModel()
    @ObservedObject private var analyticsModel = UserAnalyticsViewModel()

//    init() {
//        icons = ["hot-coffee", "heart", "ice-cubes", "boba", "skull", "money", "trash", "therapy", "seven", "stop"]
//        names = ["HOT CROSS BUNS", "LOVER BOY", "ICE ICE BABY", "BOBADDICTION", "SIPPING SHORTAGE", "BROKE A**", "TRASH TOWN", "BETTER HELP", "7 BEVVIES IN HEAVEN", "CHANGE UP"]
//
//        lines = (icons.count)/2
//        allItems = []
//        lineItems = [:]
//        groupItems()
//
//        //allItems = groupItems()
//
//    }
    
    func loadDB() {
        var bevs: [BevModel] = []
        
        db.collection("bevs").getDocuments { (querySnapshot, error) in
            if let e = error {
                print("error! \(e)")
            } else {
                if let snapshotDocs = querySnapshot?.documents {
                    for doc in snapshotDocs {
                        let data = doc.data()
                    }
                }
            }
        }
    }
    
//    mutating func increaseIndex() {
//        self.index += 1
//    }
//
//    mutating func groupItems() {
//
////        var tempGroup: [[String:String]]
////        tempGroup = [[:]]
////        var tempDict: [String:String]
////        tempDict = [:]
//
//        var tempIcons: [String] = []
//        var tempNames: [String] = []
//
//        var num = 0
//
//        for _ in 0..<lines {
//            for _ in 0..<2 {
//                if num == icons.count {
//                    break
//                }
//                tempIcons.append(icons[num])
//                tempNames.append(names[num])
//                num += 1
//            }
//            iconGroups.append(tempIcons)
//            nameGroups.append(tempNames)
//            tempIcons = []
//            tempNames = []
//            //tempDict = [:]
//        }
//        print(nameGroups)
//
//
//
//    }
    
    var body: some View {
        ZStack(alignment: .center)  {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack (alignment: .center) {
//                    VStack {
//                        Text("ANALYTICS")
//                            .font(Font.custom("Kiona", size: 30))
//                            .fontWeight(.regular)
//                            .foregroundColor(.white)
//                            .tracking(5)
//                            .multilineTextAlignment(.center)
//                            .frame(maxWidth: .infinity)
//                            .padding(.top, 10.0)

                            //.padding(.top, 50)
                          
                    VStack {
                        Text("ANALYTICS")
                            .font(Font.custom("Kiona", size: 30))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .tracking(5)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10.0)
                        Spacer()
                        Rectangle().fill(ColorModel().lightTan)
                        .cornerRadius2(25, corners: [.topLeft, .topRight])
                        .edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * (0.82))
                    }.frame(maxHeight: .infinity)
                    VStack {
                        VStack {
                            Text("number of bevs:  \(viewModel.user.numbevs!)")
                            Text("total spent: \(analyticsModel.analytics.spent)")
                            ScrollView {
                                VStack(alignment: .leading, spacing: 20.0) {
                                    ForEach(ConstModel().analyticNames, id: \.self) { item in
                                        VStack(alignment: .leading) {
                                            Text(item)
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("CaviarDreams", size: 20))
                                            .fontWeight(.bold)
                                            Rectangle().fill(ColorModel().darkTan)
                                                .frame(width: ConstModel().deviceWidth - 50, height: 50)
                                                .cornerRadius(10)
                                        }

                                    }
                                }
                                .frame(maxWidth: ConstModel().deviceWidth)

                                Spacer()
                                    .padding(.bottom)
                            }.padding(.top).frame(height: ConstModel().deviceHeight * (0.80) - 20 - (ConstModel().deviceHeight * 0.07))
                        }
                        .padding()
                        
                        
                    }
                    
                }
            }
        
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}

extension View {
    func cornerRadius2(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
