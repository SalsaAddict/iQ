import UIKit

class iQEmailCell: iQTextCell {
    
    override class var reuseIdentifier: String { get { return "iQEmailCell" } }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        self.textField.autocorrectionType = .No
        self.textField.autocapitalizationType = .None
        self.textField.keyboardType = .EmailAddress
    }

    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}