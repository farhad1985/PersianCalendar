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
    private var currentDate: (calDate: CalDate, startDate: Int)!
    private var months = [
        "فروردین",
        "اردیبهشت",
        "خرداد",
        "تیر",
        "مرداد",
        "شهریور",
        "مهر",
        "آبان",
        "آذر",
        "دی",
        "بهمن",
        "اسفند"
    ]
    
    init() {
        cal = {
            var c = Calendar(identifier: .persian)
            c.locale = Locale(identifier: "fa_IR")
            return c
        }()
        
        currentDate = getCurrentDate()
    }
    
    func getDayOfToday() -> CalDate {
        let today = getPersianDate(date: Date())
        let todayCal = convertToGregorian(year: today.year,
                                          month: today.month,
                                          day: today.day)
        
        let date = cal.dateComponents([.year, .month, .day], from: todayCal ?? Date())
        
        return CalDate(year: date.year ?? 0,
                       month: date.month ?? 0,
                       day: date.day ?? 0,
                       nameMonth: months[(date.month ?? 0) - 1])
    }
    
    mutating func nextMothDate() -> [CalDate] {
        var nextMonth = currentDate.calDate.month + 1
        var nextYear = currentDate.calDate.year
        let date = currentDate.calDate
        if nextMonth > 12 {
            nextMonth = 1
            nextYear += 1
        }
        date.year = nextYear
        date.month = nextMonth
        currentDate = getDate(calDate: date)
        return getCollectOfDate(ofYear: nextYear, month: nextMonth, startDate: currentDate.startDate)
    }
    
    mutating func backMothDate() -> [CalDate] {
        var nextMonth = currentDate.calDate.month - 1
        var nextYear = currentDate.calDate.year
        let date = currentDate.calDate
        if nextMonth <= 0 {
            nextMonth = 12
            nextYear -= 1
        }
        date.year = nextYear
        date.month = nextMonth
        currentDate = getDate(calDate: date)
        return getCollectOfDate(ofYear: nextYear, month: nextMonth, startDate: currentDate.startDate)
    }
    
    mutating func getCurrentCollectionOfDate() -> [CalDate] {
        currentDate = getCurrentDate()
        return getCollectOfDate(ofYear: currentDate.calDate.year,
                                month: currentDate.calDate.month,
                                startDate: currentDate.startDate)
    }
    
    private func getCollectOfDate(ofYear year:Int, month: Int, startDate: Int) -> [CalDate] {
        let targetDayComponents = DateComponents(calendar: cal,
                                                 year: year,
                                                 month: month,
                                                 day: 1)
        
        guard let targetDay = cal.date(from: targetDayComponents) else { return [] }
        guard let range = cal.range(of: .day,
                                    in: .month,
                                    for: targetDay)
            else { return [] }
        
        var dates = ([Int](range.lowerBound..<range.upperBound)).map { (num) -> CalDate in
            return CalDate(year: year,
                           month: month,
                           day: num,
                           nameMonth: months[month - 1])
        }
        
        for _ in 0..<startDate {
            let calDate = CalDate(year: year,
                                  month: month,
                                  day: 0,
                                  nameMonth: months[month - 1])
            dates.insert(calDate, at: 0)
        }
        
        return dates
    }
    
    private func convertToGregorian(year: Int, month: Int, day: Int) -> Date? {
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
    
    private func getPersianDate(date: Date) -> (year:Int, month: Int, day: Int) {
        var date = cal.dateComponents([.year, .month, .day], from: date)
        return (year: date.year ?? 0, month: date.month ?? 0, day: date.day ?? 0)
    }
    
    private func getCurrentDate() -> (calDate: CalDate, startDate: Int) {
        let today = getPersianDate(date: Date())
        let firstDateOfThisMonth = convertToGregorian(year: today.year,
                                                      month: today.month,
                                                      day: 1)
        
        var date = cal.dateComponents([.year, .month, .day, .weekday],
                                      from: firstDateOfThisMonth ?? Date())
        
        let startDate =  (date.weekday ?? 0)
        let calDate = CalDate(year: date.year ?? 0,
                              month: date.month ?? 0,
                              day: date.day ?? 0,
                              nameMonth: months[(date.month ?? 0) - 1])
        return (calDate: calDate,
                startDate: startDate)
    }
    
    private func getDate(calDate: CalDate) -> (calDate: CalDate, startDate: Int) {
        let firstDateOfThisMonth = convertToGregorian(year: calDate.year,
                                                      month: calDate.month,
                                                      day: 1)
        
        var date = cal.dateComponents([.year, .month, .day, .weekday],
                                      from: firstDateOfThisMonth ?? Date())
        
        
        var startDate =  (date.weekday ?? 0)
        if startDate == 7 {
            startDate = 0
        }
        let calDate = CalDate(year: date.year ?? 0,
                              month: date.month ?? 0,
                              day: date.day ?? 0,
                              nameMonth: months[(date.month ?? 0) - 1])
        return (calDate: calDate,
                startDate: startDate)
    }
    
    private func myDateCompononents(date: Date) -> (year: Int, month: Int, day: Int) {
        let call = Calendar(identifier: .gregorian)
        let comps = call.dateComponents([.year, .month, .day], from: date)
        return (year: comps.year!, month: comps.month!, day: comps.day!)
    }
}
