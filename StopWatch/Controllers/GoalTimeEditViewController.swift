//
//  GoalTimeEditViewController.swift
//  StopWatch
//  For set and edit goaltime
//  Created by 신상우 on 2021/05/27.
//

import UIKit

class GoalTimeEditViewController: UIViewController {
    //MARK: Properties
    var selectedCellSection = 0
    var per:Float = 0
    var sectionIsOn: Set<Int> = []
    let palette = Palette()
    
    lazy var totalGoalTimeView: GoalTimeTotalView = {
        let view = GoalTimeTotalView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        self.view.addSubview(view)
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(GoalTimeTableViewCell.self, forCellReuseIdentifier: "GoalTimeCell")
        view.backgroundColor = .standardColor
        view.separatorStyle = .none
        self.view.addSubview(view)
        
        return view
    }()
    
    lazy var editGoalTime:EditGoalTimeView = {
        let view = EditGoalTimeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.okButton.addTarget(self, action: #selector(self.didFinishEditing(_:)), for: .touchUpInside)
        view.cancelButton.addTarget(self, action: #selector(self.didFinishEditing(_:)), for: .touchUpInside)
        
        return view
    }()
    
    //MARK: Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layOut()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setGoalTime(){
        let (_,_,minute,hour) = self.divideSecond(timeInterval: totalGoalTime)
        self.totalGoalTimeView.totalTimeLabel.text = "\(hour)시간 \(minute)분"
    }
    
    //MARK:Selector
    @objc func clickedSection(_ sender: UIButton){
        self.tableView.beginUpdates()
        if self.sectionIsOn.contains(sender.tag) {
            self.tableView.deleteRows(at: [IndexPath(row: 0, section: sender.tag)], with: .top)
            self.sectionIsOn.remove(sender.tag)
        }else {
            self.tableView.insertRows(at: [IndexPath(row: 0, section: sender.tag)], with: .top)
            self.sectionIsOn.insert(sender.tag)
            
        }
        self.tableView.endUpdates()
    }
    
    @objc func didFinishEditing(_ sender: UIButton){
        if sender.tag == 1 {
            SingleTonSegment.shared.segments[selectedCellSection].goal =
                self.editGoalTime.selectedHour + self.editGoalTime.selectedMinute
            self.tableView.reloadData()
            totalGoalTime = SingleTonSegment.shared.segments.reduce(0){
                $0 + $1.goal
            }
            self.editGoalTime.removeFromSuperview()
        }
        if sender.tag == 2 {
            self.editGoalTime.removeFromSuperview()
        }
        
        self.setGoalTime()
    }
    
    //MARK: Configure
    func configure(){
        self.view.backgroundColor = .standardColor
        
        self.navigationItem.title = "GoalTime"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.setGoalTime()
    }
    //MARK: Layout
    func layOut(){
        NSLayoutConstraint.activate([
            self.totalGoalTimeView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.totalGoalTimeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            self.totalGoalTimeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            self.totalGoalTimeView.heightAnchor.constraint(equalToConstant: 160),
            
            self.tableView.topAnchor.constraint(equalTo: self.totalGoalTimeView.bottomAnchor, constant: 20),
            self.tableView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor,constant: 18),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -18),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func layoutEditView(){
        self.view.addSubview(editGoalTime)
        NSLayoutConstraint.activate([
            self.editGoalTime.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.editGoalTime.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -20),
            self.editGoalTime.heightAnchor.constraint(equalToConstant: 240),
            self.editGoalTime.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
  
}
//MARK: Extension - tableview
extension GoalTimeEditViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.sectionIsOn.contains(section) {
            return 1
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTimeCell", for: indexPath) as! GoalTimeTableViewCell
        
        // read goal for selected category
        let goal = SingleTonSegment.shared.segments[indexPath.section].goal
        let (_,_,goalMinute,goalHour) = self.divideSecond(timeInterval: goal )
//        cell.goalSubValueLabel.text = goalSubSecond
        cell.goalValueLabel.text = "\(goalHour)시간 \(goalMinute)분"
        
        // read time for selected category
        let value = SingleTonSegment.shared.segments[indexPath.section].value
        let (_,_,currentMinute,currentHour) = self.divideSecond(timeInterval: value )
//        cell.currentSubValueLabel.text = currentSubSecond
        cell.currentValueLabel.text =
            "\(currentHour)시간 \(currentMinute)분"
        
        // get remaining time for selected category
        let remaining = goal - value
        let (_,_,minute,hour) = self.divideSecond(timeInterval: remaining )
//        cell.remainingTimeSubValueLabel.text = subSecond
        cell.remainingTimeValueLabel.text = "\(hour)시간 \(minute)분"
        
        cell.persentLabel.text = "touch!"
        cell.cellView.layer.cornerRadius = 10
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return SingleTonSegment.shared.segments.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.layoutEditView()
        self.selectedCellSection = indexPath.section
    }
    // set cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: GoalTimeTableHeaderViewInSection = {
            let view = GoalTimeTableHeaderViewInSection()
            let colorRow = SingleTonSegment.shared.segments[section].colorRow
            let color = self.palette.paints[colorRow]
            let name = SingleTonSegment.shared.segments[section].name
            let goal = SingleTonSegment.shared.segments[section].goal
            let value = SingleTonSegment.shared.segments[section].value
            
            view.colorView.backgroundColor = color
            view.nameLabel.text = name
            view.sectionClickedButton.tag = section
//            view.layer.shadowPath = UIBezierPath(rect:view.bounds).cgPath
//            view.layer.shouldRasterize = true
//            view.layer.rasterizationScale = UIScreen.main.scale
            
            view.sectionClickedButton.addTarget(self, action: #selector(clickedSection(_:)), for: .touchUpInside)
            
            //get persent for selected category
            self.per = goal != 0 ? Float(value / goal) : 0
            if per <= 1 {
            let persent = String(format:"%.2f",per * 100)
                view.persentLabel.text = "\(persent)%"
            }else {
                view.persentLabel.text = "100%"
            }
            
            return view
        }()
        
        return headerView
    }
    
}
