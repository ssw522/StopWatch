//
//  BlackViewController.swift
//  StopWatch
//
//  Created by 신상우 on 2021/08/23.
//

import UIKit

protocol TimerTriggreDelegate{
    func timerStop(_ startDate:TimeInterval)
}

class BlackViewController: UIViewController {
    var startDate: TimeInterval = 0
    var delegate: TimerTriggreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startDate = Date().timeIntervalSince1970
        self.generatePhone()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.timerStop(self.startDate)
    }
    
    func generatePhone(){
        let generator = UIImpactFeedbackGenerator(style:.heavy)
        generator.impactOccurred()
    }
    
}
