//
//  WorkoutsViewModel.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 5/9/25.
//

import SwiftUI

class WorkoutsViewModel: ObservableObject {
    
    @AppStorage("workoutsData") var workoutsData: Data = Data()
    
    @Published var workouts: [Workout] = []
    
    init() {
        retreiveWorkouts()
    }
    
    init(amDeveloping: Bool) {
        
        workouts = [
            Workout(type: "Run", dayOfTheWeek: "Tuesday", date: 15, month: 4, year: 2025, hours: 0, minutes: 30, mood: 4, energy: 2, reflection: "test test test test test test test test test test test test test test test test test test"),
            Workout(type: "Yoga", date: 17, month: 4, year: 2025),
            Workout(type: "Bike", date: 16, month: 4, year: 2025),
            Workout(type: "Hike", date: 16, month: 5, year: 2025),
            Workout(type: "Run", dayOfTheWeek: "Wednesday", date: 7, month: 5, year: 2025, hours: 1, minutes: 20, mood: 4, energy: 4, reflection: "")
        ]
        
        saveWorkouts()
        retreiveWorkouts()
        
    }
    
    /// Saves 'workouts' to AppStorage var workoutsData (Persistence!)
    func saveWorkouts() {
        // Executes JSONEncoder's function 'encode' to encode data in workouts into encodedData
        if let encodedData = try? JSONEncoder().encode(workouts) {
            workoutsData = encodedData
        }
    }
    
    /// Retreives 'workouts' from AppStorage var workoutsData (Persistence!)
    func retreiveWorkouts() {
        // Executes JSONEncoder's function 'decode' to decode data from workoutsData into decodedData
        if let decodedData = try? JSONDecoder().decode([Workout].self, from: workoutsData) {
            workouts = decodedData
        }
    }
}
