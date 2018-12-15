//
//  CalViewModel.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/10/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import Foundation

struct CalViewModel {
    
    private let cal: Calendar

    init() {
        cal = {
            var c = Calendar(identifier: .persian)
            c.locale = Locale(identifier: "fa_IR")
            return c
        }()
    }
    
    func getCurrentDate() -> (year:Int, month: Int, startDate: Int) {
        let today = getPersianDate(date: Date())
        guard let firstDateOfThisMonth = convertToGregorian(year: today.year,
                                                            month: today.month,
                                                            day: 1)
            else {return (year:0, month: 0, startDate: 0)}
        
        let date = cal.dateComponents([.year, .month, .weekday],
                                      from: firstDateOfThisMonth)
        let startDate =  (date.weekday ?? 0)
        return (year: date.year ?? 0, month: date.month ?? 0, startDate: startDate)
    }
    
    private func getPersianDate(date: Date) -> (year:Int, month: Int, day: Int) {
        let date = cal.dateComponents([.year, .month, .day], from: date)
        return (year: date.year ?? 0, month: date.month ?? 0, day: date.day ?? 0)
    }
    
    func daysRange(ofYear year:Int, month: Int, startDate: Int) -> [String] {
        let targetDayComponents = DateComponents(calendar: cal,
                                                 year: year,
                                                 month: month,
                                                 day: 1)
        guard let targetDay = cal.date(from: targetDayComponents) else { return [] }
        guard let range = cal.range(of: .day, in: .month, for: targetDay) else { return [] }
        
        var days = ([Int](range.lowerBound..<range.upperBound)).map { (num) -> String in
            return String(describing: num)
        }
        
        for _ in 0..<startDate {
            days.insert("", at: 0)
        }
        return days
    }
    
    func myDateCompononents(date: Date) -> (year: Int, month: Int, day: Int) {
        let call = Calendar(identifier: .gregorian)
        let comps = call.dateComponents([.year, .month, .day], from: date)
        return (year: comps.year!, month: comps.month!, day: comps.day!)
    }
    
    func convertToGregorian(year: Int, month: Int, day: Int) -> Date? {
        guard let persianDate = getPersianDate(year: year, month: month, day: day) else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let pDate = dateFormatter.date(from: persianDate) else {return nil}
        
        let gregorianDateString = dateFormatter.string(from: pDate)
        dateFormatter.calendar = Calendar(identifier: .persian)
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        return dateFormatter.date(from: gregorianDateString)
    }
    
    private func getPersianDate(year: Int, month: Int, day: Int) -> String? {
        return "\(year)/\(month)/\(day)"
    }
}
