//
//  drawBarView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/05/17.
//

import UIKit

class DrawBarView: UIView {
    //MARK: Properties
    var per: Float = 0
    
    lazy var persentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.textColor = .black
        label.textAlignment = .center
        self.addSubview(label)
        
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progressTintColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.position = CGPoint(x: 100, y: 200)
        view.progress = 0.0
        self.addSubview(view)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.progressViewStyle = .default
        
        return view
        
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Method
    func showPersent(){
        if per <= 1 {
        let persent = String(format:"%.2f",per * 100)
        self.persentLabel.text = "\(persent)%"
            
        }else {
            self.persentLabel.text = "100%"
        }
    }
    //MARK: configure
    
    //MARK: Layout
    func layOut(){
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.progressView.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            self.persentLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 10),
            self.persentLabel.heightAnchor.constraint(equalToConstant: 30),
            self.persentLabel.widthAnchor.constraint(equalToConstant: 65),
            self.persentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

    }
    
}
