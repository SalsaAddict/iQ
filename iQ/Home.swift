import UIKit
import CoreData

class HomeCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.accessoryType = .DisclosureIndicator
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

class Home: UITableViewController, NSFetchedResultsControllerDelegate {

    var _fetchedResultsController: NSFetchedResultsController?
    var fetchedResultsController: NSFetchedResultsController {
        if self._fetchedResultsController == nil {
            let fetchRequest = NSFetchRequest(entityName: "Receipt")
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateUpdated", ascending: false)]
            self._fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: ReceiptObjectModel.context(),
                sectionNameKeyPath: nil, cacheName: nil)
            self._fetchedResultsController?.delegate = self
            self._fetchedResultsController?.performFetch(nil)
        }
        return self._fetchedResultsController!
    }
    
    override func viewDidLoad() {
        self.title = "Receipts"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: "newReceipt:")
        self.tableView.registerClass(HomeCell.self, forCellReuseIdentifier: "ReceiptCell")
    }
    
    func newReceipt(button: UIBarButtonItem) {
        self.navigationController?.pushViewController(ReceiptDetail(receipt: nil), animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReceiptCell") as! HomeCell
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        cell.textLabel?.text = item.valueForKey("title") as? String
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(item.valueForKey("dateUpdated") as! NSDate)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.navigationController?.pushViewController(ReceiptDetail(receipt: item), animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        ReceiptObjectModel.context().deleteObject(item)
        ReceiptObjectModel.context().save(nil)
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) { self.tableView.beginUpdates() }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Update:
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        default: return
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) { self.tableView.endUpdates() }
    
}