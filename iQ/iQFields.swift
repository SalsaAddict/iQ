import UIKit

class iQFields {
    
    private var _fields: [iQField]
    
    init() { self._fields = [] }
    
    init(data: NSData) {
        self._fields = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as! [iQField]
    }
    
    func append(label: String, type: iQFieldType, required: Bool = false, value: AnyObject? = nil, options: [String]? = nil) {
        self._fields.append(iQField(label: label, type: type, required: required, value: value, options: options))
    }
    
    var count: Int { get { return self._fields.count } }
    
    subscript(index: Int) -> iQField { return self._fields[index] }
    
    var data: NSData { return NSKeyedArchiver.archivedDataWithRootObject(self._fields) }
    
    func validate() -> Bool {
        var isValid: Bool = true
        for field in _fields {
            if !field.validate() {
                isValid = false
                break
            }
        }
        return isValid
    }
    
}