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
    
    func testValidatorRequired() {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired())
        XCTAssertFalse(validator.run(""))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.Required.rawValue)
        XCTAssert(validator.run("hello"))
    }
    
    func testValidatorExactLength()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleExactLength(length: 5))
        XCTAssertFalse(validator.run(""))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.Required.rawValue)
        
        XCTAssertFalse(validator.run("abcd"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.ExactLength.rawValue)
        XCTAssertTrue(validator.run("abcde"))
        XCTAssertFalse(validator.run("abcdef"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.ExactLength.rawValue)
    }
    
    func testValidatorMinLength()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMinLength(length: 5))
        XCTAssertFalse(validator.run("abcd"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.MinLength.rawValue)
        
        XCTAssertTrue(validator.run("abcde"))
        XCTAssertTrue(validator.run("abcdef"))
    }
    
    func testValidatorMaxLength()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMaxLength(length: 5))
        XCTAssertTrue(validator.run("abcd"))
        XCTAssertTrue(validator.run("abcde"))
        XCTAssertFalse(validator.run("abcdef"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.MaxLength.rawValue)
    }
    
    func testMinNumber()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMinNumber(number: 100))
        XCTAssertFalse(validator.run("99"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.MinNumber.rawValue)
        
        XCTAssert(validator.run("100"))
        XCTAssert(validator.run("101"))
    }
    
    func testMaxNumber()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMaxNumber(number: 100))
        XCTAssertTrue(validator.run("99"))
        XCTAssertTrue(validator.run("100"))
        XCTAssertFalse(validator.run("101"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.MaxNumber.rawValue)
    }
    
    func testMatchValue()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMatchValue(value: "hello"))
        XCTAssertFalse(validator.run("foo"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.MatchValue.rawValue)
        
        XCTAssertFalse(validator.run("bar"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.MatchValue.rawValue)
        
        XCTAssert(validator.run("hello"))
    }
    
    func testMatchPattern()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMatchPattern(pattern: "^[a-z]+$"))
        XCTAssertFalse(validator.run("012345"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.MatchPattern.rawValue)
        
        XCTAssert(validator.run("abcdef"))
        XCTAssert(validator.run("ABCDEF"))
    }
    
    func testPostalCode()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRulePostalCode())
        XCTAssertFalse(validator.run("1234567"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.PostalCode.rawValue)
        XCTAssert(validator.run("123-4567"))
    }
    
    func testEmail()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleEmail())
        XCTAssertFalse(validator.run("http://www.google.com/"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.Email.rawValue)
        XCTAssert(validator.run("info@fromkk.info"))
    }
    
    func testURL()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleURL())
        XCTAssert(validator.run("http://www.google.com/"))
        XCTAssertEqual(validator.errors, [])
        XCTAssertFalse(validator.run("info@fromkk.info"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.URL.rawValue)
    }
    
    func testTelephone()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleTelephone())
        XCTAssertFalse(validator.run("abc"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.Telephone.rawValue)
        
        XCTAssertFalse(validator.run("012"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.Telephone.rawValue)
        
        XCTAssertFalse(validator.run("012-3456"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.Telephone.rawValue)
        
        XCTAssert(validator.run("012-3456-7890"))
        XCTAssertEqual(validator.errors, [])
        
        XCTAssertFalse(validator.run("012-3456-7890-1234"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.Telephone.rawValue)
    }
}
