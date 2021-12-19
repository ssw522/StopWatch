//
//  StopWatchViewController.swift
//  StopWatch
//
//  Created by 신상우 on 2021/03/29.
//

import UIKit
import CoreMotion
import RealmSwift

class StopWatchViewController: UIViewController {
    //MARK: Properties
    let realm = try! Realm()
    let palette = Palette()
    var saveDate = "" {
        didSet{
            self.setGoalTime()
            self.setTimeLabel()
        }
    }
    var totalTime: TimeInterval = 0
    var totalGoalTime: TimeInterval = 0
    var motionManager: CMMotionManager?
    var concentraionTimerVC: ConcentrationTimeViewController?
    var editListView: EditTodoListView?
    var startDate: TimeInterval?
    var editGoalTimeView: EditGoalTimeView?
    var circleGraphView: CircleGraphView?
    var calendarView: CalendarView?
    var cellYPosition:CGFloat?
    var tapGesture: UITapGestureRecognizer?
    var tapView: UIView?
    
    let titleView: TitleView = {
        let view = TitleView()
        view.label.text = (UIApplication.shared.delegate as! AppDelegate).saveDate
        
        return view
    }()

    let goalTimeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
//
    lazy var goalTimeTitle: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.image = UIImage(systemName: "flag.fill")
        view.tintColor = .darkGray
        self.goalTimeView.addSubview(view)

        return view
    }()

    lazy var goalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = " 00 : 00"
        label.textColor = .darkGray
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .light)
        self.goalTimeView.addSubview(label)

        return label
    }()
    
    lazy var goalTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        self.goalTimeView.addSubview(button)
