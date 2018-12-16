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
    fileprivate var calDays: [CalDate] = []
    private var width: CGFloat = 0
    private var style: StyleCalendar = .light
    private var type: CornerType = .circular
    private var today: CalDate!

    var delegate: Listener?

    init(style: StyleCalendar, type: CornerType, delegate: Listener?) {
        super.init(frame: .zero)
        self.style = style
        self.type = type
        self.delegate = delegate
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
    
    func setDate(calDays: [CalDate], today: CalDate) {
        self.calDays = calDays
        self.today = today
        collection.reloadData()
    }
    
    func setStyle(style: StyleCalendar, type: CornerType) {
        self.style = style
        self.type = type

        collection.reloadData()
    }
    
    func reload() {
        collection.reloadData()
    }
    
    private func setup() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        addSubview(collection)
        collection.register(WeekCell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.semanticContentAttribute = .forceRightToLeft
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collection.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        width = frame.width
    }
}

extension DaysCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeekCell
        let day = calDays[indexPath.row]
        let isToday: Bool
        
        isToday = day == today

        cell.config(calDate: day, style: style, type: type, isToday: isToday)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = width / 9
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = calDays[indexPath.row]
//        GlobalCalendar.selectedCal = day
        collection.reloadData()
        delegate?(day)
    }
}
