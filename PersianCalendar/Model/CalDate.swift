//
//  CalDate.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/16/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import Foundation

struct CalDate: Equatable {
    var year: Int
    var month: Int
    var day: Int
    var nameMonth: String
    
    static func ==(lhs: CalDate, rhs: CalDate) -> Bool {
        return (lhs.year == rhs.year) &&
            (lhs.month == rhs.month) &&
            (lhs.day == rhs.day)
    }
}
