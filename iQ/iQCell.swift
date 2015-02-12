import UIKit

class iQCell: UITableViewCell {
    
    class var reuseIdentifier: String { get { return "iQCell" } }
    
    var viewsDictionary: [String: AnyObject] = [:]
    
    let label: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.label.textColor = self.tintColor
        self.label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.label.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.viewsDictionary["label"] = self.label
        self.contentView.addSubview(self.label)
    }

    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        println("prepeareFroReuse")
        self.label.text = nil
        self.label.textColor = self.tintColor
    }
    
    func addVisualConstraint(format: String) {
        self.contentView.addConstraints(NSLayoutConstraint
            .constraintsWithVisualFormat(format,
            options: .allZeros, metrics: nil,
            views: self.viewsDictionary))
    }
    
    private var _field: iQField?
    func assignField(inout field: iQField, showValidationErrors: Bool) {
        self._field = field
        self.label.text = field.label
        if showValidationErrors && field.required && (field.value == nil) {
            self.label.textColor = UIColor.redColor()
        }
        else {
            self.label.textColor = self.tintColor
        }
    }

    func setFieldValue(value: AnyObject?) {
        self._field?.value = value?
    }
    
}