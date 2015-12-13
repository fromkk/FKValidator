//
//  FKValidatorRuleBetweenNumber.swift
//  FKValidator
//
//  Created by Ueoka Kazuya on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

class FKValidatorRuleBetweenNumber :FKValidatorRule
{
    var minNumber :Float = 0.0
    var maxNumber :Float = 0.0
    
    init(minNumber :Float, maxNumber :Float) {
        super.init()
        
        self.minNumber = minNumber
        self.maxNumber = maxNumber
    }
    
    init(minNumber :Float, maxNumber :Float, errorMessage :String) {
        super.init(errorMessage: errorMessage)
        
        self.minNumber = minNumber
        self.maxNumber = maxNumber
    }
    
    override func _commonInit() {
        self.errorCode = .BetweenNumber
    }
    
    override func run(value: String) -> Bool {
        if (super.run(value))
        {
            return true
        }
        
        let num :Float = Float(value)!
        return self.minNumber <= num && num <= maxNumber
    }
}