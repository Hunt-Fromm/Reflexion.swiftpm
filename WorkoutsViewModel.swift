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
    
    /// Saves 'workouts' to AppStorage var workoutsData (Persistence!)
    func saveWorkouts() {
        // Executes JSONEncoder's function 'encode' to encode data in workouts into encodedData
        if let encodedData = try? JSONEncoder().encode(workouts) {
            workoutsData = encodedData
        }
    }
    
    func saveWorkouts(_ workouts: [Workout]) {
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
