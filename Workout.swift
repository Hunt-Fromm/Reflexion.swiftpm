//
//  Workout.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/15/25.
//

import SwiftUI

let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
let abbrWeekdays = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]


// Needs to be Identifiable and Codable in order to use persistance with UserDefaults
struct Workout: Hashable, Codable {
    
    
    var type: String
    
    var dayOfTheWeek: String
    var date: Int
    var month: Int
    var year: Int
    
    var hours: Int
    var minutes: Int
    
    
    var mood: Int // Value 1 to 5
    var energy: Int // Value 1 to 5
    var reflection: String
    
    // Numerical value used to sort workouts chronologically
    var dateCode: Int
    
    // Text description for each workout that will appear in workout log
    var descr: String
    
    /// Creates a Workout Object, initializing the values of all instance variables
    init(type: String, dayOfTheWeek: String, date: Int, month: Int, year: Int, hours: Int, minutes: Int, mood: Int, energy: Int, reflection: String) {
        self.type = type
        self.dayOfTheWeek = dayOfTheWeek
        self.date = date
        self.month = month
        self.year = year
        self.hours = hours
        self.minutes = minutes
        self.mood = mood
        self.energy = energy
        self.reflection = reflection
        
        dateCode = year * 10000 + month * 100 + date
        descr = "\(type) - \(month)/\(date)/\(String(year).prefix(1))\(String(year).suffix(3))"
    }
    
    /// Declaration for quick use of WorkoutLog
    init(type: String, date: Int, month: Int, year: Int) {
        self.type = type
        self.dayOfTheWeek = "N/A"
        self.date = date
        self.month = month
        self.year = year
        self.hours = 0
        self.minutes = 30
        self.mood = 3
        self.energy = 3
        self.reflection = ""
        
        dateCode = year * 10000 + month * 100 + date
        descr = "\(type) - \(month)/\(date)/\(String(year).prefix(1))\(String(year).suffix(3))"
    }
    
    // Returns a description of the workout, including its day of the week
    func weekdayDescr() -> String {
        return "\(type) - \(month)/\(date)/\(String(year).prefix(1))\(String(year).suffix(3)) (\(abbrWeekdays[determineDayOfWeek(dateCode)]))"
    }
    
    
}
