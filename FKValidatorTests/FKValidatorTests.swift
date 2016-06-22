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
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.required.rawValue)
        XCTAssert(validator.run("hello"))
    }
    
    func testValidatorExactLength()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleExactLength(length: 5, errorMessage: "value is not 5 length."))
        XCTAssertFalse(validator.run(""))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.required.rawValue)
        
        XCTAssertFalse(validator.run("abcd"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.exactLength.rawValue)
        XCTAssertTrue(validator.run("abcde"))
        XCTAssertFalse(validator.run("abcdef"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.exactLength.rawValue)
        XCTAssertEqual(validator.errors.first?.localizedDescription, "value is not 5 length.")
    }
    
    func testValidatorMinLength()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMinLength(length: 5))
        XCTAssertFalse(validator.run("abcd"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.minLength.rawValue)
        
        XCTAssertTrue(validator.run("abcde"))
        XCTAssertTrue(validator.run("abcdef"))
    }
    
    func testValidatorMaxLength()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMaxLength(length: 5))
        XCTAssertTrue(validator.run("abcd"))
        XCTAssertTrue(validator.run("abcde"))
        XCTAssertFalse(validator.run("abcdef"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.maxLength.rawValue)
    }
    
    func testMinNumber()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMinNumber(number: 100))
        XCTAssertFalse(validator.run("99"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.minNumber.rawValue)
        
        XCTAssert(validator.run("100"))
        XCTAssert(validator.run("101"))
    }
    
    func testMaxNumber()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMaxNumber(number: 100))
        XCTAssertTrue(validator.run("99"))
        XCTAssertTrue(validator.run("100"))
        XCTAssertFalse(validator.run("101"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.maxNumber.rawValue)
    }
    
    func testMatchValue()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMatchValue(value: "hello"))
        XCTAssertFalse(validator.run("foo"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.matchValue.rawValue)
        
        XCTAssertFalse(validator.run("bar"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.matchValue.rawValue)
        
        XCTAssert(validator.run("hello"))
    }
    
    func testMatchPattern()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleMatchPattern(pattern: "^[a-z]+$"))
        XCTAssertFalse(validator.run("012345"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.matchPattern.rawValue)
        
        XCTAssert(validator.run("abcdef"))
        XCTAssert(validator.run("ABCDEF"))
    }
    
    func testPostalCode()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRulePostalCode())
        XCTAssertFalse(validator.run("1234567"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.postalCode.rawValue)
        XCTAssert(validator.run("123-4567"))
    }
    
    func testEmail()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleEmail())
        XCTAssertFalse(validator.run("http://www.google.com/"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.email.rawValue)
        XCTAssert(validator.run("info@fromkk.info"))
    }
    
    func testURL()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleURL())
        XCTAssert(validator.run("http://www.google.com/"))
        XCTAssertEqual(validator.errors, [])
        XCTAssertFalse(validator.run("info@fromkk.info"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.url.rawValue)
    }
    
    func testTelephone()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleTelephone())
        XCTAssertFalse(validator.run("abc"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.telephone.rawValue)
        
        XCTAssertFalse(validator.run("012"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.telephone.rawValue)
        
        XCTAssertFalse(validator.run("012-3456"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.telephone.rawValue)
        
        XCTAssert(validator.run("012-3456-7890"))
        XCTAssertEqual(validator.errors, [])
        
        XCTAssertFalse(validator.run("012-3456-7890-1234"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.telephone.rawValue)
    }
    
    func testNumeric()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleNumeric())
        XCTAssert(validator.run("-1234567890.123456789"))
        XCTAssert(validator.run("+1234567890.123456789"))
        XCTAssert(validator.run("1234567890"))
        XCTAssertFalse(validator.run("abcdef"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.numeric.rawValue)
    }
    
    func testAlphabet()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleAlphabet())
        XCTAssert(validator.run("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
        XCTAssertFalse(validator.run("012345679"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.alphabet.rawValue)
    }
    
    func testAlnum()
    {
        let validator :FKValidator = FKValidator().addRule(FKValidatorRuleRequired()).addRule(FKValidatorRuleAlnum())
        XCTAssert(validator.run("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))
        XCTAssertFalse(validator.run("!\"#$%&'()0=~|`{+*}<>?_'"))
        XCTAssertEqual(validator.errors.first?.code, FKValidatorErrorCode.alnum.rawValue)
    }
}
