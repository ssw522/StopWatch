//
//  MenuOptionCell.swift
//  StopWatch
//
//  Created by 신상우 on 2022/03/13.
//

import UIKit

class MenuOptionCell: UITableViewCell{
    //MARK: - Properties
    let menuTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize:16)
        label.text = "Sample text"
        
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        self.addSubview(self.menuTitleLabel)
        NSLayoutConstraint.activate([
            self.menuTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.menuTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
}
