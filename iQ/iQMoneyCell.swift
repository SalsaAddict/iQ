//
//  iQMoneyCell.swift
//  iQ
//
//  Created by Jonathan Clarke on 12/02/2015.
//  Copyright (c) 2015 Pierre Henry. All rights reserved.
//

import UIKit

class iQMoneyCell: iQTextCell {
    
    override class var reuseIdentifier: String { get { return "iQMoneyCell" } }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        self.textField.autocorrectionType = .No
        self.textField.autocapitalizationType = .None
        self.textField.keyboardType = UIKeyboardType.NumbersAndPunctuation
        self.textField.textAlignment = NSTextAlignment.Right
    }
    
    required init(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}