//
//  File.swift
//  
//
//  Created by Keegan on 8/18/24.
//

import Foundation

struct KCalendarUtilities {
    
    func roundUpToNearestMultipleOfSeven(_ value: Int) -> Int {
        return Int(ceil(Double(value) / 7.0)) * 7
    }
}
