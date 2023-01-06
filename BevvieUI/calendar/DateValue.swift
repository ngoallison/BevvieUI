//
//  DateValue.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import SwiftUI

// Date Value Model ...

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
