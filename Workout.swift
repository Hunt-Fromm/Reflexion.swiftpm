//
//  Workout.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/15/25.
//

import SwiftUI

struct Workout: Hashable {
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var type: String
    
    var dayOfTheWeek: String
    var date: Int
    var month: Int
    var year: Int
    
    var hours: Int
    var minutes: Int
    
    var mood: Int
    var energy: Int
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
        self.mood = 0
        self.energy = 0
        self.reflection = ""
        
        dateCode = year * 10000 + month * 100 + date
        descr = "\(type) - \(month)/\(date)/\(String(year).prefix(1))\(String(year).suffix(3))"
    }
    
    
    
    
}
