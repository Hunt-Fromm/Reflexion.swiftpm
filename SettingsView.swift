//
//  SettingsView.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 5/16/25.
//

import SwiftUI

struct SettingsView: View {
    
    // View parameters
    @Binding var workouts: [Workout]
    @ObservedObject var workoutsViewModel: WorkoutsViewModel
    var sortWorkoutsByMonth: Void
    
    @Environment(\.dismiss) var dismiss
    
    @State var showAlert = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                // Back button
                Button() {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left.to.line.alt")
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Arial Bold", size: 40))
                        .foregroundStyle(.white)
                }

                
                Button() {
                    
                    workouts = [
                        Workout(type: "Run", dayOfTheWeek: "Tuesday", date: 15, month: 4, year: 2025, hours: 0, minutes: 30, mood: 4, energy: 2, reflection: "test test test test test test test test test test test test test test test test test test"),
                        Workout(type: "Yoga", date: 17, month: 4, year: 2025),
                        Workout(type: "Bike", date: 16, month: 4, year: 2025),
                        Workout(type: "Hike", date: 16, month: 5, year: 2025),
                        Workout(type: "Run", dayOfTheWeek: "Wednesday", date: 7, month: 5, year: 2025, hours: 1, minutes: 20, mood: 4, energy: 4, reflection: "")
                    ]
                    sortWorkoutsByMonth
                    workoutsViewModel.saveWorkouts(workouts)
                    
                    dismiss()
                    
                } label: {
                    Capsule()
                        .frame(width: 150, height: 50)
                        .foregroundStyle(.red)
                        .overlay() {
                            Text("Dev Reset")
                                .font(.custom("Arial Bold", size: 24))
                        }
                }
                
                Button() {
                    
                    showAlert.toggle()
                    
                } label: {
                    Capsule()
                        .frame(width: 150, height: 50)
                        .foregroundStyle(.red)
                        .overlay() {
                            Text("Reset")
                                .font(.custom("Arial Bold", size: 24))
                        }
                }
                .alert("Are you sure you want to reset all workouts?\n\nThis action cannot be undone.", isPresented: $showAlert) {
                    
                    HStack {
                        Button() {
                            workouts = []
                            sortWorkoutsByMonth
                            workoutsViewModel.saveWorkouts(workouts)
                            dismiss()
                        } label: {
                            Text("Reset")
                                .foregroundStyle(.red)
                        }
                        
                        Button("No thanks") {}
                    }
                    
                }
            }
            .frame(width: 200)
            
        }
        .navigationBarHidden(true)
        
        
    }
}

