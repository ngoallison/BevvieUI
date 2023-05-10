//
//  AnalyticsView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct AnalyticsView: View {
    
    let db = Firestore.firestore()
    
    @State private var showAchievement = false
    @State private var theName = ""
    @State private var selectedStatus = 0
    
    
    @EnvironmentObject var bevModel: BevViewModel
    @EnvironmentObject var anaModel: UserAnalyticsViewModel
    
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
                            .tracking(2)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10.0)
                        Spacer()
                        ZStack {
                            Rectangle().fill(ColorModel().lightTan)
                                .cornerRadius2(25, corners: [.topLeft, .topRight])
                                .edgesIgnoringSafeArea(.all).frame(height: ConstModel().deviceHeight * (0.85))
                            VStack {
                                Spacer()

                                LazyVGrid(columns: [
                                    GridItem(.adaptive(minimum: (ConstModel().deviceWidth)/3))
                                ]) {
                                    AnalyticsBox(title: "TOTAL BEVVIE PURCHASES", header: "\(anaModel.analytics.numbevs!)", sub: "BEVVIES")
                                    AnalyticsBox(title: "TOTAL MONEY SPENT", header: "$\(String(format: "%.2f", anaModel.analytics.money!))", sub: "SPENT")
                                    AnalyticsBox(title: "GO TO ORDER", sub: bevModel.getFavorite(), image: "breakdown-boba")
                                    AnalyticsBox(title: "FAVORITE TYPE",  sub: bevModel.getType(), image: "boba")
                                    
                                    let avg = anaModel.analytics.money! / Double(anaModel.analytics.numbevs!)
                                    AnalyticsBox(title: "AVERAGE BEVVIE PRICE", header: "$\(String(format: "%.2f", avg))", sub: "PER BEVVIE")
                                    
                                    AnalyticsBox(title: "MOST VISITED LOCATION", header: bevModel.getLocation())
                                    

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
            .environmentObject(UserAnalyticsViewModel())
            .environmentObject(BevViewModel())
    }
}

extension View {
    func cornerRadius2(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


//                                    VStack {
//                                        Text("TOTAL BEVVIE PURCHASES")
//                                            .foregroundColor(ColorModel().darkGreen)
//                                            .font(Font.custom("Kiona", size: 20))
//                                            .fontWeight(.bold)
//                                            .multilineTextAlignment(.center)
//
//
//                                        ZStack {
//                                            Rectangle().fill(ColorModel().darkTan)
//                                                .frame(height:120)
//                                                .cornerRadius(10)
//                                            VStack {
//                                                Text("\(anaModel.analytics.numbevs ?? 1)")
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 30))
//                                                    .fontWeight(.bold)
//                                                Text("BEVVIES")
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 20))
//                                                    .fontWeight(.bold)
//                                            }
//                                        }
//                                    }.padding()
//                                    VStack {
//
//                                        Text("TOTAL MONEY SPENT")
//                                            .foregroundColor(ColorModel().darkGreen)
//                                            .font(Font.custom("Kiona", size: 20))
//                                            .fontWeight(.bold)
//                                            .multilineTextAlignment(.center)
//
//
//                                        ZStack {
//                                            Rectangle().fill(ColorModel().darkTan)
//                                                .frame(height:120)
//                                                .cornerRadius(10)
//                                            VStack {
//                                                Text("$\(String(format: "%.2f", anaModel.analytics.money!))")
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 30))
//                                                    .fontWeight(.bold)
//                                                Text("SPENT")
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 20))
//                                                    .fontWeight(.bold)
//                                            }
//                                        }
//                                    }.padding()
//                                    VStack {
//
//                                        Text("GO TO ORDER")
//                                            .foregroundColor(ColorModel().darkGreen)
//                                            .font(Font.custom("Kiona", size: 20))
//                                            .fontWeight(.bold)
//                                            .multilineTextAlignment(.center)
//
//
//                                        ZStack {
//                                            Rectangle().fill(ColorModel().darkTan)
//                                                .frame(height:120)
//                                                .cornerRadius(10)
//                                            VStack (alignment: .center) {
//                                                Image("breakdown-boba")
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .frame(width:80)
//                                                Text(bevModel.getFavorite())
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 15))
//                                                    .fontWeight(.bold)
//                                                    .multilineTextAlignment(.center)
//
//                                            }
//                                        }
//                                    }.padding()
//                                    VStack {
//
//                                        Text("FAVORITE TYPE")
//                                            .foregroundColor(ColorModel().darkGreen)
//                                            .font(Font.custom("Kiona", size: 20))
//                                            .fontWeight(.bold)
//                                            .multilineTextAlignment(.center)
//
//                                        ZStack {
//                                            Rectangle().fill(ColorModel().darkTan)
//                                                .frame(height:120)
//                                                .cornerRadius(10)
//                                            VStack (alignment: .center) {
//                                                Image("boba")
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .frame(width:80)
//                                                Text(bevModel.getType())
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 15))
//                                                    .fontWeight(.bold)
//                                            }
//                                        }
//                                    }.padding()
//                                    VStack {
//                                        Text("AVERAGE BEVVIE PRICE")
//                                            .foregroundColor(ColorModel().darkGreen)
//                                            .font(Font.custom("Kiona", size: 20))
//                                            .fontWeight(.bold)
//                                            .multilineTextAlignment(.center)
//
//
//                                        ZStack {
//                                            Rectangle().fill(ColorModel().darkTan)
//                                                .frame(height:120)
//                                                .cornerRadius(10)
//                                            VStack {
//                                                let avg = anaModel.analytics.money! / Double(anaModel.analytics.numbevs!)
//                                                Text("$\(String(format: "%.2f", avg))")
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 30))
//                                                    .fontWeight(.bold)
//                                                Text("PER BEVVIE")
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 20))
//                                                    .fontWeight(.bold)
//                                            }
//                                        }
//                                    }.padding()
//                                    VStack {
//                                        Text("MOST VISITED LOCATION")
//                                            .foregroundColor(ColorModel().darkGreen)
//                                            .font(Font.custom("Kiona", size: 20))
//                                            .fontWeight(.bold)
//                                            .multilineTextAlignment(.center)
//
//
//                                        ZStack {
//                                            Rectangle().fill(ColorModel().darkTan)
//                                                .frame(height:120)
//                                                .cornerRadius(10)
//                                            VStack {
//                                                Text("\(bevModel.getLocation())")
//                                                    .foregroundColor(ColorModel().darkGreen)
//                                                    .font(Font.custom("Kiona", size: 30))
//                                                    .fontWeight(.bold)
//                                            }
//                                        }
//                                    }.padding()
