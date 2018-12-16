//
//  CalDate.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/16/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import Foundation

public class CalDate: Equatable {
    public var year: Int = 0
    public var month: Int = 0
    public var day: Int = 0
    public var nameMonth: String = ""
    
    public init(year: Int, month: Int, day: Int, nameMonth: String) {
        self.year = year
        self.month = month
        self.day = day
        self.nameMonth = nameMonth
    }
    
    public static func ==(lhs: CalDate, rhs: CalDate) -> Bool {
        return (lhs.year == rhs.year) &&
            (lhs.month == rhs.month) &&
            (lhs.day == rhs.day)
    }
}
