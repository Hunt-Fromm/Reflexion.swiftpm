//
//  YearReviewView.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 5/1/25.
//

import SwiftUI

struct YearReviewView: View {
    
    @State var durationToday = 0
    
    // Initialized to startingDatecode
    var startingDatecode: Int
    
    @State var activeDatecode: Int = 0
    
    
    var workoutColors: [Color]
    var yearWorkouts: [Workout]
    var yearDatecodes: [Int]
    
    @State var tempYearWorkouts: [Workout] = []
    @State var tempYearDatecodes: [Int] = []
    @State var tempWorkoutColors: [Color] = []
    
    
    
    // Functions passed as parameters
    var isLeapYear: (Int) -> Bool
    var makeValidDatecode: (Int) -> (Int)
    
    
    // Colors corresponding with different workout types
    let colors: [Color] = [
        Color.white,
        Color(red: 0.7, green: 0.7, blue: 1),
        Color(red: 0.5, green: 1, blue: 0.5),
        Color(red: 1, green: 1, blue: 0.5),
        Color(red: 1, green: 0.5, blue: 0.5)
    ]
    
    @State var showLog = false
    
    
    
    var body: some View {
        
        HStack {
            
            VStack {
                ForEach(0...6, id: \.self) { i in
                    Text(days[(weekDay + i) % 7])
                        .foregroundStyle(.white)
                        .font(.custom("Arial", size: 15))
                }
                
            }
            .onAppear() {
                tempYearWorkouts = yearWorkouts
                tempYearDatecodes = yearDatecodes
                tempWorkoutColors = workoutColors
                activeDatecode = startingDatecode
                
                
                showLog = true
                
                for i in 0...363 {
                    determineDailyColor(i / 7, i % 7)
                }
                
                activeDatecode = startingDatecode
            }
            
            ZStack {
                
                // Holds squares representing the past year's calendar
                ScrollView(.horizontal) {
                    HStack(spacing: 2.5) {
                        
                        // Extra space that left side gradient will cover
                        Spacer()
                            .frame(width: 0, height: 0)
                        
                        
                        if showLog {
                            Spacer()
                                .frame(width: 10)
                            
                            
                            ForEach(0...51, id: \.self) { i in
                                
                                
                                
                                VStack(spacing: 2.5) {
                                    ForEach(0...6, id: \.self) { j in

                                        
                                        Rectangle()
                                            .frame(width: 15, height: 15)
                                            .foregroundStyle(tempWorkoutColors[363 - (i * 7 + 6 - j)])
                                        
                                        
                                    
                                    }
                                }
                                
                            }
                            
                        }
                        
                        
                        Spacer()
                            .frame(width: 30, height: 0)
                        
                    } // End HStack for Weeks of Workouts
                    
                    
                    
                } // End Horizontal ScrollView
                .scrollIndicators(.hidden)
                
                
                // Left and right sides' gradient covers for scroll view
                HStack {
                    
                    
                    Rectangle()
                        .frame(width: 10, height: 125)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(0)]), startPoint: .leading, endPoint: .trailing))
                    
                    Spacer()
                        .frame(maxWidth: .infinity)
                    
                    
                    Rectangle()
                        .frame(width: 40, height: 125)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(1)]), startPoint: .leading, endPoint: .trailing))
                }
                
            }
            
        }
        
    }
    
    
    func determineDailyColor(_ i: Int, _ j: Int) {
        activeDatecode += 1
        activeDatecode = makeValidDatecode(activeDatecode)
        
        
        durationToday = 0
       
        while tempYearDatecodes.contains(activeDatecode) {
            durationToday += tempYearWorkouts[0].hours * 60 + tempYearWorkouts[0].minutes
            tempYearDatecodes.remove(at: 0)
            tempYearWorkouts.remove(at: 0)
        }
        


        if durationToday < 150 {
        tempWorkoutColors[i * 7 + j] = colors[(durationToday + 29) / 30]
        } else {
        tempWorkoutColors[i * 7 + j] = .red
        }
    }
}

//#Preview {
//    YearReviewView()
//}
