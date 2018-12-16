//
//  PersianCalendarView.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/16/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit

public typealias Listener = (_ calDate: CalDate) -> ()

public class PersianCalendarView: UIView {
    var viewModel = CalViewModel()
    var pageController: UIPageViewController!
    private var listVC: [PersianCalendarVC] = []
    private var currentDate: CalDate!
    
    public var delegate: Listener? {
        didSet {
           listVC = listVC.map { (item) -> PersianCalendarVC in
                item.delegate = delegate
                return item
            }
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
    
    public var font: UIFont = GlobalCalendar.font {
        didSet {
            GlobalCalendar.font = font
        }
    }

    private func setup() {
        let vc = PersianCalendarVC()
        vc.pageIndex = 0
        vc.setData(dataSource: viewModel.getCurrentCollectionOfDate(), today: viewModel.getDayOfToday())
        listVC.append(vc)
        
        for i in 1..<12 {
            let vc = PersianCalendarVC()
            vc.pageIndex = i
            vc.setData(dataSource: viewModel.nextMothDate(), today: viewModel.getDayOfToday())
            listVC.append(vc)
        }
        
        pageController = UIPageViewController(transitionStyle: .scroll,
                                              navigationOrientation: .horizontal,
                                              options: nil)
        
        
        addSubview(pageController.view)
        pageController.dataSource = self
        pageController.delegate = self
        GlobalCalendar.selectedCal = viewModel.getDayOfToday()
        DispatchQueue.main.async {
            self.pageController.setViewControllers([self.listVC.first!],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)

        }
        

    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageController.view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pageController.view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pageController.view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pageController.view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension PersianCalendarView: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? PersianCalendarVC else {return nil}
        let pageIndex = vc.pageIndex + 1
        
        guard pageIndex < listVC.count else {
                return nil
        }
        return listVC[pageIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? PersianCalendarVC else {return nil}
        let pageIndex = vc.pageIndex - 1
        guard pageIndex >= 0 else {
                return nil
        }
        print(pageIndex)
        return listVC[pageIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return listVC.count
    }
}
