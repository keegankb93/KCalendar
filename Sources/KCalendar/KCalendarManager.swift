//
//  File.swift
//  
//
//  Created by Keegan on 8/18/24.
//

import Foundation


struct KCalendarManager {
    let calendar = Calendar.current
    //var year: Int { calendar.component(.year, from: Date()) }
    //var month: Int { calendar.component(.month, from: Date()) }
    //var day: Int { calendar.component(.day, from: Date()) }
    
    
//    func formatDate() -> String {
//        let date = calendar.date(from: getDateComponents()!)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter.string(from: date!)
//    }
    
    func getStartingWeekday(for date: Date) -> Int {
        // Get the weekday for the first date of the month (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
        let weekday = calendar.component(.weekday, from: date)
        return weekday
    }
    
    func getPreviousMonthDays(year: Int, month: Int, count: Int) -> [Day] {
        let previousMonthDays = getAllDaysInMonth(year: year, month: month, offset: -1)!
        return Array(previousMonthDays.suffix(count))
    }
    
    func getNextMonthPreview(year: Int, month: Int, currentMonthDayCount: Int) -> [Day] {
        let count = 35 - currentMonthDayCount
        let nextMonthDays = getAllDaysInMonth(year: year, month: month, offset: -1)!
        
        print(count)
        
        return Array(nextMonthDays.prefix(count))
    }
    
    func getAllDaysInMonth(year: Int, month: Int, offset: Int = 0) -> [Day]? {
        var dates: [Day] = []
            
        var dateComponents = DateComponents(year: year, month: month)
        
        // Adjust the month and year based on the offset
        if let adjustedDate = calendar.date(byAdding: .month, value: offset, to: calendar.date(from: dateComponents)!) {
            let adjustedComponents = calendar.dateComponents([.year, .month], from: adjustedDate)
            dateComponents.year = adjustedComponents.year
            dateComponents.month = adjustedComponents.month
        }
        
        // Get the first day of the adjusted month
        dateComponents.day = 1
        guard let startDate = calendar.date(from: dateComponents) else {
            return nil
        }
        
        // Get the range of days in the adjusted month
        guard let range = calendar.range(of: .day, in: .month, for: startDate) else {
            return nil
        }
        
        // Iterate over the days in the adjusted month
        for day in range {
            dateComponents.day = day
            if let date = calendar.date(from: dateComponents) {
                dates.append(Day(date: date, dayNumber: day))
            }
        }
        
        return dates
    }
}
