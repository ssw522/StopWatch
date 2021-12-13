//
//  CustomListEditView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/13.
//

import UIKit

class CustomListEditView: UIView {
    let buttonSize: CGFloat = 40
    
    lazy var button: UIButton = { // 수정 버튼
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = self.buttonSize / 2
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .light)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.tintColor = .darkGray
        
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.button)
        self.addSubview(self.label)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.topAnchor),
            self.button.widthAnchor.constraint(equalToConstant: self.buttonSize),
            self.button.heightAnchor.constraint(equalToConstant: self.buttonSize),
            self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 4),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
    
}
