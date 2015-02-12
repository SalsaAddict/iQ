import UIKit
import CoreData

class ReceiptDetail: iQTableViewController {
    
    var receipt: NSManagedObject?
    
    init(receipt: NSManagedObject?) {
        var fields: iQFields
        if receipt != nil { fields = iQFields(data: receipt!.valueForKey("data") as NSData) }
        else {
            fields = iQFields()
            fields.append("Forename", type: .Text, required: true)
            fields.append("Surname", type: .Text, required: true)
            fields.append("Email Address", type: .Email, required: true)
            fields.append("Accommodation Included", type: .Switch, value: true, required: false)
            fields.append("Dining Included", type: .Switch, value: true, required: false)
            fields.append("Currency", type: .Segmented, options: ["GBP", "EUR"], required: true)
        }
        super.init(fields: fields)
        if receipt != nil { self.receipt = receipt }
    }
    
    override init(style: UITableViewStyle) { super.init(style: style) }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) { super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil) }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        if receipt == nil { self.title = "New Receipt" } else { self.title = receipt!.valueForKey("title") as? String }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveReceipt:")
    }
    
    func saveReceipt(button: UIBarButtonItem) {
        if self.validate() {
            if self.receipt == nil { self.receipt = ReceiptObjectModel.entityInstance("Receipt") }
            let title: String = "\(self.fields[0].value!) \(self.fields[1].value!)"
            receipt!.setValue(title, forKey: "title")
            receipt!.setValue(NSDate(), forKey: "dateCreated")
            receipt!.setValue(NSDate(), forKey: "dateUpdated")
            receipt!.setValue(self.fields.data, forKey: "data")
            ReceiptObjectModel.save()
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}