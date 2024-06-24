//
//  DateValue.swift
//  TasksApp
//
//  Created by AdminFS on 27/07/23.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