//        button.setTitle("SET", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(self.openGoalTimeEditVC(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let frameView: UIView = {
        let view = UIView()
        view.backgroundColor = .standardColor
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let barView: DrawBarView = {
        let view = DrawBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let mainTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00 : 00"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = .black
        label.font = .systemFont(ofSize: 50, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .standardColor
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let subTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let chartViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customPurpleColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("chart", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 35
        button.setTitleShadowColor(.black, for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = .zero
        
        return button
    }()
    
    let toDoListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.font = UIFont(name: "Bradley Hand", size: 20)
        label.textColor = .darkGray
        label.text = " To do List"
        
        return label
    }()
    
    let toDoTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(TodoListCell.self, forCellReuseIdentifier: "cell")
        view.separatorStyle = .none
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    //MARK: Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configured()
        self.addSubView()
        self.layOut()
        self.addTarget()
        self.setNotificationCenter()
        self.toDoTableView.delegate = self
        self.toDoTableView.dataSource = self
        self.hideKeyboardWhenTapped()
        self.addObserverMtd()
        
        self.navigationItem.titleView = self.titleView
        let titleViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickCalendar(_:)))
        self.titleView.isUserInteractionEnabled = true
        self.titleView.addGestureRecognizer(titleViewTapGesture)
        
        print("path =  \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 프로퍼티 값 갱신
        self.saveDate = (UIApplication.shared.delegate as! AppDelegate).saveDate //오늘 날짜!
        self.totalTime = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)?.totalTime ?? 0
        self.totalGoalTime = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)?.totalGoalTime ?? 0
        
        self.setGoalTime()
        //persent,progress reload
        self.reloadProgressBar()
        self.setDeviceMotion()
        self.toDoTableView.reloadData()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = .standardColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        print("viewWillDisappear")
        self.motionManager?.stopDeviceMotionUpdates()
    }
   
    
    func getToday()->String{
        let today = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        let month = calendar.component(.month, from: today) as NSNumber
        let day = calendar.component(.day, from: today) as NSNumber
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        let monthFormat = formatter.string(from: month)!
        let dayFormat = formatter.string(from: day)!
        
        let result = "\(year). \(monthFormat). \(dayFormat)"
        
        return result
    }
    
    func reloadProgressBar(){
        self.barView.per =
            totalGoalTime != 0 ? Float(self.totalTime / totalGoalTime): 0
        self.barView.progressView.setProgress(self.barView.per, animated: true)
        self.barView.showPersent()
        
    }
    
    func setTimeLabel(){
        let dailyData = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        let time = dailyData?.totalTime ?? 0 // 오늘의 데이터가 없으면 0
        let (subSecond,second,minute,hour) = self.divideSecond(timeInterval: time)
        self.subTimeLabel.text = subSecond
        self.mainTimeLabel.text = "\(hour) : \(minute) :  \(second)"
    }
    
    func setGoalTime(){
        let dailyData = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        let goal = dailyData?.totalGoalTime ?? 0 // 오늘의 데이터가 없으면 0
        let (_,_,minute,hour) = self.divideSecond(timeInterval: goal)
        self.goalTimeLabel.text = " \(hour) : \(minute)"
    }
    
    func setSwipeGesture(){
        //차트뷰 아래로 내려서 닫기 제스쳐
        if let view = self.circleGraphView {
            let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
            downSwipe.direction = .down
            view.addGestureRecognizer(downSwipe)
        }
    }
    
    func setTapGesture(){
        if self.tapView == nil {
            self.tapView = UIView()
        }
        if let _tapView = self.tapView {
            _tapView.frame  = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.addSubview(_tapView)
            self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture(_:)))
            
            _tapView.addGestureRecognizer(self.tapGesture!)
        }
        
    }
    
    func zeroTimeAlert(){
        let alert = UIAlertController(title: "알 림", message: "측정된 시간이 없습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func openCircleGrpahView(){
        let filter = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        guard let segment = filter?.dailySegment else {
            self.zeroTimeAlert()
            return
        }
        
        let total = segment.reduce(0){
            (result,segment) in
            return segment.value + result
        }
        if total == 0 {
            self.zeroTimeAlert()
            return
        }
        self.circleGraphView = {
            let view = CircleGraphView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            return view
        }()
        
        self.view.addSubview(self.circleGraphView!)
        self.setSwipeGesture()
        
        NSLayoutConstraint.activate([
            self.circleGraphView!.topAnchor.constraint(equalTo: self.frameView.bottomAnchor),
            self.circleGraphView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.circleGraphView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.circleGraphView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.circleGraphView!.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
        UIView.animate(withDuration: 0.3){
            self.circleGraphView!.transform = .identity
        }
    }
    
    func closeCircleGrpahView(){
        if let modal = self.circleGraphView {
            UIView.animate(withDuration: 0.3 ,animations: {
                modal.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            }) {_ in
                modal.removeFromSuperview()
                self.circleGraphView = nil
            }
        }
    }
    
    //SetNavigationItem
    func setNavigationItem() {
        let categoryEditBarButtonItem: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(systemName: "list.star"), style: .plain, target: self, action: #selector(barButtonItemMethod(_:)))
            button.tintColor = .lightGray
            button.tag = 2
            
            return button
        }()

        self.navigationItem.leftBarButtonItems =  [categoryEditBarButtonItem]
    }
    
    //MARK: Selector
    @objc func respondToSwipeGesture(_ gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .down:
            self.closeCircleGrpahView()
        default:
            break
        }
    }
    
    @objc func proximityChangedMtd(sender: Notification){
        let isTrue = UIDevice.current.isProximityMonitoringEnabled
        if UIDevice.current.proximityState && isTrue {
        }else{
            self.setDeviceMotion()
        }
    }
    
    //목표 시간 설정 뷰 열기
    @objc func openGoalTimeEditVC(_ sender: UIButton) {
        guard self.editGoalTimeView == nil else { return } // 이미 객체가 생성되었으면 더 못생성되게 막기
        self.editGoalTimeView = EditGoalTimeView()
        
        self.editGoalTimeView!.frame.size = CGSize(width: self.view.frame.width - 80, height: 240)
        self.editGoalTimeView!.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height + 120)
        
        self.view.addSubview(editGoalTimeView!)
        self.editGoalTimeView!.cancelButton.addTarget(self, action: #selector(self.didFinishEditingGoalTime(_:)), for: .touchUpInside)
        self.editGoalTimeView!.okButton.addTarget(self, action: #selector(self.didFinishEditingGoalTime(_:)), for: .touchUpInside)
        StopWatchDAO().create(date: self.saveDate) // 오늘 데이터가 없으면 데이터 생성
        
        let dailyData = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)!
        let goal = dailyData.totalGoalTime
        let hourIndex = Int(goal / 3600) % 24 // 3600초 (1시간)으로 나눈 몫을 24로 나누면 시간 인덱스와 같다.
        let miniuteIndex = ((Int(goal) % 3600 ) / 60) / 5 // 남은 분을 5로 나누면 5분간격의 분 인덱스와 같다.
        print("hourIndex : \(hourIndex)")
        print("miniuteIndex : \(miniuteIndex)")
        self.editGoalTimeView!.timePicker.selectRow(hourIndex, inComponent: 0, animated: false) //시간초기값
        self.editGoalTimeView!.timePicker.selectRow(miniuteIndex, inComponent: 1, animated: false)//분초기값
        self.editGoalTimeView!.selectedMinute = TimeInterval(Int(goal) % 3600)
        self.editGoalTimeView!.selectedHour = goal - self.editGoalTimeView!.selectedMinute
        
        
        UIView.animate(withDuration: 0.3){
            self.editGoalTimeView!.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 130)
        }
    }
    // 목표 시간 설정 뷰 닫기
    @objc func didFinishEditingGoalTime(_ sender: UIButton){
        if sender.tag == 1 {
            let dailyData = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
            try! realm.write{
                dailyData!.totalGoalTime =
                    self.editGoalTimeView!.selectedHour + self.editGoalTimeView!.selectedMinute
            }
            self.reloadProgressBar() //
            self.setGoalTime()
            UIView.animate(withDuration: 0.3,animations: {
                self.editGoalTimeView!.frame.size = CGSize(width: self.view.frame.width - 80, height: 240)
                self.editGoalTimeView!.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height + 120)
            }){_ in
                self.editGoalTimeView!.removeFromSuperview()
                self.editGoalTimeView = nil
            }
           
        }
        
        if sender.tag == 2 {
            UIView.animate(withDuration: 0.3,animations: {
                self.editGoalTimeView!.frame.size = CGSize(width: self.view.frame.width - 80, height: 240)
                self.editGoalTimeView!.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height + 120)
            }){_ in
                self.editGoalTimeView!.removeFromSuperview()
                self.editGoalTimeView = nil
            }
        }
    }
    
    @objc func clickToChartButton(){
        if self.circleGraphView == nil {
            self.openCircleGrpahView()
        }else {
            self.closeCircleGrpahView()
        }
    }
    
    
    @objc func barButtonItemMethod(_ button: UIBarButtonItem){
        let settingVC = SettingViewController()
        let categoryVC = CategoryViewController()
        
        
        switch button.tag {
        case 1:
            self.navigationController?.pushViewController(settingVC, animated: true)
        case 2:
            self.navigationController?.pushViewController(categoryVC, animated: true)
        
        default:
            break;
        }
    }
    
    //세션(과목명)을 눌렀을때 호출되는 메소드
    @objc func clickedSection(_ sender: UIButton){
        StopWatchDAO().create(date: self.saveDate) // 오늘 데이터가 없으면 데이터 생성
        
        let dailyData = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)!
        let segments = dailyData.dailySegment // 오늘 과목들
        let section = sender.tag //section번째 과목 인덱스
        let toDoList = segments[section].toDoList // section번째 과목의 할 일들

        let row = toDoList.count // section번째 과목의 할 일 번호
        let indexPath = IndexPath(row: row, section: section )

        try! realm.write{
            toDoList.append("")
            segments[section].listCheckImageIndex.append(0)
        }

        self.toDoTableView.reloadData()
        self.toDoTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        
        let cell = self.toDoTableView.cellForRow(at:indexPath) as? TodoListCell
        
        cell?.getListTextField.becomeFirstResponder()
       
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//        let keyboardViewEndFrame = view.convert(keyboardFrame, from: view.window)
        let keyboardTopY = keyboardFrame.origin.y
        let toDoViewY = self.toDoTableView.frame.origin.y + self.navigationController!.navigationBar.frame.height
        let inset = keyboardTopY - toDoViewY + 10
        
        guard let cellY = self.cellYPosition else { return }
        if cellY >= keyboardTopY {
            self.toDoTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: inset, right:0)
        }else{
            self.toDoTableView.contentInset = .zero
        }
    }
    
    //탭 제스쳐를 감지하여 뷰를 닫는 액션함수
    @objc func respondToTapGesture(_ sender: Any){
        guard let _tapGesture = self.tapGesture else { return } // nil이면 그냥 종료
        self.view.removeGestureRecognizer(_tapGesture) // 제스쳐 제거
        //편집 뷰가 열려 있으면 편집 뷰 닫기
        if let editView = self.editListView {
            UIView.animate(withDuration: 0.3,animations: {
                editView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height + 40)
            }){ (_) in
                editView.removeFromSuperview() // 슈퍼뷰에서 제거!
                self.editListView = nil
            }
        }
        // 캘린더가 열려있으면 캘린더 닫기
        if let calendar = self.calendarView {
            calendar.delegate = nil
            self.calendarView = nil
            self.titleView.label.text = self.saveDate
            calendar.removeFromSuperview()
        }
        self.tapGesture = nil
        self.tapView?.removeFromSuperview()
        self.tapView = nil
    }
    
    //MARK: CalendarView method
    //캘린더 뷰 여는 메소드!
    @objc func clickCalendar(_ sender: Any){
        guard self.calendarView == nil else { return }
        self.calendarView = CalendarView()
        self.setTapGesture()
        
        if let calendar = self.calendarView {
            calendar.translatesAutoresizingMaskIntoConstraints = false
            calendar.delegate = self
            self.view.addSubview(calendar)
            calendar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            calendar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100).isActive = true
            calendar.widthAnchor.constraint(equalToConstant: self.view.frame.width - 60).isActive = true
            calendar.heightAnchor.constraint(equalToConstant: 280).isActive = true
        }
    }
    
    func clickDay(saveDate: String) {
        self.saveDate = saveDate
        self.toDoTableView.reloadData()
        
        if let calendar = self.calendarView {
            calendar.delegate = nil
            self.calendarView = nil
            self.titleView.label.text = self.saveDate
            calendar.removeFromSuperview()
        }
    }
}


