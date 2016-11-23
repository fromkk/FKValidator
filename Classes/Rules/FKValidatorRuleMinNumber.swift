//
//  FKValidatorRuleMinNumber.swift
//  FKValidator
//
//  Created by Ueoka Kazuya on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

open class FKValidatorRuleMinNumber :FKValidatorRule
{
    var number :Float = 0.0
    
    public init(number :Float)
    {
        super.init()
        
        self.number = number
    }
    
    public init(number: Float, errorMessage: String) {
        super.init(errorMessage: errorMessage)
        
        self.number = number
    }
    
    override func _commonInit() {
        self.errorCode = .minNumber
    }
    
    open override func run(_ value: String) -> Bool {
        if (super.run(value))
        {
            return true
        }
        
        let val :Float = Float(value)!
        return self.number <= val
    }
}
