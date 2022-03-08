//
//  TitleView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/16.
//
// StopWatchViewController의 NavigationBar CustomTitleView ( 날짜 )
import UIKit

class TitleView: UIView {
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.alignment = .fill
        
        return view
    }()
    
    let frameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Zapf Dingbats", size: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(self.stackView)
        self.stackView.addSubview(self.label)
        self.stackView.addSubview(self.frameView)
        
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor,constant: 10),
            self.label.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor)
        ])
        
        //스택뷰 최소골격?뷰
        NSLayoutConstraint.activate([
            self.frameView.leadingAnchor.constraint(equalTo: self.label.trailingAnchor),
            self.frameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.frameView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.frameView.widthAnchor.constraint(equalToConstant: 10),
            self.frameView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
