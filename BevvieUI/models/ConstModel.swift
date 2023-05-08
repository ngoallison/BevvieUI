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
    
    var policy1: String =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ultrices convallis leo. Suspendisse aliquam, odio eget euismod iaculis, orci tellus sagittis est, id tempus nisi purus ut ipsum. Donec aliquet fermentum fermentum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec ultricies dolor vel neque faucibus viverra. Praesent in vulputate erat. Proin congue mi eu dolor facilisis mattis."
    var policy2: String = "Suspendisse lobortis faucibus elit rhoncus lacinia. Ut quis metus euismod, euismod augue a, porttitor tellus. Aliquam augue massa, congue sed fringilla pharetra, venenatis rutrum orci. Nam tempor cursus velit a volutpat. Vivamus interdum magna ullamcorper augue auctor, quis blandit magna gravida. Proin tellus turpis, placerat quis enim a, ultricies malesuada justo."
    
    var icons: [String] = ["hot-coffee", "heart", "ice-cubes", "boba", "skull", "money", "trash", "therapy", "seven", "stop"]
    var names: [String] = ["HOT CROSS BUNS", "LOVER BOY", "ICE ICE BABY", "BOBADDICTION", "SIPPING SHORTAGE", "BROKE A**", "TRASH TOWN", "BETTER HELP", "7 BEVVIES IN HEAVEN", "CHANGE UP"]
    var goal: [String] = ["Order 10 hot bevvies!", "Enjoy 15 bevvies!", "Order 10 iced bevvies", "Order over 50 bevvies", "Go 7 days without ordering a bevvie :(", "Spend over $200 on bevvies!", "Dislike 15 drinks :(", "Spend enough money on bevvies equivalent to a session of therapy", "Order a bevvie 7 days in a row!", "Try at least 20 new drinks!"]

}
