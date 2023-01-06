//
//  ConstModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 9/21/22.
//

import Foundation
import SwiftUI

struct ConstModel {
    
    var deviceWidth: CGFloat { UIScreen.main.bounds.width }
    var deviceHeight: CGFloat { UIScreen.main.bounds.height }
    
    var analyticNames: [String] = ["Total Purchases", "Satisfaction", "Types of Bevvies", "Total Money Spent", "Achievements Unlocked", "Favorite Bevvie Types", "Go To Order", "Most Visited Location", "Longest Bevvie Streak"]

}
