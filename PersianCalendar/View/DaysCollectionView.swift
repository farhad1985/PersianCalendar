//
//  DaysCollectionView.swift
//  PersianCalendar
//
//  Created by Farhad Faramarzi on 12/10/18.
//  Copyright © 2018 Farhad. All rights reserved.
//

import UIKit

class DaysCollectionView: UIView {
    
    private var collection: UICollectionView!
    fileprivate var days: [String] = []
    private var width: CGFloat = 0
    private var style: StyleCalendar = .light
    private var type: CornerType = .circular
    private var today = ""

    init(style: StyleCalendar, type: CornerType) {
        super.init(frame: .zero)
        self.style = style
        self.type = type
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setDate(days: [String], today: String) {
        self.days = days
        self.today = today
        collection.reloadData()
    }
    
    func setStyle(style: StyleCalendar, type: CornerType) {
        self.style = style
        self.type = type

        collection.reloadData()
    }
    
    private func setup() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10

        collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        addSubview(collection)
        collection.register(WeekCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        collection.semanticContentAttribute = .forceRightToLeft
    }
    
    private func setData(at index: Int) {
        for i in 1..<(index + 1) {
            days.append(String(i))
        }
        collection.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collection.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        width = frame.width
        collection.reloadData()
    }
}

extension DaysCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeekCell
        let num = days[indexPath.row]
        let isToday = num == today
        cell.config(text: num, style: style, type: type, isToday: isToday)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = width / 9
        return CGSize(width: w, height: w)
    }
}
