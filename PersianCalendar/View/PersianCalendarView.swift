//
//  PersianCalendarView.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/10/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit

public enum StyleCalendar {
    case light
    case dark
    case custom(font: UIColor, backCell: UIColor, today: UIColor, selection: UIColor)
}

public class PersianCalendarView: UIView {

    let vwWeek = WeekDaysView()
    var daysCollection = DaysCollectionView()
    let viewModel = CalViewModel()
    
    public var style: StyleCalendar = .dark {
        didSet {
            setSytle()
        }
    }
    public var cornerType: CornerType = .circular {
        didSet {
            setSytle()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setSytle() {
        daysCollection.setStyle(style: style, type: cornerType)
    }
    
    private func setup() {
        daysCollection = DaysCollectionView(style: style, type: cornerType)
        
        addSubview(vwWeek)
        addSubview(daysCollection)
        let date = viewModel.getCurrentDate()
        let days = viewModel.daysRange(ofYear: date.year, month: date.month, startDate: date.startDate)
        daysCollection.setDate(days: days, today: viewModel.getDayOfToday())        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        vwWeek.translatesAutoresizingMaskIntoConstraints = false
        vwWeek.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        vwWeek.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        vwWeek.topAnchor.constraint(equalTo: topAnchor).isActive = true
        vwWeek.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        daysCollection.translatesAutoresizingMaskIntoConstraints = false
        daysCollection.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        daysCollection.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        daysCollection.topAnchor.constraint(equalTo: vwWeek.bottomAnchor).isActive = true
        daysCollection.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
