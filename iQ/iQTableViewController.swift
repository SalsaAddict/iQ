import UIKit

class iQTableViewController: UITableViewController {
    
    var fields: iQFields!, showValidationErrors: Bool = false
    
    init(fields: iQFields) {
        super.init()
        self.fields = fields
    }
    
    override init(style: UITableViewStyle) { super.init(style: style) }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) { super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil) }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        self.tableView.separatorStyle = .None
        self.tableView.registerClass(iQTextCell.self, forCellReuseIdentifier: iQTextCell.reuseIdentifier)
        self.tableView.registerClass(iQEmailCell.self, forCellReuseIdentifier: iQEmailCell.reuseIdentifier)
        self.tableView.registerClass(iQSegmentedCell.self, forCellReuseIdentifier: iQSegmentedCell.reuseIdentifier)
        self.tableView.registerClass(iQSwitchCell.self, forCellReuseIdentifier: iQSwitchCell.reuseIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fields.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var field = self.fields[indexPath.row]
        var cell: iQCell
        switch field.type {
        case .Text: cell = tableView.dequeueReusableCellWithIdentifier(iQTextCell.reuseIdentifier, forIndexPath: indexPath) as iQTextCell
        case .Email: cell = tableView.dequeueReusableCellWithIdentifier(iQEmailCell.reuseIdentifier, forIndexPath: indexPath) as iQEmailCell
        case .Segmented: cell = tableView.dequeueReusableCellWithIdentifier(iQSegmentedCell.reuseIdentifier, forIndexPath: indexPath) as iQSegmentedCell
        case .Switch: cell = tableView.dequeueReusableCellWithIdentifier(iQSwitchCell.reuseIdentifier, forIndexPath: indexPath) as iQSwitchCell
        default: abort() // TODO: Remove
        }
        cell.assignField(&field, showValidationErrors: self.showValidationErrors)
        return cell
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows()!, withRowAnimation: .Automatic)
    }
    
    func validate() -> Bool {
        if self.fields.validate() { return true }
        else {
            UIAlertView(title: "Required Information", message: "Please complete all the questions highlighted in red.", delegate: nil, cancelButtonTitle: "OK").show()
            self.showValidationErrors = true
            tableView.reloadRowsAtIndexPaths(tableView.indexPathsForVisibleRows()!, withRowAnimation: .Automatic)
            return false
        }
    }
    
}