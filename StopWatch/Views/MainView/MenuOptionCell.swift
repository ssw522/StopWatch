//
//  MenuOptionCell.swift
//  StopWatch
//
//  Created by 신상우 on 2022/03/13.
//

import UIKit

class MenuOptionCell: UITableViewCell{
    //MARK: - Properties
    let menuImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let menuTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "Sample text"
        
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .standardColor
        
        self.addSubview(self.menuImageView)
        self.addSubview(self.menuTitleLabel)
        
        NSLayoutConstraint.activate([
            self.menuImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.menuImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.menuImageView.heightAnchor.constraint(equalToConstant: 24),
            self.menuImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            self.menuTitleLabel.leadingAnchor.constraint(equalTo: self.menuImageView.trailingAnchor, constant: 16),
            self.menuTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
}
