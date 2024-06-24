//
//  CustomDatePicker.swift
//  TasksApp
//
//  Created by AdminFS on 27/07/23.
//

import SwiftUI

//CalendarView
struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    @Binding var isShowingPicker: Bool
    @State var currentMonth: Date = Date()
    
    var body: some View {
        VStack(spacing: 35) {
            
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 20) {
                Button {
                    isShowingPicker = true
                } label: {
                    HStack {
                        Text("\(extraData()[0]), \(extraData()[1])")
                            .font(.title.bold())
                            .foregroundColor(Color.primary)
                        Image(systemName: ImageName.rightArrow)
                    }
                    
                }
                Spacer(minLength: 0)
                Button {
                    withAnimation {
                        currentMonth = getCurrentMonth(for: currentDate, by: -1)
                    }
                } label: {
                    Image(systemName: ImageName.leftArrow)
                        .font(.title2)
                }
                Button {
                    withAnimation {
                        currentMonth = getCurrentMonth(for: currentDate, by: 1)
                    }
                } label: {
                    Image(systemName: ImageName.rightArrow)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    DateView(currentDate: currentDate, value: value)
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = newValue
        }
    }
    
    func extraData() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth(for date: Date, by value: Int) -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: value, to: date) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        var days = currentDate.getAllDatesForMonth().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: currentDate), at: 0)
        }
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    @State static var currentDate = Date()
    @State static var isShowingPicker = true
    
    static var previews: some View {
        CustomDatePicker(currentDate: $currentDate, isShowingPicker: $isShowingPicker)
    }
}
