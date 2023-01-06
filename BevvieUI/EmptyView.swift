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
    
    var data: [ToyShape] = [
        .init(type: "Cube", count: 5),
        .init(type: "Sphere", count: 4),
        .init(type: "Pyramid", count: 4)
    ]
    
    var body: some View {
        Text("hello!")
    }
}
struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
