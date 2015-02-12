//
//  iQTests.swift
//  iQTests
//
//  Created by Pierre Henry on 11/02/2015.
//  Copyright (c) 2015 Pierre Henry. All rights reserved.
//

import UIKit
import XCTest

class iQTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testEmailRegex()
    {
        let regEx = iQField.EMAIL_REGEX() // : String = "^\\s*[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+\\s*$"
        var okemails = [ "jonathan@bitwix.com", "pierre@bm.museum", "ajc@xx..com", "ajc@..com", " ajc@xx.com ", ".@..com" ]
        var bademails = [ "", "@x@", "jonathan@bitwix!.com", " ajc @xx.com ", "x@.com" ]
        for email in okemails
        {
            let result = NSPredicate(format: "SELF MATCHES %@", regEx)!.evaluateWithObject( email )
            println( "\(email) \(result)")
            XCTAssertTrue( result, "Failed on " + email )
        }
        for email in bademails
        {
            let result = NSPredicate(format: "SELF MATCHES %@", regEx)!.evaluateWithObject( email )
            println( "\(email) \(result)")
            XCTAssertFalse( result, "Passed on " + email )
        }
        println( "\(okemails.count) ok checked")

        
    }
    
}
