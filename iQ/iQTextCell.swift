import UIKit

class iQTextCell: iQCell {
    
    override class var reuseIdentifier: String { get { return "iQTextCell" } }

    let textField: UITextField = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        self.textField.clearButtonMode = .Always
        self.textField.borderStyle = .RoundedRect
        self.textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.viewsDictionary["field"] = self.textField
        self.contentView.addSubview(self.textField)
        self.addVisualConstraint("V:|-[label]-[field]-|")
        self.addVisualConstraint("H:|-[label]-|")
        self.addVisualConstraint("H:|-[field]-|")
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func prepareForReuse() {
        self.textField.text = nil
        self.textField.placeholder = nil
    }
    
    override func assignField(inout field: iQField, showValidationErrors: Bool) {
        super.assignField(&field, showValidationErrors: showValidationErrors)
        self.textField.placeholder = field.label
        self.textField.text = field.value as? String
        self.textField.addTarget(self, action: "setFieldValueWithTextField:", forControlEvents: .AllEditingEvents)
    }
    
    func setFieldValueWithTextField(textField: UITextField) {
        if textField.text.isEmpty { self.setFieldValue(nil) } else { self.setFieldValue(textField.text) }
    }
    
}