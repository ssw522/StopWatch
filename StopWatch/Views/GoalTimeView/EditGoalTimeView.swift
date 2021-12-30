//
//  EditGoalTimeView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/07/27.
//

import UIKit

class EditGoalTimeView: UIView {
    //MARK:Properties
    let hourArray = ["0시간","1시간","2시간","3시간","4시간","5시간","6시간","7시간","8시간",
                     "9시간","10시간","11시간","12시간","13시간","14시간","15시간","16시간"
                     ,"17시간","18시간","19시간","20시간","21시간","22시간","23시간"]
    
    let minuteArray = ["00분","05분","10분","15분","20분","25분","30분",
                       "35분","40분","45분","50분","55분"]
    
    var selectedHour:TimeInterval = 0
    var selectedMinute:TimeInterval = 0
    var goal: TimeInterval = 0 // 현재 목표시간 받아올 변수
    var dailyData: DailyData?
    
    lazy var timePicker:UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(picker)
        picker.setValue(UIColor.white, forKey: "textColor")
        
        return picker
    }()
    
    lazy var okButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .darkGray
        button.titleLabel?.textColor = .white
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
        self.addSubview(button)
        button.tag = 1
        
        return button
    }()
    
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .darkGray
        button.titleLabel?.textColor = .white
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
        self.addSubview(button)
        button.tag = 2
        
        return button
    }()
    
    //MARK:Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:Configure
    func configure(){
        self.backgroundColor = .white
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
    }
    
    //MARK:Method
    func getTimeinterval(text:String) -> TimeInterval {
        let newstring = text.filter { "0"..."9" ~= $0 }
        print(newstring)
        print(TimeInterval(newstring)!)
        return TimeInterval(newstring)!
    }
    
    //MARK:Selector
    
    //MARK:layOut
    func layout(){
        NSLayoutConstraint.activate([
            self.timePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.timePicker.topAnchor.constraint(equalTo: self.topAnchor),
            self.timePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -50),
        
            self.okButton.widthAnchor.constraint(equalToConstant: 65),
            self.okButton.heightAnchor.constraint(equalToConstant: 40),
            self.okButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40),
            self.okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            self.cancelButton.widthAnchor.constraint(equalToConstant: 65),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 40),
            self.cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 40),
            self.cancelButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
        
    }
}
extension EditGoalTimeView: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hourArray.count
        }else{
            return minuteArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return hourArray[row]
        }else{
            return minuteArray[row]
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            return NSAttributedString(string: hourArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }else {
            return NSAttributedString(string: minuteArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
    func initSelectedRow(){
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.selectedHour = getTimeinterval(text: hourArray[row]) * 60 * 60
        }else{
            self.selectedMinute = getTimeinterval(text: minuteArray[row]) * 60
        }
    }
}
