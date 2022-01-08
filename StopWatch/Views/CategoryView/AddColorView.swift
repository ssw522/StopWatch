//
//  AddColorView.swift
//  StopWatch
//
//  Created by 신상우 on 2022/01/08.
//

import UIKit
import RealmSwift

class AddColorView: UIView {
    var hexCode = 0
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "색상코드를 입력해주세요."
        
        return label
    }()
    
    let getColorCodeTextfield:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    let colorPreView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.darkGray.cgColor
    
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .red
        
//        button.layer.borderWidth = 1
        //        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addsubView()
        self.layout()
        self.addTarget()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("addViewDeinit")
    }
    
    func addsubView(){
        self.addSubview(self.guideLabel)
        self.addSubview(self.getColorCodeTextfield)
        self.addSubview(self.colorPreView)
        self.addSubview(self.addButton)
        self.addSubview(self.cancelButton)
    }
    
    func addTarget(){
        //글자 수를 제한하기 textfield에 액션 추가.
        self.getColorCodeTextfield.addTarget(self, action: #selector(self.didEditingChanged(_:)), for: .editingChanged)
        //닫기
        self.cancelButton.addTarget(self, action: #selector(self.closeView(_:)), for: .touchUpInside)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            self.guideLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.guideLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.getColorCodeTextfield.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 20),
            self.getColorCodeTextfield.leadingAnchor.constraint(equalTo: self.guideLabel.leadingAnchor),
            self.getColorCodeTextfield.widthAnchor.constraint(equalToConstant: 100),
            
            self.addButton.leadingAnchor.constraint(equalTo: self.getColorCodeTextfield.trailingAnchor, constant: 10),
            self.addButton.topAnchor.constraint(equalTo: self.getColorCodeTextfield.topAnchor),
            self.addButton.bottomAnchor.constraint(equalTo: self.getColorCodeTextfield.bottomAnchor),
            self.addButton.widthAnchor.constraint(equalToConstant: 40),
            
            self.colorPreView.topAnchor.constraint(equalTo: self.getColorCodeTextfield.bottomAnchor, constant: 14),
            self.colorPreView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            self.colorPreView.leadingAnchor.constraint(equalTo: getColorCodeTextfield.leadingAnchor),
            self.colorPreView.trailingAnchor.constraint(equalTo: self.addButton.trailingAnchor),
            
            self.cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.cancelButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 20),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    //글자 수 제한 메소드
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    // textfield값이 변할때마다 불리는 액션 함수
    @objc func didEditingChanged(_ tf: UITextField) {
        //글자 수 제한
        self.checkMaxLength(textField: self.getColorCodeTextfield, maxLength: 6)
        
        //색 미리보기
        if let hexCode = Int(tf.text ?? "", radix: 16) {
            self.addButton.tag = hexCode
            let preViewColor = uiColorFromHexCode(hexCode)
            self.colorPreView.backgroundColor = preViewColor
        }
    }
    
    // RealmDB에 저장되어 있는 16진수코드를 RGB로 뽑아 UIColor로 변환해주는 메소드
    func uiColorFromHexCode(_ hex:Int)->UIColor{
        let red = CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((hex & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat(hex & 0x0000FF) / 0xFF
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    //닫기
    @objc func closeView(_ sender: Any){
        self.removeFromSuperview()
    }
    
   

}
 
 
    

