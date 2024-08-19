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

struct CalendarView: View {
    
    let calendar = Calendar.current
    
    // bindings
    // year
    // month
    // date

    var body: some View {
        let columns = Array(repeating: GridItem(.fixed(40), spacing: 2), count: 7)

        let currentMonthDays = KCalendarManager().getAllDaysInMonth(year: 2024, month: 8)!
        let startingWeekday = KCalendarManager().getStartingWeekday(for: currentMonthDays.first!.date)
        
        let previousMonthDays = KCalendarManager().getPreviousMonthDays(year: 2024, month: 8, count: startingWeekday - 1)
        let totalCalendarSlotsFilled = startingWeekday - 1 + currentMonthDays.count
        let nextMonthDays = KCalendarManager().getNextMonthPreview(year: 2024, month: 8, currentMonthDayCount: totalCalendarSlotsFilled)
                
        
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"], id: \.self) { shortName in
                    Text("\(shortName)")
                }
            }
            
            LazyVGrid(columns: columns) {
                // Display previous month's days (grayed out)
                ForEach(previousMonthDays) { day in
                    Text("\(day.dayNumber)")
                        .foregroundColor(.gray)
                }
                
                // Display current month's days
                ForEach(currentMonthDays) { day in
                    Text("\(day.dayNumber)")
                }
                .frame(maxHeight: .infinity)
                
                // Display next month's days (grayed out)
                ForEach(nextMonthDays) { day in
                    Text("\(day.dayNumber)")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(30)
    }
}

#Preview {
    CalendarView()
}
