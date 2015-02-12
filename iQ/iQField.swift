import UIKit

enum iQFieldType: Int {
    case Text, Email, NumericText
    case Segmented
    case Switch
}

class iQField: NSObject, NSCoding {
    
    required init(coder aDecoder: NSCoder) {
        self._label = aDecoder.decodeObjectForKey("label") as String
        self._type = iQFieldType(rawValue: (aDecoder.decodeObjectForKey("type") as Int))!
        self._required = aDecoder.decodeObjectForKey("required") as Bool
        self.value = aDecoder.decodeObjectForKey("value")?
        self._options = aDecoder.decodeObjectForKey("options") as [String]?
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._label, forKey: "label")
        aCoder.encodeObject(self._type.rawValue, forKey: "type")
        aCoder.encodeObject(self._required, forKey: "required")
        aCoder.encodeObject(self.value, forKey: "value")
        aCoder.encodeObject(self._options, forKey: "options")
    }
    
    init(label: String, type: iQFieldType, required: Bool = false, value: AnyObject? = nil, options: [String]? = nil) {
        self._label = label
        self._type = type
        self._required = required
        self.value = value
        self._options = options
    }
    
    private var _label: String
    var label: String { get { return self._label } }
    
    private var _type: iQFieldType
    var type: iQFieldType { get { return self._type } }
    
    private var _required: Bool
    var required: Bool { get { return self._required } }
    
    var value: AnyObject? = nil
    
    private var _options: [String]?
    var options: [String]? { get { return self._options } }
    
    func validate() -> Bool {
        if self._required && self.value == nil { return false } else { return true }
    }
    
}