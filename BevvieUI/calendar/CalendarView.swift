//
//  CalendarView.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    
    @State var currentDate: Date = Date()
    
    var body: some View {
        ZStack {
            ColorModel().orangeBrown.edgesIgnoringSafeArea(.all)
            CustomDatePicker(currentDate: $currentDate)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

struct CalendarView_Preview: PreviewProvider {
    static var previews: some View {
        CalendarView().previewDevice(PreviewDevice(rawValue: "iPhone 12")).previewInterfaceOrientation(.portrait)
    }
}
