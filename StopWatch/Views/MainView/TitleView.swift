//
//  TitleView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/16.
//

import UIKit

class TitleView: UIView {
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "calendar")
        view.tintColor = .black
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(self.view)
        self.view.addSubview(self.label)
        self.view.addSubview(self.imageView)

        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.view.topAnchor.constraint(equalTo: self.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.view.widthAnchor.constraint(equalToConstant: 150),
            self.view.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.label.trailingAnchor, constant: 8),   
            self.imageView.widthAnchor.constraint(equalToConstant: 20),
            self.imageView.heightAnchor.constraint(equalToConstant: 20),
            self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
