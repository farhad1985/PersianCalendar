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

class PersianCalendarVC: UIViewController{

    var vwWeek = WeekDaysView()
    var collection = DaysCollectionView()
    var lblTitle = UILabel()
    
    var pageIndex = 0
    var dataSource: [CalDate] = []
    var today: CalDate!
    var delegate: Listener?{
        didSet {
            collection.delegate = delegate
        }
    }

    init() {
        let bundle = Bundle(for: PersianCalendarVC.self)
        super.init(nibName: nil, bundle: bundle)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setData(dataSource: [CalDate], today: CalDate) {
        self.dataSource = dataSource
        self.today = today
        collection.setDate(calDays: dataSource, today: today)
        lblTitle.text = "\(dataSource[0].nameMonth) \(dataSource[0].year)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        lblTitle.font = GlobalCalendar.font
        collection.reload()
    }
    
    private func setup() {
        collection = DaysCollectionView(style: .dark,
                                        type: .corner,
                                        delegate: delegate)

        lblTitle.textAlignment = .center
        lblTitle.textColor = UIColor(red: 18/255, green: 0, blue: 94/255, alpha: 1)
//        lblTitle.font = GlobalCalendar.font

        view.addSubview(lblTitle)
        view.addSubview(vwWeek)
        view.addSubview(collection)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lblTitle.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lblTitle.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true

        vwWeek.translatesAutoresizingMaskIntoConstraints = false
        vwWeek.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vwWeek.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vwWeek.topAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        vwWeek.heightAnchor.constraint(equalToConstant: 35).isActive = true

        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collection.topAnchor.constraint(equalTo: vwWeek.bottomAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
