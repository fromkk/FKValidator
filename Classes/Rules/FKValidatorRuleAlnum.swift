//
//  FKValidatorRuleAlnum.swift
//  FKValidator
//
//  Created by Ueoka Kazuya on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

class FKValidatorRuleAlnum :FKValidatorRuleMatchPattern
{
    let _pattern :String = "^[0-9a-zA-Z]+$"
    
    init()
    {
        super.init(pattern: self._pattern)
    }
    
    init(errorMessage: String) {
        super.init(pattern: self._pattern, errorMessage: errorMessage)
    }
    
    override func _commonInit() {
        self.errorCode = FKValidatorErrorCode.Alnum
    }
}