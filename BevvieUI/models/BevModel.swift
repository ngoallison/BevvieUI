//
//  BevViewModel.swift
//  BevvieUI
//
//  Created by Allison Ngo on 12/30/22.
//

import Foundation
import SwiftUICharts
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

/*
 var uid: String? = ""
 var name: String? = ""
 var location: String? = ""
 var temp: String? = ""
 var price: Float? = 0
 var type: String? = ""
 var size: String? = ""
 var date: Date? = Date()
 var satisfaction: String? = "happy-face"
 */

struct bevMonth: Identifiable {
    let id = UUID()
    let month: String
    let count: Int
}

class BevModel: ObservableObject {
    
    @Published var bev: Bev = Bev()
    @Published var bevCount: Int = 0
    
    private var db = Firestore.firestore()
    private var data: [QueryDocumentSnapshot] = []
    
    func getBev () {
        
        print("getting bevs")
        //print(Auth.auth().currentUser?.uid)
        db.collection("bevs").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No Documents")
                return
            }
            if documents.count == 0 {
                return
            }
            
            print("got bevs")
            print(documents.count)
            self.bevCount = documents.count
            self.data = documents
            print(self.data.count)
        }
    }
    
    func getBevFromDate(bevDate: String) -> Bev {
        
        print(self.data.count)
        print(bevDate)
        var item: Bev = Bev()
        for doc in self.data {
            print("hi")
            print(doc["date"])
            if doc["date"] as! String == bevDate {
                item.name = (doc["name"] as! String)
                item.location = (doc["location"] as! String)
                item.temp = (doc["temp"] as! String)
                item.price = (doc["price"] as! Double)
                item.type = (doc["type"] as! String)
                item.date = (doc["date"] as! String)
                item.satisfaction = (doc["satisfaction"] as! String)
            }
        }
        return item
        //formatter.string(from: bevDate)
    }
    
    func getFavorite() -> String {
        
        var dictionary: [String:Int] = [:]
        for doc in self.data {
            if let count = dictionary[doc["name"] as! String] {
                dictionary[doc["name"] as! String] = count + 1
            } else {
                dictionary[doc["name"] as! String] = 1
            }
        }
        
        var maxFrequency = 0
        var favorite = ""
        for (name, frequency) in dictionary {
            if frequency > maxFrequency {
                maxFrequency = frequency
                favorite = name
            }
        }
        return favorite
    }
    
    func getType() -> String {
        
        var dictionary: [String:Int] = [:]
        for doc in self.data {
            if let count = dictionary[doc["type"] as! String] {
                dictionary[doc["type"] as! String] = count + 1
            } else {
                dictionary[doc["type"] as! String] = 1
            }
        }
        
        var maxFrequency = 0
        var type = ""
        for (name, frequency) in dictionary {
            if frequency > maxFrequency {
                maxFrequency = frequency
                type = name
            }
        }
        return type
    }
    
    func getLocation() -> String {
        
        var dictionary: [String:Int] = [:]
        for doc in self.data {
            if let count = dictionary[doc["location"] as! String] {
                dictionary[doc["location"] as! String] = count + 1
            } else {
                dictionary[doc["location"] as! String] = 1
            }
        }
        
        var maxFrequency = 0
        var location = ""
        for (name, frequency) in dictionary {
            if frequency > maxFrequency {
                maxFrequency = frequency
                location = name
            }
        }
        if location == "" {
            location = "N/A"
        }
        return location
    }
    
    func getDates() -> [Date] {
        
        var dates: [Date] = []
        for doc in self.data {
            let string = doc["date"] as! String
            // Create Date Formatter
            let dateFormatter = DateFormatter()
            
            // Set Date Format
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            // Convert String to Date
            let date = dateFormatter.date(from: string)!
            dates.append(date)
        }
        return dates;
    }
    
