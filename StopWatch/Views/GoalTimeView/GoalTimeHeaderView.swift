
import UIKit

class GoalTimeTableHeaderViewInSection: UIView {
    //MARK: Properties
    let SectionIsOn = false
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        
        self.addSubview(view)
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight:.light)
        label.textColor = .white
        self.cellView.addSubview(label)
        
        return label
    }()
    
    lazy var persentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .light)
        
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
        self.backgroundColor = .white
    }
    
    //MARK: LayOut
    func layOut() {
        NSLayoutConstraint.activate([
            self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -4),
            self.cellView.heightAnchor.constraint(equalToConstant: 30),
            self.cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            self.cellView.widthAnchor.constraint(equalToConstant: 160),
       
            self.nameLabel.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 10),

            self.persentLabel.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor),
            self.persentLabel.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor, constant: -20),
            
            self.sectionClickedButton.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor),
            self.sectionClickedButton.trailingAnchor.constraint(equalTo: self.cellView.trailingAnchor),
            self.sectionClickedButton.topAnchor.constraint(equalTo: self.cellView.topAnchor),
            self.sectionClickedButton.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor),
            
        ])
    }
}
