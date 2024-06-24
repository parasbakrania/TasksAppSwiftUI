//
//  DateView.swift
//  TasksApp
//
//  Created by AdminFS on 27/07/23.
//

import SwiftUI

struct DateView: View {
    
    var currentDate: Date
    var value: DateValue
    
    var body: some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.title3.bold())
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
            }
        }
        .padding(.vertical, 8)
        .background(
            Circle().fill(.blue)
                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
        )
    }
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dateValue = DateValue(day: Date().year, date: Date())
        DateView(currentDate: Date(), value: dateValue)
    }
}
