//
//  EditTodoListView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/14.
//

import UIKit

class EditTodoListView: UIView{
    var indexPath: IndexPath? // 선택한 리스트의 IndexPath를 받아올 프로퍼티
    let buttonSize: CGFloat = 60
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var editButton: CustomListEditView = { // 수정 버튼
       let view = CustomListEditView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.button.setImage(UIImage(systemName: "pencil"), for: .normal)
        view.label.text = "수 정"
        view.button.tag = 0
        
        return view
    }()
    
    lazy var deleteButton: CustomListEditView = { // 삭제 버튼
        let view = CustomListEditView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.button.setImage(UIImage(systemName: "trash"), for: .normal)
        view.label.text = "삭 제"
        view.button.tag = 1
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 14
//        self.layer.shadowOpacity = 0.7
//        self.layer.shadowOffset = .zero
//        self.layer.shadowColor = UIColor.darkGray.cgColor
        
        self.addSubview(self.title)
        self.addSubview(self.editButton)
        self.addSubview(self.deleteButton)
        self.addTarget()
        self.layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget() {
        
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.editButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
            self.editButton.widthAnchor.constraint(equalToConstant: self.buttonSize),
            self.editButton.heightAnchor.constraint(equalToConstant: self.buttonSize),
            self.editButton.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 4)
        ])
        
        NSLayoutConstraint.activate([
            self.deleteButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 10),
            self.deleteButton.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 4),
            self.deleteButton.heightAnchor.constraint(equalToConstant: self.buttonSize),
            self.deleteButton.widthAnchor.constraint(equalToConstant: self.buttonSize)
        ])
    }

    
}
