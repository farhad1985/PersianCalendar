//
//  ViewController.swift
//  Example
//
//  Created by Farhad Faramarzi on 12/10/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit
import PersianCalendar

class ViewController: UIViewController {

    @IBOutlet weak var vwCalendar: PersianCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwCalendar.font = UIFont(name: "IRANSansMonoSpacedNum-Light", size: 20)!
        vwCalendar.delegate = { calDate in
            print(calDate)
        }
    }

}

