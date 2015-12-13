//
//  FKValidatorRuleRequired.swift
//  FKValidator
//
//  Created by Kazuya Ueoka on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

class FKValidatorRuleRequired :FKValidatorRule
{
    override init()
    {
        super.init()
    }
    
    override init(errorMessage: String) {
        super.init()
        self.errorMessage = errorMessage
    }
    
    override func _commonInit() {
        super._commonInit()
        
        self.errorCode = .Required
    }
    
    override func run(value :String) -> Bool
    {
        return 0 != value.characters.count
    }
}