//
//  MenuViewController.swift
//  StopWatch
//
//  Created by 신상우 on 2022/03/13.
//

import UIKit

class MenuViewController: UIViewController {
    //MARK: - Properties
    var delegate: StopWatchVCDelegate?
    
    let menuTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.standardColor.cgColor
        view.layer.borderWidth = 1
        view.register(MenuOptionCell.self, forCellReuseIdentifier: "MenuOptionCell")
        
        return view
    }()
    
    //MARK: - Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        
        self.view.addSubview(self.menuTableView)
        NSLayoutConstraint.activate([
            self.menuTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.menuTableView.widthAnchor.constraint(equalToConstant: 140),
            self.menuTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.menuTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    //MARK: - Selector
}

extension MenuViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionCell", for: indexPath) as! MenuOptionCell
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.menuTitleLabel.text = menuOption?.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.handleMenuToggle(menuOption: MenuOption(rawValue: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "Menu"
        label.font = .systemFont(ofSize: 28)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 100, width: 140, height: 40)
        
        let lineView = UIView()
        lineView.frame = CGRect(x: 10, y: 199, width: 120, height: 1)
        lineView.backgroundColor = .darkGray
        
        view.addSubview(label)
        view.addSubview(lineView)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
