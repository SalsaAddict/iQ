import UIKit
import CoreData

class ReceiptObjectModel: NSManagedObjectModel {
    
    override init() {
        super.init()
        let entity: NSEntityDescription = NSEntityDescription()
        entity.name = "Receipt"
        entity.properties.append(self.createAttribute("title", type: .StringAttributeType, optional: false, indexed: true))
        entity.properties.append(self.createAttribute("dateCreated", type: .DateAttributeType, optional: false, indexed: true))
        entity.properties.append(self.createAttribute("dateUpdated", type: .DateAttributeType, optional: false, indexed: true))
        entity.properties.append(self.createAttribute("data", type: .BinaryDataAttributeType, optional: false, indexed: false))
        self.entities.append(entity)
    }

    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func createAttribute(name: String, type: NSAttributeType, optional: Bool, indexed: Bool) -> NSAttributeDescription {
        let attribute: NSAttributeDescription = NSAttributeDescription()
        attribute.name = name
        attribute.attributeType = type
        attribute.optional = optional
        attribute.indexed = indexed
        return attribute
    }
    
    class func context() -> NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    }
    
    class func entityDescription(name: String) -> NSEntityDescription {
        return NSEntityDescription.entityForName(name, inManagedObjectContext: self.context())!
    }
    
    class func entityInstance(name: String) -> NSManagedObject {
        return NSManagedObject(entity: self.entityDescription(name), insertIntoManagedObjectContext: self.context())
    }
    
    class func save() {
        self.context().save(nil)
    }
    
}