//
//  File.swift
//  
//
//  Created by Keegan on 8/18/24.
//

import Foundation


struct KCalendarManager {
    var calendarDate: CalendarData

    // Ensure the initializer is public or internal
    
    init(calendarDate: CalendarData) {
        self.calendarDate = calendarDate
    }
    
    
    func totalCalendarSlotsTaken() -> Int {
        //TODO: Unwrap
        return self.getStartingWeekday() - 1 + self.getAllDaysInMonth()!.count
    }
    
    
    func getStartingWeekday() -> Int {
        // Get the weekday for the first date of the month (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
        //TODO: Remove unwrap, update getalldaysinmonth to use the default date in nil situations
        let weekday = self.calendarDate.calendar.component(.weekday, from: self.getAllDaysInMonth()!.first!.date)
        
        return weekday
    }
    
    func getPreviousMonthPreview() -> [Day] {
        let numOfDaysToShow = self.getStartingWeekday() - 1
        
        // TODO: Remove unwrap
        let previousMonthDays = getAllDaysInMonth(offset: -1)!
        return Array(previousMonthDays.suffix(numOfDaysToShow))
    }
    
    func getNextMonthPreview() -> [Day] {
        let numOfDaysToShow = totalCalendarSlotsTaken()
        
        let count = KCalendarUtilities().roundUpToNearestMultipleOfSeven(numOfDaysToShow) - numOfDaysToShow
        
        // TODO: Remove unwrap
        let nextMonthDays = getAllDaysInMonth(offset: -1)!
                
        return Array(nextMonthDays.prefix(count))
    }
    
    // Refactor and break out
    func getAllDaysInMonth(offset: Int = 0) -> [Day]? {
        var dates: [Day] = []
            
        var dateComponents = DateComponents(year: self.calendarDate.year, month: self.calendarDate.month)
        
        guard let dateFromComponents = self.calendarDate.calendar.date(from: dateComponents) else {
            return nil
        }
        
        // Adjust the month and year based on the offset
        if let adjustedDate = self.calendarDate.calendar.date(byAdding: .month, value: offset, to: dateFromComponents) {
            let adjustedComponents = self.calendarDate.calendar.dateComponents([.year, .month], from: adjustedDate)
            dateComponents.year = adjustedComponents.year
            dateComponents.month = adjustedComponents.month
        }
        
        // Get the first day of the adjusted month
        dateComponents.day = 1
        guard let startDate = self.calendarDate.calendar.date(from: dateComponents) else {
            return nil
        }

        // Get the range of days in the adjusted month
        guard let range = self.calendarDate.calendar.range(of: .day, in: .month, for: startDate) else {
            return nil
        }
        
        // Iterate over the days in the adjusted month
        for day in range {
            dateComponents.day = day
            guard let date = self.calendarDate.calendar.date(from: dateComponents) else {
                return nil
            }
            dates.append(Day(date: date, dayNumber: day))
        }
        
        
        return dates
    }
}
