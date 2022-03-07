//
//  CategoryCell.swift
//  StopWatch
//
//  Created by 신상우 on 2021/04/26.
//

import UIKit

class CategoryCell: UITableViewCell {
    //MARK: Properties
    
    var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
    
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        
        return label
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .darkGray
        
        return label
    }()
    
    var subValueLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .darkGray
        
        return label
    }()
    
    var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
        self.addSubView()
        self.layOut()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK: Method
    func configure(){
        self.backgroundColor = .white
    }
    
    func addSubView(){
        self.addSubview(self.cellView)
        
        self.cellView.addSubview(self.nameLabel)
        self.cellView.addSubview(self.valueLabel)
        self.cellView.addSubview(self.subValueLabel)
        self.cellView.addSubview(self.colorView)
    }
    
    func layOut() {
        NSLayoutConstraint.activate([
            self.cellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            self.cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 4),
            self.cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -4),
           
            self.nameLabel.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 4),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 20),
           
            self.valueLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.valueLabel.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor, constant: -2),
            self.valueLabel.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 20),
            
            self.subValueLabel.leadingAnchor.constraint(equalTo: self.valueLabel.trailingAnchor, constant: 5),
            self.subValueLabel.centerYAnchor.constraint(equalTo: self.valueLabel.centerYAnchor, constant: 1),
           
            self.colorView.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -30),
            self.colorView.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor),
            self.colorView.heightAnchor.constraint(equalToConstant: self.frame.height),
            self.colorView.widthAnchor.constraint(equalToConstant: self.frame.height)
        ])
    }
}
