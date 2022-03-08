//
//  CalendarView.swift
//  StopWatch
//
//  Created by 신상우 on 2021/12/17.
//

import UIKit

class CalendarView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var calendarInfo: CalendarViewInfo = CalendarViewInfo()
    let dayArray = ["S","M","T","W","T","F","S"]
    var year = 0
    var month = 0
    var day = 0

    var delegate: StopWatchViewController?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        
        return label
    }()
   
    let collectionHeaderView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        
        return view
    }()
    
    let calendarView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true // 페이징 스크롤 처리
        
        return view
    }()
    
    let underLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.alpha = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.modelingInit()
        self.addSubView()
        self.layout()
        self.collectionHeaderView.delegate = self
        self.collectionHeaderView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.getToday()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Method
    func modelingInit(){
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width - 20 //화면 너비
        
        self.calendarInfo.cellSize = width / 7
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
    
    // CalendarMethod
    
    func isLeapYear(year: Int) -> Bool {
        if (year%4 == 0 && year%100 != 0) || year%400 == 0{
            return true //4로 떨어지고 100으로 안떨어지거나 400으로 떨어지면 윤년
        }else{ return false } //아니면 평년
    }

    func getFirstDay(year: Int, month: Int, day: Int) -> Int {
        let first = (year-1) / 400 // 400으로 떨어진건 무조건 윤년.
        let second = (year-1) / 100 - first //100으로 나눈 수는 평년 그러나 400으로 나눈건 윤년이니까 빼준다.
        let leapYear =  (year-1) / 4 - second // 4로 떨어진 수에 100으로 떨어진 수를 빼면 윤년
        var days = (year - 1) * 365 + leapYear + 1 // 1년 1월 1일 기준 월요일로 잡고 월요일값 1에 일 수 만큼 더한 후 7로 나누어 그 해 첫 요일 값을 구한다.
        
        var monthDay = 0
        
        for i in 1..<month {
            monthDay += getMonthDay(year: year, month: i)
        }
        days += monthDay

        return days % 7
    }

    func getMonthDay(year: Int, month: Int) -> Int {
        switch month {
        case 4 : fallthrough
        case 6 : fallthrough
        case 9 : fallthrough
        case 11 : return 30
            
        case 2 :
            if isLeapYear(year: year) {
                return 29
            }else { return 28 }
            
        default:
            return 31
        }
    }
    
    // 전체 셀 개수 구하기.
    func getNumberOfCell() -> Int{
        let startDay = self.getFirstDay(year: self.year, month: self.month, day: self.day)
        let day = self.getMonthDay(year: self.year, month: self.month)
        
        if startDay + day <= self.calendarInfo.numberOfItem{
            self.calendarInfo.heightNumberOfCell = 6
        }else {
            self.calendarInfo.heightNumberOfCell = 7
        }

        return self.calendarInfo.numberOfItem
    }
    
    //월마다 일 수 계산하여 날짜 표시하는 함수
    func presentCalendar(row: Int, cell:UICollectionViewCell){
        let cell = cell as! CalendarCell
        cell.frameView.backgroundColor = .white // 셀 배경 초기화
        
        let dayNumber = self.getFirstDay(year: self.year, month: self.month, day: self.day)
        let day = dayNumber + self.day
        // 해당 달의 첫 날짜(1일)에 해당하는 요일에 맞춰 달력 나타내기.
        if row >= dayNumber{
            if row >= self.getMonthDay(year: self.year, month: self.month) + dayNumber{
                cell.isUserInteractionEnabled = false
                cell.dateLabel.text = " " // 초과
            }else{
                cell.dateLabel.text = "\(row + 1 - dayNumber)"
               
                //선택된 셀 배경 바꾸기
                if day == (row + 1) {
                    cell.frameView.backgroundColor = .standardColor
                }
            }
        }else {
            cell.dateLabel.text = " "  // 미만
            cell.isUserInteractionEnabled = false
        }
    }
    
    //MARK: - setGesture
    
    //MARK: Selector
    
    //MARK: addsubview
    func addSubView(){
        self.addSubview(self.collectionHeaderView)
        self.addSubview(self.calendarView)
        self.addSubview(self.underLineView)
    }
    //MARK: addtarget
    
    //MARK: layout
    func layout(){
        NSLayoutConstraint.activate([
            self.collectionHeaderView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionHeaderView.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            self.calendarView.topAnchor.constraint(equalTo: self.collectionHeaderView.bottomAnchor),
            self.calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.underLineView.topAnchor.constraint(equalTo: self.calendarView.bottomAnchor, constant: 4),
            self.underLineView.leadingAnchor.constraint(equalTo: self.calendarView.leadingAnchor, constant: 14),
            self.underLineView.trailingAnchor.constraint(equalTo: self.calendarView.trailingAnchor, constant: -14),
            self.underLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    //MARK: - CollectionView Delegate,DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.calendarView {
            return self.getNumberOfCell()
        } else {
            return self.dayArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for:indexPath) as! CalendarCell
    
        if collectionView == self.calendarView {
            cell.isUserInteractionEnabled = true
            self.presentCalendar(row: indexPath.row, cell: cell)
            
            return cell
        }else {
            cell.isUserInteractionEnabled = false
            cell.dateLabel.textColor = .darkGray
            cell.dateLabel.text = self.dayArray[indexPath.row]
            if indexPath.row == 0 { cell.dateLabel.textColor = .red }
            if indexPath.row == 6 { cell.dateLabel.textColor = .blue }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.calendarView {
            let row = indexPath.row
            let dayNumber = self.getFirstDay(year: self.year, month: self.month, day: self.day)
            
            let day = self.returnString(row + 1 - dayNumber)
            let month = self.returnString(self.month)
            let year = self.year
            let string = "\(year).\(month).\(day)"
            self.day = Int(day)!
            self.calendarView.reloadData()
            self.delegate?.clickDay(saveDate: string)
        }
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    //뷰 크기 리턴
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(
                width: self.calendarInfo.cellSize!,
                height: 34
                )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

