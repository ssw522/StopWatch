//
//  ModalView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/04/06.
//

import UIKit

class CircleGraphView: UIView {
    
    lazy var drawView: DrawView = {
        let view = DrawView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        self.addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layOut(frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layOut(_ frame: CGRect){
        NSLayoutConstraint.activate([
            self.drawView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            self.drawView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.drawView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.drawView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

