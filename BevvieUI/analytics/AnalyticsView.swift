//
//  AnalyticsView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//
//  analytics view that contains components for user analytics

import SwiftUI
import FirebaseFirestore
import Firebase

struct AnalyticsView: View {
    
    let db = Firestore.firestore()

    @EnvironmentObject var bevModel: BevModel
    @EnvironmentObject var anaModel: AnalyticsModel
    
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
                                .edgesIgnoringSafeArea(.all).frame(height: ConstModel().height * (0.8))
                            VStack {
                                
                                // grid of all analytics
                                ScrollView() {
                                    LazyVGrid(columns: [
                                        GridItem(.adaptive(minimum: (ConstModel().width)/3))
                                    ]) {
                                        AnalyticsBox(title: "TOTAL BEVVIE PURCHASES", header: "\(anaModel.analytics.numbevs!)", sub: "BEVVIES")
                                        AnalyticsBox(title: "TOTAL MONEY SPENT", header: "$\(String(format: "%.2f", anaModel.analytics.money!))", sub: "SPENT")
                                        AnalyticsBox(title: "GO TO ORDER", sub: bevModel.getFavorite(), image: "breakdown-boba")
                                        AnalyticsBox(title: "FAVORITE TYPE",  sub: bevModel.getType(), image: "boba")
                                        
                                        let bevs = Double(anaModel.analytics.numbevs!)
                                        let avg = bevs > 0 ? anaModel.analytics.money! / bevs : 0
                                        
                                        AnalyticsBox(title: "AVERAGE BEVVIE PRICE", header: "$\(String(format: "%.2f", avg))", sub: "PER BEVVIE")
                                        
                                        AnalyticsBox(title: "MOST VISITED LOCATION", header: bevModel.getLocation())
                                        
                                        
                                    }.padding(.top, 10)
                                    Divider().padding(.vertical, 5)
                                    
                                    // graphs section
                                    GraphView()
                                }
                            }.frame(width: ConstModel().width, height: ConstModel().height * 0.77)
                            Spacer()
                        }.frame(height: ConstModel().height * 0.8)
                    }.frame(height: ConstModel().height * 0.8)
                    
                }
                
            }
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
            .environmentObject(AnalyticsModel())
            .environmentObject(BevModel())
    }
}

extension View {
    func cornerRadius2(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
