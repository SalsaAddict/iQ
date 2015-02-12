import UIKit

class iQMoneyCell: iQTextCell {
    
    override class var reuseIdentifier: String { get { return "iQMoneyCell" } }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        self.textField.autocorrectionType = .No
        self.textField.autocapitalizationType = .None
        self.textField.keyboardType = .DecimalPad
        self.textField.textAlignment = .Right
        
        self.removeConstraints()
        self.addVisualConstraint("V:|-[label]-|")
        self.addVisualConstraint("V:|-[field]-|")
        self.addVisualConstraint("H:|-[label]-[field(==label)]-|")
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
