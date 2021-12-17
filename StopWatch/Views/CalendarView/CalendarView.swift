//
//  CalendarView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/17.
//

import UIKit

class CalendarView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var calendarInfo: CalendarViewInfo = CalendarViewInfo()
    var year = 0
    var month = 0
    var day = 0
    var seletedCell:Int?
    var calendarViewHeightConstraint: NSLayoutConstraint?
    var delegate: StopWatchViewController?
    
    let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        
        return label
    }()
    
    let nextMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(">", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .thin)
        
        return button
    }()
    
    let previousMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("<", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .thin)
        
        return button
    }()
    
    let calendarView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        view.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.modelingInit()
        self.addSubView()
        self.layout()
        self.addTaget()
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.setGesture()
        self.getToday()
//        self.titleLabel.text = (UIApplication.shared.delegate as! AppDelegate).saveDate
        
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Method
    func modelingInit(){
        self.calendarInfo.cellSize = 44
        self.calendarInfo.heightNumberOfCell = 6
    }
    
    func getToday(){
        let today = Date()
        var calendar = Calendar.current
        calendar.timeZone = .current
        self.year = calendar.component(.year, from: today)
        self.month = calendar.component(.month, from: today)
        self.day = calendar.component(.day, from: today)
        self.titleLabel.text = "\(year)년 \(month)월"
    }
    
    func getNumberOfCell() -> Int{
        let startDay = getFirstDay(year: self.year, month: self.month, day: self.day)
        let day = getMonthDay(year: self.year, month: self.month)
        
        if startDay + day <= calendarInfo.numberOfItem{
            self.calendarInfo.heightNumberOfCell = 6
        }else {
            self.calendarInfo.heightNumberOfCell = 7
        }
//        self.calendarViewHeightConstraint?.isActive = false
//        self.calendarViewHeightConstraint = self.calendarView.heightAnchor.constraint(equalToConstant: self.calendarInfo.getCalendarViewHeight)
//        self.calendarViewHeightConstraint?.isActive = true
//        
        return self.calendarInfo.numberOfItem
    }
    
    func presentCalendar(row: Int, cell:UICollectionViewCell){
        let cell = cell as! CalendarCell
        let dayNumber = getFirstDay(year: self.year, month: self.month, day: self.day)
       
        if row >= dayNumber{
            if row >= getMonthDay(year: self.year, month: self.month) + dayNumber{
                cell.dateLabel.text = "*" // 미만
                cell.isUserInteractionEnabled = false
            }else{
                cell.dateLabel.text = "\(row + 1 - dayNumber)"
               
                //선택된 셀 배경 바꾸기
                if let selectedRow = seletedCell {
                    if selectedRow == row{
                        cell.frameView.backgroundColor = UIColor(red: 100/255, green: 150/255, blue: 255/255, alpha: 1.0)
                    }
                }
            }
        }else { // 초과
            cell.dateLabel.text = "*"
        }
    }
    //MARK: addsubview
    func addSubView(){
        self.addSubview(self.titleView)
        self.addSubview(self.calendarView)
        
        self.titleView.addSubview(self.titleLabel)
        self.titleView.addSubview(self.nextMonthButton)
        self.titleView.addSubview((self.previousMonthButton))
    }
    //MARK: addtarget
    func addTaget(){
        self.previousMonthButton.addTarget(self, action: #selector(self.respondToButton(_:)), for: .touchUpInside)
        self.nextMonthButton.addTarget(self, action: #selector(self.respondToButton(_:)), for: .touchUpInside)
    }
    //MARK: layout
    func layout(){
        NSLayoutConstraint.activate([
            self.titleView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleView.widthAnchor.constraint(equalToConstant: self.calendarInfo.getCalendarViewWidth),
            self.titleView.heightAnchor.constraint(equalToConstant: self.calendarInfo.cellSize!),
        ])
        
        NSLayoutConstraint.activate([
            self.calendarView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor),
            self.calendarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.calendarView.widthAnchor.constraint(equalToConstant: self.calendarInfo.getCalendarViewWidth),
            self.calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.titleView.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.previousMonthButton.trailingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor, constant: -10),
            self.previousMonthButton.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor),
            self.previousMonthButton.widthAnchor.constraint(equalToConstant: 40),
            self.previousMonthButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.nextMonthButton.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10),
            self.nextMonthButton.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor),
            self.nextMonthButton.widthAnchor.constraint(equalToConstant: 40),
            self.nextMonthButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    //MARK:- CollectionView Delegate,DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberOfCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! CalendarCell
        cell.frameView.backgroundColor = .white
        cell.isUserInteractionEnabled = true
        cell.dateLabel.font = .systemFont(ofSize: 16, weight: .thin)
        
        self.presentCalendar(row: indexPath.row, cell: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! CalendarHeaderView
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.seletedCell = indexPath.row
        let row = indexPath.row
        let dayNumber = getFirstDay(year: self.year, month: self.month, day: self.day)
        
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        let day = formatter.string(from: NSNumber(value: row + 1 - dayNumber))!
        let month = formatter.string(from: NSNumber(value: self.month))!
        let year = self.year
        let string = "\(year). \(month). \(day)"
        
        self.delegate?.clickDay(saveDate: string)
        collectionView.reloadData()
        
    }
    
    //MARK:- setGesture
    func setGesture(){
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture(_:)))
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        
        self.calendarView.addGestureRecognizer(rightSwipe)
        self.calendarView.addGestureRecognizer(leftSwipe)
    }
    
    //MARK: Selector
    @objc func respondToGesture(_ gesture: UISwipeGestureRecognizer){
        switch gesture.direction{
        case .right:
            if month == 1 {
                self.year -= 1
                self.month = 12
            }else{
            self.month -= 1
            }
            break
        case .left:
            if self.month == 12 {
                self.year += 1
                self.month = 1
            }else{
                self.month += 1
            }
            break
        default:
            return
        }
        self.seletedCell = nil
        self.titleLabel.text = "\(year)년 \(month)월"
        self.calendarView.reloadData()
    }
    
    @objc func respondToButton(_ button:UIButton){
        switch button {
        case self.previousMonthButton:
            if month == 1 {
                self.year -= 1
                self.month = 12
            }else{
            self.month -= 1
            }
            break
        case self.nextMonthButton:
            if self.month == 12 {
                self.year += 1
                self.month = 1
            }else{
                self.month += 1
            }
            break
        default:
            return
        }
        self.titleLabel.text = "\(year)년 \(month)월"
        self.calendarView.reloadData()
    }
    
}
extension CalendarView: UICollectionViewDelegateFlowLayout {
    //뷰 크기 리턴
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(
                width: self.calendarInfo.cellSize!,
                height: self.calendarInfo.cellSize!
                )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(
            width: self.calendarInfo.getCalendarViewWidth,
            height: self.calendarInfo.cellSize!)
    }

}

