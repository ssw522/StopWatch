//
//  CategoryEditViewController.swift
//  StopWatch
//
//  Created by 신상우 on 2021/04/26.
//

import UIKit

class CategoryViewController: UIViewController {
    //MARK: Properties
    let palette = Palette()
    var saveDate = ""
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
        self.view.addSubview(view)
        view.separatorStyle = .none
        view.backgroundColor = .white
        if #available(iOS 15, *) {
            view.sectionHeaderTopPadding = 0
        }

        return view
    }()
    
    lazy var addCategoryBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addBarButtonItemMtd))
        button.tintColor = .lightGray
        
        return button
    }()
    
    //MARK: Init
    deinit {
        print("CategoryEditViewController Deinit")
    }
    
    //MARK: Method
    override func viewDidLoad(){
        super.viewDidLoad()
        self.configure()
        self.layOut()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.hideKeyboardWhenTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.saveDate = (UIApplication.shared.delegate as! AppDelegate).saveDate
        StopWatchDAO().create(date: (UIApplication.shared.delegate as! AppDelegate).saveDate)
        self.tableView.reloadData()
        
        self.navigationController?.navigationBar.isHidden = false
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()    // 불투명하게
            appearance.backgroundColor = .white
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance    // 동일하게 만들기
        }else {
            self.navigationController?.navigationBar.barTintColor = .white
        }
    }
    
    
    
    //MARK: Configure
    func configure(){
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = addCategoryBarButtonItem
        self.navigationItem.title = "Category"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    //MARK: LayOut
    func layOut(){
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    //MARK: Selector
    @objc func addBarButtonItemMtd(){
        let editVC = EditCategoryViewController()
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}
//MARK: TableViewDelegate
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let segment = realm.objects(Segments.self)
        return segment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
       
        let filter = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        let segment = filter!.dailySegment
        let value = segment[indexPath.row].value ?? 0
        let colorRow = segment[indexPath.row].segment?.colorRow ?? realm.objects(Segments.self)[indexPath.row].colorRow
        let name = segment[indexPath.row].segment?.name ?? realm.objects(Segments.self)[indexPath.row].name

        let (subSecond,second,minute,hour) = self.divideSecond(timeInterval: value )

        
        cell.nameLabel.text = name
        cell.colorView.backgroundColor = self.palette.paints[colorRow]
        cell.subValueLabel.text = subSecond
        cell.valueLabel.text = "\(hour) : \(minute) :  \(second)"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let filter = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
            if let todaySegment = filter?.dailySegment[indexPath.row]{
                try! realm.write{
                    realm.delete(todaySegment)
                }
            }
            let segment = realm.objects(Segments.self)[indexPath.row]
            
            try! realm.write{
                realm.delete(segment)
            }
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editVC = EditCategoryViewController()
        let segment = realm.objects(Segments.self)
        self.navigationController?.pushViewController(editVC, animated: true)
        editVC.selectedSegmentRow = indexPath.row
//        editVC.getNameTextField.text = SingleTonSegment.shared.segments[indexPath.row].name
//        editVC.selectedColorRow = SingleTonSegment.shared.segments[indexPath.row].colorRow
        editVC.getNameTextField.text = segment[indexPath.row].name
        editVC.selectedColorRow = segment[indexPath.row].colorRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return PreView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height * 0.3
    }
    
}


    
