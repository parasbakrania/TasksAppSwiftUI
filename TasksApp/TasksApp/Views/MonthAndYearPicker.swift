//
//  MonthAndYearPicker.swift
//  TasksApp
//
//  Created by AdminFS on 27/07/23.
//

import SwiftUI

struct MonthAndYearPicker: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var currentDate: Date
    @Binding var isShowing: Bool
    
    @State var monthIndex: Int = 0
    @State var yearIndex: Int = 0
    
    let monthSymbols = Calendar.current.monthSymbols
    let years = Array(Date().year..<Date().year+10)
    
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                HStack {
                    Button(action: {
                        isShowing = false
                    }) {
                        Text(CommonString.cancel)
                            .padding(.horizontal, 8)
                    }
                    Spacer()
                    Button(action: {
                        var components = DateComponents()
                        components.month = monthIndex + 1
                        components.year = Int(years[yearIndex])
                        components.day = Calendar.current.component(.day, from: currentDate)
                        if let date = Calendar.current.date(from: components) {
                            currentDate = date
                        }
                        isShowing = false
                    }) {
                        Text(CommonString.done)
                            .padding(.horizontal, 8)
                    }
                }
                .padding(16)
                
                HStack {
                    Picker(selection: $monthIndex, label: Text("")) {
                        ForEach(0..<monthSymbols.count, id: \.self) { index in
                            Text(monthSymbols[index])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: geometry.size.width / 2).clipped()
                    
                    Picker(selection: $yearIndex, label: Text("")) {
                        ForEach(0..<years.count, id: \.self) { index in
                            Text(String(years[index]))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: geometry.size.width / 2).clipped()
                    
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }
}

struct MonthAndYearPicker_Previews: PreviewProvider {
    @State static var currentDate = Date()
    @State static var isShowing = true
    
    static var previews: some View {
        MonthAndYearPicker(currentDate: $currentDate, isShowing: $isShowing)
    }
}
