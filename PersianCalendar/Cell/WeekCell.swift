//
//  WeekCell.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/10/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit

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
        
        title.font = UIFont.systemFont(ofSize: 13)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
