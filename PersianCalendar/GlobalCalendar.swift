//
//  GlobalCalendar.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/15/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import Foundation

public class GlobalCalendar {
    static var font: UIFont = UIFont.systemFont(ofSize: 14)
    static var weekColor: UIColor = .black
    static var dayColor: UIColor = .black
    static var dayViewColor: UIColor = .red
    public static var selectedCal: CalDate = CalDate(year: 0, month: 0, day: 0, nameMonth: "")
}
