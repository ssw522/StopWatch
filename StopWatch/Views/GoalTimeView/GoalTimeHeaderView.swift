
import UIKit

class GoalTimeTableHeaderViewInSection: UIView {
    //MARK: Properties
    let SectionIsOn = false
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
//        view.layer.borderColor = UIColor.standardColor.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        
        self.addSubview(view)
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight:.regular)
        label.textColor = .black
        self.cellView.addSubview(label)
        
        return label
    }()
    
    lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.cellView.addSubview(view)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
            
        return view
    }()
    
    lazy var persentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        self.cellView.addSubview(label)
        
        return label
    }()
        
    lazy var sectionClickedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        self.cellView.addSubview(button)
        return button
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.layOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: Method
    func configure(){
        self.backgroundColor = .standardColor
    }
    
    //MARK: LayOut
    func layOut() {
        NSLayoutConstraint.activate([
            self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -4),
            self.cellView.heightAnchor.constraint(equalToConstant: 60),
            self.cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            self.cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            
            self.colorView.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 20),
            self.colorView.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor),
            self.colorView.heightAnchor.constraint(equalToConstant: 40),
            self.colorView.widthAnchor.constraint(equalToConstant: 40),
            
            self.nameLabel.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.colorView.trailingAnchor, constant: 10),

            self.persentLabel.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor),
            self.persentLabel.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -20),
            
            self.sectionClickedButton.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor),
            self.sectionClickedButton.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor),
            self.sectionClickedButton.topAnchor.constraint(equalTo: self.cellView.topAnchor),
            self.sectionClickedButton.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor),
            
        ])
    }
}
