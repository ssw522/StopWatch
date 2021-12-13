//
//  SettingTableViewcontroller.swift
//  StopWatch
//
//  Created by 신상우 on 2021/04/26.
//

import UIKit

class SettingViewController: UIViewController {
    //MARK: Properties
    
    //MARK: deInit
    deinit {
        print("SettingTalbeViewController deinit")
    }
    
    //MARK:Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    func configure() {
        self.view.backgroundColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Setting"
    }

    func layOut(){

    }
    
    //MARK: Selector

}
