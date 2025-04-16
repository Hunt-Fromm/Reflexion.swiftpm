//
//  Workout.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/15/25.
//

import SwiftUI

struct Workout: Hashable {
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var dayOfTheWeek: String
    var date: Int
    var month: Int
    var year: Int
    
    var hours: Int
    var minutes: Int
    
    var mood: Int
    var energy: Int
    var reflection: String
    
    /// Creates a Workout Object, initializing the values of all instance variables
    init(dayOfTheWeek: String, date: Int, month: Int, year: Int, hours: Int, minutes: Int, mood: Int, energy: Int, reflection: String) {
        self.dayOfTheWeek = dayOfTheWeek
        self.date = date
        self.month = month
        self.year = year
        self.hours = hours
        self.minutes = minutes
        self.mood = mood
        self.energy = energy
        self.reflection = reflection
    }
    
}
