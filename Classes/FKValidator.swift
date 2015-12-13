//
//  FKValidator.swift
//  FKValidator
//
//  Created by Kazuya Ueoka on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

class FKValidator :NSObject
{
    var rules: Array <FKValidatorRule> = []
    var errors :Array <NSError> = []
    
    func addRule(rule :FKValidatorRule) -> Self
    {
        self.rules.append(rule)
        return self
    }
    
    func addRules(rules :Array<FKValidatorRule>) -> Self
    {
        for rule in rules
        {
            self.addRule(rule)
        }
        
        return self
    }
    
    func run(value :String) -> Bool
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