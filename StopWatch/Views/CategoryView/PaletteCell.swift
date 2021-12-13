//
//  PaletteCell.swift
//  SWColorPickerView
//
//  Created by 신상우 on 2021/09/14.
//

import UIKit

class PaltteCell: UICollectionViewCell {
    let paintView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 23
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let checkImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        view.image = UIImage(systemName: "checkmark")
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView(){
        self.addSubview(self.paintView)
        
        self.paintView.addSubview(self.checkImageView)
    }
    
    
    func layout(){
        NSLayoutConstraint.activate([
            self.paintView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            self.paintView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            self.paintView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            self.paintView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -4)
        ])
        
        NSLayoutConstraint.activate([
            self.checkImageView.centerYAnchor.constraint(equalTo: self.paintView.centerYAnchor),
            self.checkImageView.centerXAnchor.constraint(equalTo: self.paintView.centerXAnchor),
            self.checkImageView.widthAnchor.constraint(equalToConstant: 20),
            self.checkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

