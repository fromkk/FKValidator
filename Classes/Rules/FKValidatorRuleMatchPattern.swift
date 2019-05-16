//
//  FKValidatorRuleMatchPattern.swift
//  FKValidator
//
//  Created by Ueoka Kazuya on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

open class FKValidatorRuleMatchPattern :FKValidatorRule
{
    var pattern :String = ""
    
    public init(pattern :String)
    {
        super.init()
        
        self.pattern = pattern
    }
    
    public init(pattern :String, errorMessage :String)
    {
        super.init(errorMessage: errorMessage)
        
        self.pattern = pattern
    }
    
    override func _commonInit() {
        self.errorCode = .matchPattern
    }
    
    open override func run(_ value: String) -> Bool {
        if (super.run(value))
        {
            return true
        }
        
        let regexp :NSRegularExpression = try! NSRegularExpression(pattern: self.pattern, options: [.caseInsensitive, .dotMatchesLineSeparators] )
        return regexp.matches(in: value, options: [], range: NSMakeRange(0, value.count)).count > 0
    }
}
