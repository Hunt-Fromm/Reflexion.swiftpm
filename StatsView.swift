//
//  StatsView.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/21/25.
//

import SwiftUI

struct StatsView: View {
    @Binding var workouts: [Workout]

    // Makes dismissing possible
    @Environment(\.dismiss) var dismiss
    
    
    @State var yearWorkouts: [Workout] = []
    @State var yearDatecodes: [Int] = []
    
    // Number of minutes the user worked out this year
    @State var yearDuration = 0
    
    @State var yearStartCode = 0
    @State var activeDatecode = 0
    @State var workoutsToday = 0
    
    let daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let todayDateCode = yearToday * 10000 + monthToday * 100 + dateToday
    let workoutColors: [Color] = [
        Color.white,
        Color(red: 0.7, green: 0.7, blue: 1),
        Color(red: 0.5, green: 1, blue: 0.5),
        Color(red: 0.7, green: 0.7, blue: 0.2),
        Color(red: 1, green: 0, blue: 0)
    ]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("This View is Currently empty but will later contain STATS!!")
                    .multilineTextAlignment(.leading)
                
                Text("You worked out for \(yearDuration / 60) hours and \(yearDuration % 60) minutes this year!")
                    .multilineTextAlignment(.leading)
                    .onAppear() {
                        yearOfWorkouts()
                    }
                
                ScrollView(.horizontal) {
                    HStack(spacing: 2.5) {
                        ForEach(0...51, id: \.self) { i in
                            
                            
                            
                            VStack(spacing: 2.5) {
                                ForEach(0...6, id: \.self) { j in
                                    
                                    
                                    
                                    
                                    Rectangle()
                                        .frame(width: 10, height: 10)
                                        .onAppear() {
                                            activeDatecode += 1
                                            activeDatecode = makeValidDatecode(activeDatecode)
    
                                            workoutsToday = 0
                                            while yearDatecodes.contains(activeDatecode) {
                                                workoutsToday += 1
                                                yearDatecodes.remove(at: 0)
                                            }
    
    
                                        }
                                        .foregroundStyle(workoutsToday < 5 ? workoutColors[workoutsToday] : .red)
                                    
                                }
                            }
                            
                        }
                    } // End HStack for Weeks of Workouts
                } // End Horizontal ScrollView
                
                
            }
            
            // Same toolbar for all views
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    // Content View
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "list.dash")
                            .font(.system(size: 25))
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    // Add View
                    NavigationLink {
                        AddView(workouts: $workouts)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60, weight: .bold))
                            .offset(x: 0, y: -10)
                    }
                    
                    Spacer()
                    
                    // Stats View
                    Button {
                        // Do not need any code
                    } label: {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.system(size: 25))
                            .padding(.trailing)
                    }

                }
            } // End toolbar
            .navigationBarHidden(true)
        }
    }
    
    /// Finds all workouts from past year and adds them to yearWorkouts
    /// Adds all corresponding datecodes to yearDatecodes
    /// Sets yearStartCode to the date 52 weeks ago
    /// Finds the duration worked out in the past year
    func yearOfWorkouts() {
        
        yearWorkouts = []
        yearDatecodes = []
        yearDuration = 0
        
        yearStartCode = makeValidDatecode(todayDateCode - 100000 + 1)
        activeDatecode = yearStartCode
        
        
        
        if todayDateCode % 10000 >= 229 && isLeapYear(yearToday) || yearStartCode % 10000 <= 229 && isLeapYear(yearToday - 1) {
            yearStartCode += 1
        }
        
        
        for i in 0..<workouts.count {
            let workout = workouts[i]
            
            if workout.dateCode > todayDateCode - 10000 {
                yearWorkouts.append(workout)
                yearDuration += workout.hours * 60 + workout.minutes
            }
        }
        
        
        
        
        // Reverses the order of yearWorkouts
        for i in 0..<(yearWorkouts.count / 2) {
            var tempWorkout: Workout = yearWorkouts[i]
            yearWorkouts[i] = yearWorkouts[yearWorkouts.count - 1 - i]
            yearWorkouts[yearWorkouts.count - 1 - i] = tempWorkout
            
        }
        
        
        // Fills yearDateCodes with the datecodes corresponding to the year's workouts
        for i in 0..<yearWorkouts.count {
            print(yearWorkouts[i].dateCode)
            yearDatecodes.append(yearWorkouts[i].dateCode)
        }
        
        print(yearDatecodes)
        
        
    }
    
    /// Returns whether or not a year is a leap year
    func isLeapYear(_ year: Int) -> Bool {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
    }
    
    /// Returns whether or not an inputted datecode corresponds to a real date
    func isValidDatecode(_ datecode: Int) -> Bool {
        let month = (datecode % 10000) / 100
        
        // Returns false if month is invalid
        if !(month > 0 && month <= 12) {
            return false
        }
        
        // Special case, if February of a leap year, return false if date is > 29 or 0
        if month == 2 && isLeapYear(datecode / 10000) {
                return datecode % 100 > 0 && datecode % 100 <= 29
        } else {
            
            // Return true if date is >0 and less than the number of days in respective month
            return datecode % 100 > 0 && datecode % 100 <= daysInMonth[month - 1]
        }
    }

    
    /// Fixes invalid datecodes to make them correspond to a real day
    /// datecode - eight digit integer YYYYMMDD
    func makeValidDatecode(_ datecode: Int) -> Int {
        var year = datecode / 10000
        var month = (datecode % 10000) / 100
        var date = datecode % 100
        
        if isLeapYear(year) && month == 2 {
            if date > 29 {
                month = 3
                date = date - 29
            }
        } else {
            if date > daysInMonth[month - 1] {
                date = date - daysInMonth[month - 1]
                month += 1
            }
        }
        
        if month > 12 {
            month -= 12
            year += 1
        }
        
        if date == 0 {
            month -= 1
            
            if month <= 0 {
                month += 12
                year -= 1
            }
            
            if month == 2 && isLeapYear(year) {
                date = 29
            } else {
                date = daysInMonth[month - 1]
            }
        }
        
        var returnVal = year * 10000 + month * 100 + date
        
        // If datecode still is invalid, reruns function until it is valid
        if !isValidDatecode(returnVal) {
            returnVal = makeValidDatecode(returnVal)
        }

        
        return returnVal
        
    }
    
}

//#Preview {
//    StatsView()
//}
