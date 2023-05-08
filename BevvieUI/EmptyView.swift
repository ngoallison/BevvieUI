//
//  EmptyView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/12/22.
//

import SwiftUI
import Charts

struct Amount {
    var month: String
    var amount: Double
}

struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

struct EmptyView: View {
    var body: some View {
            GeometryReader { geo in
                ZStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.75)

                    ZStack {
                        Text("Hello, world!")
                            .padding()
                    }
                    .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.75, alignment: .topLeading)
                }
            }
        }
}
//    var data: [ToyShape] = [
//        .init(type: "Cube", count: 5),
//        .init(type: "Sphere", count: 4),
//        .init(type: "Pyramid", count: 4)
//    ]
//
//    var body: some View {
//        List {
//                    Chart {
//                        BarMark(
//                            x: .value("Mount", "jan/22"),
//                            y: .value("Value", 5)
//                        )
//                        BarMark(
//                            x: .value("Mount", "fev/22"),
//                            y: .value("Value", 4)
//                        )
//                        BarMark(
//                            x: .value("Mount", "mar/22"),
//                            y: .value("Value", 7)
//                        )
//                    }
//                    .frame(height: 250)
//                }
//    }
//}
struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
