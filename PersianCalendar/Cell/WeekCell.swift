//
//  WeekCell.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/10/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit

public enum CornerType {
    case circular
    case corner
}

class WeekCell: UICollectionViewCell {
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(title)
        
        title.font = GlobalCalendar.font
    }
    
    func config(calDate: CalDate, style: StyleCalendar, type: CornerType, isToday: Bool) {
        if calDate.day == 0 {
            backgroundColor = .clear
            title.text = ""
        } else {
            title.font = GlobalCalendar.font
            title.text = String(calDate.day)

            if calDate == GlobalCalendar.selectedCal {
                title.textColor = .white
                backgroundColor = .red
            } else {
                setStyle(style: .dark, isToday: isToday)
            }
            
            switch type {
            case .circular:
                layer.cornerRadius = self.frame.width / 2
            default:
                layer.cornerRadius = 7
            }
        }
    }
    
    private func setStyle(style: StyleCalendar, isToday: Bool) {
        let textColor: UIColor
        let backColor: UIColor

        switch style {
        case .light:
            textColor = .black
                backColor = .clear
        case .dark:
            textColor = .white
            backColor = UIColor(red: 18/255, green: 0, blue: 94/255, alpha: 1)
            
        case .custom(let fontColor, let backCell, let today, let selection):
            textColor = fontColor
            if isToday {
                backColor = today
            } else {
                backColor = backCell
            }
        }
        
        title.textColor = textColor
        backgroundColor = backColor
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