//
//    func getPerMonth() -> [bevMonth] {
//
//        var months: [bevMonth] = []
//
//        var monthCounts: [String: Int] = [
//            "Jan" : 0,
//            "Feb" : 0,
//            "Mar" : 0,
//            "Apr" : 0,
//            "May" : 0,
//            "Jun" : 0,
//            "Jul" : 0,
//            "Aug" : 0,
//            "Sep" : 0,
//            "Oct" : 0,
//            "Nov" : 0,
//            "Dec" : 0,
//        ]
//        let dateFormatter: DateFormatter = {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MMM"
//            return formatter
//        }()
//
//        let monthOrder = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
//
//
//        for doc in self.data {
//            let string = doc["date"] as! String
//            let formatter = DateFormatter()
//
//            formatter.dateFormat = "MM/dd/yyyy"
//            let date = formatter.date(from:string)!
//            let monthString = dateFormatter.string(from: date)
//            if let count = monthCounts[monthString] {
//                monthCounts[monthString] = count + 1
//            }
//        }
//
//        for (key,value) in monthCounts {
//            months.append(bevMonth(month: key, count: value))
//        }
//
//        return months
//    }
    
    func getLineMoney() -> [Double] {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            return formatter
        }()

        var monthCounts: [String: Double] = [
            "Jan" : 0,
            "Feb" : 0,
            "Mar" : 0,
            "Apr" : 0,
            "May" : 0,
            "Jun" : 0,
            "Jul" : 0,
            "Aug" : 0,
            "Sep" : 0,
            "Oct" : 0,
            "Nov" : 0,
            "Dec" : 0,
        ]
        for doc in self.data {

            let string = doc["date"] as! String
            // Create Date Formatter
            let formatter = DateFormatter()

            // Set Date Format
            formatter.dateFormat = "MM/dd/yyyy"

            // Convert String to Date
            let date = formatter.date(from: string)!
            let monthString = dateFormatter.string(from: date)
            print(monthString)
            
            if let count = monthCounts[monthString] {
                monthCounts[monthString] = count + (doc["price"] as! Double)
            }
        }
        
        let monthOrder = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var foo: [Double] = []
        
        for month in monthOrder {
            foo.append(monthCounts[month]!)
        }

        return foo;
    }
    
    func getLineMonth() -> [Double] {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            return formatter
        }()

        var monthCounts: [String: Double] = [
            "Jan" : 0,
            "Feb" : 0,
            "Mar" : 0,
            "Apr" : 0,
            "May" : 0,
            "Jun" : 0,
            "Jul" : 0,
            "Aug" : 0,
            "Sep" : 0,
            "Oct" : 0,
            "Nov" : 0,
            "Dec" : 0,
        ]
        for doc in self.data {

            let string = doc["date"] as! String
            // Create Date Formatter
            let formatter = DateFormatter()

            // Set Date Format
            formatter.dateFormat = "MM/dd/yyyy"

            // Convert String to Date
            let date = formatter.date(from: string)!
            let monthString = dateFormatter.string(from: date)
            print(monthString)
            if let count = monthCounts[monthString] {
                monthCounts[monthString] = count + 1
            }
        }
        
        let monthOrder = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var foo: [Double] = []
        
        for month in monthOrder {
            foo.append(monthCounts[month]!)
        }

        return foo;

    }
    
    func getPerMonth() -> [(String,Int)] {

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            return formatter
        }()

        var monthCounts: [String: Int] = [
            "Jan" : 0,
            "Feb" : 0,
            "Mar" : 0,
            "Apr" : 0,
            "May" : 0,
            "Jun" : 0,
            "Jul" : 0,
            "Aug" : 0,
            "Sep" : 0,
            "Oct" : 0,
            "Nov" : 0,
            "Dec" : 0,
        ]
        for doc in self.data {

            let string = doc["date"] as! String
            // Create Date Formatter
            let formatter = DateFormatter()

            // Set Date Format
            formatter.dateFormat = "MM/dd/yyyy"

            // Convert String to Date
            let date = formatter.date(from: string)!
            let monthString = dateFormatter.string(from: date)

            if let count = monthCounts[monthString] {
                monthCounts[monthString] = count + 1
            }
        }

        let monthOrder = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
        let todayDate = Date()
        let month = dateFormatter.string(from: todayDate)
        
        var startIndex = monthOrder.firstIndex(of: month);
        var foo: [(String, Int)] = []
        
        for _ in 1...6 {
            if startIndex! < 0 {
                let monthStr = monthOrder[monthOrder.count + startIndex!]
                foo.insert((monthStr, monthCounts[monthStr]!), at: 0)
            }
            else {
                let monthStr = monthOrder[startIndex!]
                foo.insert((monthStr, monthCounts[monthStr]!), at: 0)
            }
            startIndex! -= 1
        }

        return foo;

    }
}
    
    
