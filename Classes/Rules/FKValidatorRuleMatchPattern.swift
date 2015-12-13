//
//  FKValidatorRuleMatchPattern.swift
//  FKValidator
//
//  Created by Ueoka Kazuya on 2015/12/13.
//  Copyright © 2015年 fromKK. All rights reserved.
//

import Foundation

class FKValidatorRuleMatchPattern :FKValidatorRule
{
    var pattern :String = ""
    
    init(pattern :String)
    {
        super.init()
        
        self.pattern = pattern
    }
    
    init(pattern :String, errorMessage :String)
    {
        super.init(errorMessage: errorMessage)
        
        self.pattern = pattern
    }
    
    override func _commonInit() {
        self.errorCode = .MatchPattern
    }
    
    override func run(value: String) -> Bool {
        if (super.run(value))
        {
            return true
        }
        
        let regexp :NSRegularExpression = try! NSRegularExpression(pattern: self.pattern, options: [.CaseInsensitive, .DotMatchesLineSeparators] )
        return regexp.matchesInString(value, options: [], range: NSMakeRange(0, value.characters.count)).count > 0
    }
}