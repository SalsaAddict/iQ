import UIKit

class iQSegmentedCell: iQCell {
    
    override class var reuseIdentifier: String { get { return "iQSegmentedCell" } }
    
    let segmentedControl: UISegmentedControl = UISegmentedControl()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        self.segmentedControl.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.viewsDictionary["segment"] = self.segmentedControl
        self.contentView.addSubview(self.segmentedControl)
        self.addVisualConstraint("V:|-[label]-|")
        self.addVisualConstraint("V:|-[segment]-|")
        self.addVisualConstraint("H:|-[label]-[segment(==label)]-|")
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.segmentedControl.removeAllSegments()
        self.segmentedControl.invalidateIntrinsicContentSize()
    }
    
    override func assignField(inout field: iQField, showValidationErrors: Bool) {
        super.assignField(&field, showValidationErrors: showValidationErrors)
        if field.options != nil {
            for index in 0...field.options!.count - 1 {
                self.segmentedControl.insertSegmentWithTitle(field.options![index], atIndex: index, animated: true)
            }
        }
        if field.value != nil { self.segmentedControl.selectedSegmentIndex = field.value! as! Int }
        self.segmentedControl.addTarget(self, action: "setValueWithSegmentedControl:", forControlEvents: .ValueChanged)
    }
    
    func setValueWithSegmentedControl(segmentedControl: UISegmentedControl) {
        self.setFieldValue(segmentedControl.selectedSegmentIndex)
    }
    
}