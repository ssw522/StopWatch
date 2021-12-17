//
//  CalendarCell.swift
//  SWCalendar
//
//  Created by 신상우 on 2021/08/30.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    //MARK: ProPerties
    let frameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubView()
        self.layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:Method
    func addSubView(){
        self.addSubview(self.frameView)
        
        self.frameView.addSubview(self.dateLabel)
    }
    
    func layout(){
        NSLayoutConstraint.activate([
            self.frameView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:  1),
            self.frameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -1),
            self.frameView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            self.frameView.topAnchor.constraint(equalTo: self.topAnchor, constant: 1)
        ])
        
        NSLayoutConstraint.activate([
            self.dateLabel.centerXAnchor.constraint(equalTo: self.frameView.centerXAnchor),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.frameView.centerYAnchor)
        ])
    }
    
}