extension StopWatchViewController {
    
    //MARK: Configured
    func configured() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.setNavigationItem()
       
    }
    
    //MARK: NotificationCenter
    func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(proximityChangedMtd(sender:)), name: UIDevice.proximityStateDidChangeNotification, object: nil)
       
    }
    
    func setDeviceMotion(){
        self.motionManager = CMMotionManager()
        self.motionManager?.deviceMotionUpdateInterval = 0.1;
        self.motionManager?.startDeviceMotionUpdates(to: .main){
            (motion, error) in
            
            //get proximity state!
            let proximityState = UIDevice.current.proximityState
            //get radian
            guard let attitude = motion?.attitude else{
                print("motion error")
                return }

            let radian = abs(attitude.roll * 180.0 / Double.pi) //코어 모션 회전각도!
            if radian >= 100{ //proxitmiysensor On
                UIDevice.current.isProximityMonitoringEnabled = true
               
                if radian >= 160 { // timer start
                    if proximityState == true {
                        if self.concentraionTimerVC != nil {
                            self.concentraionTimerVC!.openBlackView()
                        }else{
                            self.concentraionTimerVC = ConcentrationTimeViewController()
                            self.navigationController?.pushViewController(self.concentraionTimerVC!, animated: true)
                        }
//                        self.concentraionTimerVC!.startDate = Date().timeIntervalSince1970
                        self.motionManager?.stopDeviceMotionUpdates()
                        
                    }
                }
            }else if radian < 100 { //timer stop
                if proximityState == false {
                    UIDevice.current.isProximityMonitoringEnabled = false
                    if let timerVC = self.concentraionTimerVC{
                        timerVC.closeBlackView()
                    }
                }
            }
        }
    }
    //MARK: AddSubView
    func addSubView(){
        self.view.addSubview(self.frameView)
        self.view.addSubview(self.barView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.chartViewButton)
        self.view.addSubview(self.toDoListLabel)
        self.view.addSubview(self.goalTimeView)
        self.view.addSubview(self.toDoTableView)
        
        
        self.frameView.addSubview(self.mainTimeLabel)
        
        self.mainTimeLabel.addSubview(self.subTimeLabel)
    }
    
    //MARK: SetLayOut
    func layOut(){
        //Level 1
        NSLayoutConstraint.activate([
            self.frameView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.frameView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.frameView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.frameView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.frameView.leadingAnchor, constant: 15),
            self.titleLabel.topAnchor.constraint(equalTo: self.frameView.topAnchor, constant: 10),
            self.titleLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.5),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            self.chartViewButton.centerYAnchor.constraint(equalTo: self.frameView.bottomAnchor),
            self.chartViewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.chartViewButton.widthAnchor.constraint(equalToConstant: 70),
            self.chartViewButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            self.barView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            self.barView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.barView.heightAnchor.constraint(equalToConstant: 40),
            self.barView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            self.toDoListLabel.topAnchor.constraint(equalTo: self.chartViewButton.bottomAnchor, constant: 0),
            self.toDoListLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
            
        ])
        
        NSLayoutConstraint.activate([
            self.goalTimeView.widthAnchor.constraint(equalToConstant: 80),
            self.goalTimeView.heightAnchor.constraint(equalToConstant: 30),
            self.goalTimeView.bottomAnchor.constraint(equalTo: self.barView.topAnchor, constant: 0),
            self.goalTimeView.leadingAnchor.constraint(equalTo: self.barView.leadingAnchor, constant: -4),

            self.goalTimeLabel.topAnchor.constraint(equalTo: self.goalTimeView.topAnchor),
            self.goalTimeLabel.bottomAnchor.constraint(equalTo: self.goalTimeView.bottomAnchor),
            self.goalTimeLabel.trailingAnchor.constraint(equalTo: self.goalTimeView.trailingAnchor, constant: 6),
            self.goalTimeLabel.leadingAnchor.constraint(equalTo: self.goalTimeTitle.trailingAnchor),

            self.goalTimeTitle.centerYAnchor.constraint(equalTo: self.goalTimeView.centerYAnchor),
            self.goalTimeTitle.leadingAnchor.constraint(equalTo: self.goalTimeView.leadingAnchor),
            self.goalTimeTitle.widthAnchor.constraint(equalToConstant: 16),
            self.goalTimeTitle.heightAnchor.constraint(equalToConstant: 16),
            
            self.goalTimeButton.leadingAnchor.constraint(equalTo: self.goalTimeView.leadingAnchor),
            self.goalTimeButton.trailingAnchor.constraint(equalTo: self.goalTimeView.trailingAnchor),
            self.goalTimeButton.topAnchor.constraint(equalTo: self.goalTimeView.topAnchor),
            self.goalTimeButton.bottomAnchor.constraint(equalTo: self.goalTimeView.bottomAnchor)
            
        ])
       
        
        NSLayoutConstraint.activate([
            self.toDoTableView.topAnchor.constraint(equalTo: self.toDoListLabel.bottomAnchor, constant: 12),
            self.toDoTableView.bottomAnchor.constraint(equalTo: self.goalTimeView.topAnchor),
            self.toDoTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.toDoTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        //Level 2
        NSLayoutConstraint.activate([
            self.mainTimeLabel.centerYAnchor.constraint(equalTo: self.frameView.centerYAnchor),
            self.mainTimeLabel.centerXAnchor.constraint(equalTo: self.frameView.centerXAnchor),
            self.mainTimeLabel.leadingAnchor.constraint(equalTo: self.frameView.leadingAnchor, constant: 15),
            self.mainTimeLabel.trailingAnchor.constraint(equalTo: self.frameView.trailingAnchor, constant: -15),
            self.mainTimeLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        //Level 3
        NSLayoutConstraint.activate([
            self.subTimeLabel.centerYAnchor.constraint(equalTo: self.mainTimeLabel.centerYAnchor, constant: 3),
            self.subTimeLabel.leadingAnchor.constraint(equalTo: self.mainTimeLabel.centerXAnchor, constant: 135)
        ])
    }
    //MARK: AddTarget
    func addTarget(){
        self.chartViewButton.addTarget(self, action: #selector(self.clickToChartButton), for: .touchUpInside)
    }
    
    //MARK: AddObserver
    func addObserverMtd(){
        let notificationCenter = NotificationCenter.default
    
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
//        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
}


//MARK:- TabelView delegate datasource
extension StopWatchViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return realm.objects(Segments.self).count // 섹션 수 = 과목 수
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filter = realm.object(ofType: DailyData.self, forPrimaryKey: saveDate)
        let segment = filter?.dailySegment
        return segment?[section].toDoList.count ?? 0 // 오늘의 리스트가 없으면 0개
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let segment = realm.objects(Segments.self)
        
        let view = TodoListHeaderView()
//        let colorRow = SingleTonSegment.shared.segments[section].colorRow
        let colorRow = segment[section].colorRow
        let color = self.palette.paints[colorRow]
//        view.categoryNameLabel.text = SingleTonSegment.shared.segments[section].name
        view.categoryNameLabel.text = segment[section].name
        view.frameView.backgroundColor = color
    
        view.touchViewButton.tag = section
        view.touchViewButton.addTarget(self, action: #selector(self.clickedSection(_:)), for: .touchUpInside)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filter = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        let segment = filter!.dailySegment
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoListCell
        cell.saveDate = self.saveDate
        cell.getListTextField.tag = indexPath.section // 섹션구분 태그 이용
        cell.contentView.tag = indexPath.section
        cell.changeImageButton.tag = indexPath.row
        cell.getListTextField.delegate = self
        cell.getListTextField.isHidden = true
        cell.getListTextField.text = ""
        cell.listLabel.text = ""
        cell.checkImageView.image = nil
        cell.checkImageView.isHidden = true

        let colorRow = segment[indexPath.section].segment?.colorRow
        let color = self.palette.paints[colorRow!]
        let text = segment[indexPath.section].toDoList[indexPath.row]
        let checkImageIndex = segment[indexPath.section].listCheckImageIndex[indexPath.row]
        
        if text == ""{
            //테이블뷰에서의 셀 y 좌표 구하기
            let rectOfCellInTableView = tableView.rectForRow(at: indexPath)
            let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: view.window)
            self.cellYPosition = rectOfCellInSuperview.origin.y + rectOfCellInSuperview.height
            
            cell.getListTextField.isHidden = false
            cell.getListTextField.underLine.backgroundColor = color
            cell.getListTextField.attributedPlaceholder = NSAttributedString(string: "입력", attributes: [.foregroundColor: color])
        }else{
            cell.listLabel.text = text
            cell.lineView.backgroundColor = color
            cell.checkImageView.image = checkImage().images[checkImageIndex]
            cell.checkImageView.isHidden = false
            cell.getListTextField.isHidden = true
        }

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.editListView == nil else { return }
        
        self.editListView = EditTodoListView()
        if let _editListView = editListView {// 편집창 열기
            self.view.addSubview(_editListView)
            self.setTapGesture() // 외부 탭 하면 닫히는 제스쳐 추가
            // 각 버튼 액션메소드 추가
            _editListView.editButton.button.addTarget(self, action: #selector(self.editListMethod(_:)), for: .touchUpInside)
            _editListView.deleteButton.button.addTarget(self, action: #selector(self.editListMethod(_:)), for: .touchUpInside)
            let object = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
            let title = object?.dailySegment[indexPath.section].toDoList[indexPath.row] // list 불러오기
            
            _editListView.title.text = "' \(title!) '"
            _editListView.frame.size = CGSize(width: self.view.frame.width - 40, height: 90)
            _editListView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height + 45)
            UIView.animate(withDuration: 0.5){
                _editListView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 70)
            }
            _editListView.indexPath = indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

extension StopWatchViewController: UITextFieldDelegate {
    //입력이 끝나면 호출되는 델리게이트메소드
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let filter = realm.object(ofType: DailyData.self, forPrimaryKey: self.saveDate)
        let segment = filter!.dailySegment

        let row = segment[textField.tag].toDoList.count - 1
        
        if textField.text == "" {

            try! realm.write{
                segment[textField.tag].toDoList.remove(at: row)
                segment[textField.tag].listCheckImageIndex.remove(at: row)
            }
            
        }else {

            try! realm.write{
                segment[textField.tag].toDoList[row] = textField.text!
            }
        }
        self.toDoTableView.reloadData()
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let filter = realm.object(ofType: DailyData.self, forPrimaryKey: saveDate)
        let segment = filter!.dailySegment

        let row = segment[textField.tag].toDoList.count - 1
        let indexPath = IndexPath(row: row, section: textField.tag)
        self.toDoTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
}

//MARK:- editListMethod
extension StopWatchViewController {
    
    @objc func editListMethod(_ sender: UIButton){
        if let editView = self.editListView {
            let indexPath = editView.indexPath
            let segment = realm.object(ofType: DailyData.self, forPrimaryKey: saveDate)?.dailySegment
            var toDoList = segment?[indexPath!.section].toDoList[editView.indexPath!.row] // 이전텍스트 불러오기
            
            if sender.tag == 0 { // 수정버튼이면
                let alert = UIAlertController(title: "무엇으로 변경할까요?", message: nil, preferredStyle: .alert)
                alert.addTextField(){
                    $0.text = toDoList
                }
                alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                alert.addAction(UIAlertAction(title: "확인", style: .default){ (_) in
                    
                    try! self.realm.write{
                        segment?[indexPath!.section].toDoList[editView.indexPath!.row] = (alert.textFields?[0].text)!
                        
                    }
                    self.toDoTableView.reloadData()
                })
                self.present(alert, animated: false)
            }

            if sender.tag == 1 { // 삭제 버튼이면
                let alert = UIAlertController(title: nil, message: "정말 삭제 하시겠습니까?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                alert.addAction(UIAlertAction(title: "확안", style: .default){ (_) in
                    try! self.realm.write{
                        segment?[indexPath!.section].toDoList.remove(at: indexPath!.row) // 리스트 삭제
                        segment?[indexPath!.section].listCheckImageIndex.remove(at: indexPath!.row)
                        self.toDoTableView.reloadData()
                        
                    }
                })
                self.present(alert, animated: false)
            }
            
        }
      
    }
}
