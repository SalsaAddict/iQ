import UIKit

class iQSwitchCell: iQCell {
    
    override class var reuseIdentifier: String { get { return "iQSwitchCell" } }
    
    let switchControl: UISwitch = UISwitch()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        self.switchControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.viewsDictionary["switch"] = self.switchControl
        self.contentView.addSubview(self.switchControl)
        self.addVisualConstraint("V:|-[label]-|")
        self.addVisualConstraint("V:|-[switch]-|")
        self.addVisualConstraint("H:|-[label]-[switch]-|")
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func assignField(inout field: iQField, showValidationErrors: Bool) {
        super.assignField(&field, showValidationErrors: showValidationErrors)
        self.switchControl.on = field.value! as Bool
        self.switchControl.addTarget(self, action: "setValueWithSwitch:", forControlEvents: .ValueChanged)
    }
    
    func setValueWithSwitch(switchControl: UISwitch) {
        self.setFieldValue(switchControl.on)
    }
    
}