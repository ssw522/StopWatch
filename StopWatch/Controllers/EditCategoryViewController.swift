//
//  EditCategoryViewController.swift
//  StopWatch
//
//  Created by 신상우 on 2021/09/14.
//
import UIKit

class EditCategoryViewController: UIViewController {
    let palette = Palette()
    var selectedColorRow: Int?
    var selectedSegmentRow: Int?
    var saveDate:String = ""
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.text = "Name"
        
        return label
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.text = "Palette"

        return label
    }()
    
    lazy var getNameTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 18, weight: .light)
        tf.textColor = .black
        tf.underLine.backgroundColor = .black
        
        return tf
    }()
    
    let paletteView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PaltteCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        
        return view
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.tag = 1
        
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.tag = 2
    
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let border = CALayer()
        self.getNameTextField.layer.addSublayer(border)
        self.addSubView()
        self.layout()
        self.addTarget()
        self.paletteView.delegate = self
        self.paletteView.dataSource = self
        self.navigationItem.hidesBackButton = true
        self.hideKeyboardWhenTapped()
        self.navigationItem.title = "category"
        self.saveDate = (UIApplication.shared.delegate as! AppDelegate).saveDate
    }
    
    func openAlert(){
        let alert = UIAlertController(title: "경 고", message: "색과 이름을 모두 입력해주세요.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func date() -> String{
        let date = DateFormatter()
        date.locale = Locale(identifier: Locale.current.identifier)
        date.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        date.dateFormat = "YYYY. MM. dd"
        
        return date.string(from: Date())
    }
    
    func addCategoryMtd(){
        guard let row = self.selectedColorRow else { // 색을 정했는지 검사 안했으면 경고창 띄우기
            self.openAlert()
            return
        }
        
        guard let name = self.getNameTextField.text else { // 과목명을 입력했는지 검사 안했으면 경고창 띄우기
            self.openAlert()
            return
        }
        
        if name == ""{
            self.openAlert() // 과목명을 빈칸으로 둬도 경고창!
        }else{
            StopWatchDAO().addSegment(row: row, name: name, date: self.saveDate) // 과목을 DB에 추가하는 메소드
            
            self.navigationController?.popViewController(animated: true) // 전 뷰로 돌아가기
        }
    }
    
    func editCategoryMtd(){
        guard let row = self.selectedColorRow else {
            self.openAlert()
            return
        }
        
        guard let name = self.getNameTextField.text else {
            self.openAlert()
            return
        }
        
        if name == ""{
            self.openAlert()
        }else{
            let segment = realm.objects(Segments.self)
            try! realm.write{
                segment[selectedSegmentRow!].name = name
                segment[selectedSegmentRow!].colorRow = row
                
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    //MARK: addSubView,AddTarget
    
    func addSubView(){
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.getNameTextField)
        self.view.addSubview(self.colorLabel)
        self.view.addSubview(self.paletteView)
        self.view.addSubview(self.okButton)
        self.view.addSubview(self.cancelButton)
    }
    
    func addTarget(){
        self.okButton.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
    }
    
    //MARK: Selector
    @objc func buttonTapped(button: UIButton){
        switch button.tag{
        case 1:
            if let _ = self.selectedSegmentRow{
                self.editCategoryMtd() //선택된 세그먼트로우가 있으면 편집
            }else{
                self.addCategoryMtd() // 없으면 새로 추가.
            }
           
        case 2:
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    //MARK: layout
    func layout(){
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22)
        ])
        
        NSLayoutConstraint.activate([
            self.getNameTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
            self.getNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
            self.getNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
            self.getNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            self.colorLabel.topAnchor.constraint(equalTo: self.getNameTextField.bottomAnchor, constant: 22),
            self.colorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22)
        ])
        
        NSLayoutConstraint.activate([
            self.paletteView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
            self.paletteView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
            self.paletteView.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 10),
            self.paletteView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        NSLayoutConstraint.activate([
            self.okButton.topAnchor.constraint(equalTo: self.paletteView.bottomAnchor, constant: 14),
            self.okButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -34),
            self.okButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            self.cancelButton.topAnchor.constraint(equalTo: self.paletteView.bottomAnchor, constant: 14),
            self.cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 34)
        ])
    
    }
}
//MARK:- CollectionView Delegate , datasource
extension EditCategoryViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.palette.paints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PaltteCell
        cell.paintView.backgroundColor = self.palette.paints[indexPath.row]
        //선택된 셀이면 체크마크!
        cell.checkImageView.isHidden = true
        if let row = self.selectedColorRow {
            if indexPath.row == row {
                cell.checkImageView.isHidden = false
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedColorRow = indexPath.row
        collectionView.reloadData()
    }

}
extension EditCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(
                width: 54,
                height: 54
                )
    }
}

//MARK:- UITextFieldDelegate
extension CategoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
