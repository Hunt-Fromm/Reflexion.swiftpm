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
    
    @Binding var darkMode: Bool
    
    var body: some View {
        
        NavigationStack {
            
                
            VStack {
                
                // Dark Mode Toggle
                HStack {
                    
                    Text("Dark Mode:")
                        .font(.custom("Arial Bold", size: 22))
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(darkMode ? .white : . black)
                    
                    
                    Spacer()
                        .frame(width: 20)
                    
                    Button() {
                        darkMode.toggle()
                    } label: {
                        
                        ZStack {
                            
                            Capsule()
                                .frame(width: 60, height: 30)
                                .foregroundStyle(darkMode ? .blue : .gray)
                            
                            HStack {
                                Spacer()
                                    .frame(width: darkMode ? 30 : 0)
                                
                                Circle()
                                    .frame(width: 24)
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                    .frame(width: darkMode ? 0 : 30)
                            }
                        }
                    }
                }
                
                
                // Developer Reset button - resets to initial 5 items
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
                
                
                // Reset all workouts
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.blue)
                        .font(.system(size: 20))
                        .bold()
                    Image(systemName: "list.dash")
                        .foregroundStyle(.blue)
                        .font(.system(size: 25))
                        .bold()
                }
            }
            
        }
        
        
    }
}

