//
//  FKValidatorTests.swift
//  FKValidatorTests
//
//  Created by Kazuya Ueoka on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import XCTest
@testable import FKValidator

class FKValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidator() {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired())
        XCTAssertFalse(validator.run(""))
        
        validator.addRule(FKValidatorRuleExactLength(length: 5))
        XCTAssertFalse(validator.run("abcd"))
        XCTAssertTrue(validator.run("abcde"))
        XCTAssertFalse(validator.run("abcdef"))
    }
}
