//
//  CalendarHeaderView.swift
//  SWCalendar
//
//  Created by 신상우 on 2021/08/31.
//

import UIKit

class CalendarHeaderView:UICollectionReusableView,UICollectionViewDelegate,UICollectionViewDataSource {
    let dayArray = ["일","월","화","수","목","금","토"]
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .blue
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.addSubView()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView(){
        self.addSubview(self.collectionView)
    }
    
    func layout(){
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    //Delegate,Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        cell.dateLabel.font = .systemFont(ofSize: 14, weight: .thin)
        cell.dateLabel.text = self.dayArray[indexPath.row]
        
        return cell
    }
    
}
extension CalendarHeaderView: UICollectionViewDelegateFlowLayout {
    //뷰 크기 리턴
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(
                width: 44,
                height: 44
                )
    }
    //셀 간의 좌우 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //셀 간의 상하 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
