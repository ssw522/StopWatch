//
//  StopButtonTappedModalView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/04/15.
//

import UIKit

protocol StopModalViewDelegate {
    func closeModalView()
    func cancelModalView()
}
// ConcentrationViewController에서 확인 버튼 누를 때 나타나는 ModalView
class StopButtonTappedModalView: UIView {
    //MARK: Properties
    var delegate: StopModalViewDelegate?
    
    lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "알   림"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .customPurpleColor
        label.textAlignment = .center
        self.addSubview(label)
        
        return label
    }()
    
    lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        self.addSubview(label)
        
        return label
    }()
    
    lazy var aceptButton: UIButton = {
       let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .customPurpleColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
       let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .customPurpleColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        return button
    }()
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit!!")
    }
    
    //MARK: Method
    func configure(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.aceptButton.addTarget(self, action: #selector(aceptButtonTapped(sender:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func layout(){
        NSLayoutConstraint.activate([
            self.noticeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.noticeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.guideLabel.topAnchor.constraint(equalTo: self.noticeLabel.bottomAnchor, constant: 10),
            self.guideLabel.bottomAnchor.constraint(equalTo: self.aceptButton.topAnchor, constant: -10),
            self.guideLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.guideLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.guideLabel.heightAnchor.constraint(equalToConstant: 80)

        ])
        
        NSLayoutConstraint.activate([
            self.aceptButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.aceptButton.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: -30),
            self.aceptButton.widthAnchor.constraint(equalToConstant: 50),
            self.aceptButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            self.cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: 30),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 50),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    //MARK: Selector
    @objc func aceptButtonTapped(sender: UIButton){
        delegate?.closeModalView()
    }
    
    @objc func cancelButtonTapped(sender: UIButton){
        delegate?.cancelModalView()
    }
}
