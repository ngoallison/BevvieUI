//
//  MasterView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/20/22.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    var body: some View {
        HomeView()
    }
}

struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
        MainView().previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
        }
    }
}
