//
//  SwiftUIView.swift
//  KCalendar
//
//  Created by Keegan on 8/18/24.
//

import SwiftUI


struct Day: Identifiable {
    let date: Date
    let dayNumber: Int
    let id = UUID()
}

struct CalendarData {
    let calendar = Calendar(identifier: .gregorian)
    let currentDate = Date()
    
    var year: Int?
    var month: Int?
    var day: Int?
    
    init(year: Int? = nil, month: Int? = nil, day: Int? = nil) {
        self.year = year ?? calendar.dateComponents([.year], from: currentDate).year
        self.month = month ?? calendar.dateComponents([.month], from: currentDate).month
        self.day = day ?? calendar.dateComponents([.day], from: currentDate).day
    }
    
    func getCurrentSelectedDate() -> Date {
        guard let selectedDate = self.calendar.date(from: DateComponents(year: self.year, month: self.month, day: self.day))
        else {
            return self.currentDate
        }
        
        return selectedDate
    }
}

struct CalendarView: View {  
    @State public var calendarDate = CalendarData(year: 2024, month: 8, day: 1)
    
    
    var body: some View {
        let columns = Array(repeating: GridItem(.fixed(40), spacing: 2), count: 7)
        let manager = KCalendarManager(calendarDate: calendarDate)

        VStack {
            LazyVGrid(columns: columns) {
                ForEach(["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"], id: \.self) { shortName in
                    Text("\(shortName)")
                }
            }
            
            LazyVGrid(columns: columns) {
                // Display previous month's days (grayed out)
                ForEach(manager.getPreviousMonthPreview()) { day in
                    Text("\(day.dayNumber)")
                        .foregroundColor(.gray)
                }
                
                // Display current month's days
                ForEach(manager.getAllDaysInMonth()!) { day in
                    Text("\(day.dayNumber)")
                }
                .frame(maxHeight: .infinity)
                
                // Display next month's days (grayed out)
                ForEach(manager.getNextMonthPreview()) { day in
                    Text("\(day.dayNumber)")
                        .foregroundColor(.gray)
                }
            }
        }.onAppear {
            
        }
        .padding(30)
    }
}

#Preview {
    CalendarView()
}
