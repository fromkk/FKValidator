//
//  FKValidator.swift
//  FKValidator
//
//  Created by Kazuya Ueoka on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

open class FKValidator :NSObject
{
    open var rules: Array <FKValidatorRule> = []
    open var errors :Array <NSError> = []
    
    @discardableResult
    open func addRule(_ rule :FKValidatorRule) -> Self
    {
        self.rules.append(rule)
        return self
    }
    
    @discardableResult
    open func addRules(_ rules :Array<FKValidatorRule>) -> Self
    {
        for rule in rules
        {
            self.addRule(rule)
        }
        
        return self
    }
    
    open func run(_ value :String) -> Bool
    {
        var result :Bool = true
        self.errors = []
        for rule in self.rules
        {
            if (false == rule.run(value) )
            {
                result = false
                self.errors.append(rule.error)
            }
        }
        return result
    }
}
