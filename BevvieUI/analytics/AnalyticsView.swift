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
    
    
    @ObservedObject private var bevModel = BevViewModel()
    @ObservedObject private var analyticsModel = UserAnalyticsViewModel()

    
//    func loadDB() {
//        var bevs: [BevModel] = []
//
//        db.collection("bevs").getDocuments { (querySnapshot, error) in
//            if let e = error {
//                print("error! \(e)")
//            } else {
//                if let snapshotDocs = querySnapshot?.documents {
//                    for doc in snapshotDocs {
//                        let data = doc.data()
//                    }
//                }
//            }
//        }
//    }

    
    var body: some View {
        ZStack(alignment: .center)  {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack (alignment: .center) {
                          
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
                        ZStack {
                            Rectangle().fill(ColorModel().lightTan)
                                .cornerRadius2(25, corners: [.topLeft, .topRight])
                                .edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * (0.85))
                        
                            VStack {
                                LazyVGrid(columns: [
                                    GridItem(.adaptive(minimum: (ConstModel().deviceWidth)/3))
                                ]) {
                                    VStack {
                                        Text("TOTAL BEVVIE PURCHASES")
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 20))
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)

                                        
                                        ZStack {
                                            Rectangle().fill(ColorModel().darkTan)
                                                .frame(height:150)
                                                .cornerRadius(10)
                                            VStack {
                                                Text("\(analyticsModel.analytics.numbevs ?? 0)")
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 40))
                                                    .fontWeight(.bold)
                                                Text("BEVVIES")
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 30))
                                                    .fontWeight(.bold)
                                            }
                                        }
                                    }.padding()
                                    VStack {
                                        
                                        Text("TOTAL MONEY SPENT")
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 20))
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)

                                        
                                        ZStack {
                                            Rectangle().fill(ColorModel().darkTan)
                                                .frame(height:150)
                                                .cornerRadius(10)
                                            VStack {
                                                Text("$\(String(format: "%.2f", analyticsModel.analytics.money!))")
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 40))
                                                    .fontWeight(.bold)
                                                Text("SPENT")
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 30))
                                                    .fontWeight(.bold)
                                            }
                                        }
                                    }.padding()
                                    VStack {
                                        
                                        Text("GO TO ORDER")
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 20))
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)

                                        
                                        ZStack {
                                            Rectangle().fill(ColorModel().darkTan)
                                                .frame(height:150)
                                                .cornerRadius(10)
                                            VStack (alignment: .center) {
                                                Image("breakdown-boba")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width:80)
                                                Text(bevModel.getFavorite())
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 15))
                                                    .fontWeight(.bold)
                                                    .multilineTextAlignment(.center)

                                            }
                                        }
                                    }.padding()
                                    VStack {
                                        
                                        Text("FAVORITE TYPE")
                                            .foregroundColor(ColorModel().darkGreen)
                                            .font(Font.custom("Kiona", size: 20))
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)

                                        ZStack {
                                            Rectangle().fill(ColorModel().darkTan)
                                                .frame(height:150)
                                                .cornerRadius(10)
                                            VStack (alignment: .center) {
                                                Image("boba")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width:80)
                                                Text(bevModel.getType())
                                                    .foregroundColor(ColorModel().darkGreen)
                                                    .font(Font.custom("Kiona", size: 15))
                                                    .fontWeight(.bold)
                                            }
                                        }
                                    }.padding()
                                }
                                Spacer()
                            }.frame(width: ConstModel().deviceWidth, height: ConstModel().deviceHeight * 0.85)
                            Spacer()
                        }.frame(height: ConstModel().deviceHeight * 0.85)
                    }.frame(height: ConstModel().deviceHeight * 0.85)
                        
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

//Text("number of bevs:  \(analyticsModel.analytics.numbevs!)")
//Text("money spent:  \(String(format: "%.2f", analyticsModel.analytics.money!))")
//                            Text("total spent: \(analyticsModel.analytics.spent)")
//                            ScrollView {
//                                VStack(alignment: .leading, spacing: 20.0) {
//                                    ForEach(ConstModel().analyticNames, id: \.self) { item in
//                                        VStack(alignment: .leading) {
//                                            Text(item)
//                                            .foregroundColor(ColorModel().darkGreen)
//                                            .font(Font.custom("CaviarDreams", size: 20))
//                                            .fontWeight(.bold)
//                                            Rectangle().fill(ColorModel().darkTan)
//                                                .frame(width: ConstModel().deviceWidth - 50, height: 50)
//                                                .cornerRadius(10)
//                                        }
//
//                                    }
//                                }
//                                .frame(maxWidth: ConstModel().deviceWidth)
//
//                                Spacer()
//                                    .padding(.bottom)
//                            }.padding(.top).frame(height: ConstModel().deviceHeight * (0.80) - 20 - (ConstModel().deviceHeight * 0.07))
