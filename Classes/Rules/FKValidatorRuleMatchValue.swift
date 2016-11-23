//
//  FKValidatorRuleMatchValue.swift
//  FKValidator
//
//  Created by Ueoka Kazuya on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

open class FKValidatorRuleMatchValue :FKValidatorRule
{
    var value :String = ""
    
    public init(value :String)
    {
        super.init()
        
        self.value = value
    }
    
    public init(value :String, errorMessage :String)
    {
        super.init(errorMessage: errorMessage)
        
        self.value = value
    }
    
    override func _commonInit()
    {
        self.errorCode = .matchValue
    }
    
    open override func run(_ value: String) -> Bool
    {
        if (super.run(value))
        {
            return true
        }
        
        return value == self.value
    }
}
