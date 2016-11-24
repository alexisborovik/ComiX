//
//  Tools.swift
//  ComiX
//
//  Created by Alexis on 11/18/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import Foundation

class Tools {
    
    public static func getTimaAsString() -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM-dd-yy-hh-mm-ss-SSS"
        let nows = dateformatter.string(from: NSDate() as Date)
        return nows
    }
    
    public static func getUniqueString() -> String {
        return NSUUID().uuidString
    }
}
