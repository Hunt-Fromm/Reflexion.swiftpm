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
    @State var durationToday = 0
    @State var workoutColors: [Color] = []
    
    let daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let todayDateCode = yearToday * 10000 + monthToday * 100 + dateToday
    
    @Binding var darkMode: Bool
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("You worked out for \(yearDuration / 60) hours and \(yearDuration % 60) minutes this year!")
                    .multilineTextAlignment(.leading)
                    .padding(15)
                    .onAppear() {
                        yearOfWorkouts()
                    }
                
                // Only runs if workoutColors has 7*52 indecies, then calls YearReviewView
                if workoutColors.count == 364 {

                    HStack {
                        Spacer()
                            .frame(width: 20)
                        
                        ZStack {
                            YearReviewView(startingDatecode: yearStartCode, workoutColors: workoutColors, yearWorkouts: yearWorkouts, yearDatecodes: yearDatecodes, isLeapYear: isLeapYear(_:), makeValidDatecode: makeValidDatecode(_:), darkMode: $darkMode)
                            
                            
                        }
                        
                    }
                        
                    
                }
                
                Spacer()
                    .frame(height: 50)
                    
                
                HStack {
                    
                    // Does it look better with or without this spacing?
                    Spacer()
                        .frame(width: 30)
                    
                    // Contains mood meter graph axes, gridlines, and points
                    ZStack {
                        
                        // Axis Label for Energy
                        HStack {
                            
                            Image(systemName: "arrow.left")
                            
                            Text("Energy")
                            
                            Image(systemName: "arrow.right")
                            
                        }
                        .font(.custom("Arial Bold", size: 20))
                        .rotationEffect(Angle(degrees: -90))
                        .offset(x: -120)
                        
                        // Axis Label for Mood
                        HStack {
                            
                            Image(systemName: "arrow.left")
                            
                            Text("Mood")
                            
                            Image(systemName: "arrow.right")
                            
                        }
                        .font(.custom("Arial Bold", size: 20))
                        .offset(y: 120)
                        
                        
                        
                        // Horizontal Center line of graph
                        VStack {
                            Spacer()
                                .frame(height: 98)
                            
                            Rectangle()
                                .frame(width: 200, height: 4)
                            
                            Spacer()
                                .frame(height: 98)
                        }
                        
                        
                        // Vertical Center line of graph
                        HStack {
                            Spacer()
                                .frame(width: 98)
                            
                            Rectangle()
                                .frame(width: 4, height: 200)
                            
                            Spacer()
                                .frame(width: 98)
                        }
                        
                        // Plots Average Data point on graph
                        HStack {
                            let avgPoint: CGPoint = findAvgMoodEnergy()
                            
                            Spacer()
                                .frame(width: CGFloat(92 + avgPoint.x))
                            
                            VStack {
                                Spacer()
                                    .frame(height: CGFloat(92 - avgPoint.y))
                                
                                Rectangle()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.cyan)
                                
                                Spacer()
                                    .frame(height: CGFloat(92 + avgPoint.y))
                            }
                            
                            Spacer()
                                .frame(width: CGFloat(92 - avgPoint.x))
                        }
                        
                        
                        // Plots Each Data point on the graph
                        
                        ForEach($workouts, id: \.self) { workout in
                            let workout: Workout = workout.wrappedValue
                            let xOffset = -120 + 40 * workout.mood
                            let yOffset = -120 + 40 * workout.energy
                            let randomY = Int.random(in: -10...10)
                            let randomX = Int.random(in: -10...10)
                            
                            // Sets color
                            let color: Color =
                            yOffset > 0 ? (xOffset < 0 ? Color(red: 1, green: 0.5, blue: 0.5) : xOffset == 0 ? Color(red: 1, green: 0.75, blue: 0.5) : Color(red: 1, green: 1, blue: 0.5)) :
                            yOffset == 0 ? (xOffset < 0 ? Color(red: 0.5, green: 1, blue: 1) : xOffset == 0 ? Color(red: 0.5, green: 0.5, blue: 0.5) : Color(red: 0.75, green: 1, blue: 0.5)) :
                            (xOffset < 0 ? Color(red: 0.5, green: 0.5, blue: 1) : xOffset == 0 ? Color(red: 0.5, green: 1, blue: 1) : Color(red: 0.5, green: 1, blue: 0.5))
                            
                            
                            
                            
                            HStack {
                                Spacer()
                                    .frame(width: CGFloat(xOffset + 96 + randomX))
                                
                                VStack {
                                    Spacer()
                                        .frame(height: CGFloat(96 - yOffset - randomY))
                                    
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundColor(color)
                                    
                                    Spacer()
                                        .frame(height: CGFloat(96 + yOffset + randomY))
                                }
                                
                                Spacer()
                                    .frame(width: CGFloat(96 - xOffset - randomX))
                            }
                            
                        }
                        
                        
                        
                    } // End ZStack
                    .frame(width: 200, height: 200)
                    .foregroundStyle(darkMode ? .white : . black)
                    
                }
//                .background(.cyan)
                
            } // End VStack
            
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
                    
                    // Add View, upon dimissal, runs yearOfWorkouts()
                    NavigationLink(destination: AddView(workouts: $workouts, didDismiss: {
                        workoutColors = []
//                        yearWorkouts = [Workout(type: "1", date: 1, month: 5, year: 2025)]
                        yearOfWorkouts()
                    }, darkMode: $darkMode)) {
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
        
        
        activeDatecode = yearStartCode
        
        workoutColors = []
        for _ in 1...364 {
            workoutColors.append(Color(red: 1, green: 1, blue: 1))
        }
        
        
        // Sets the value of yearStartCode to 364 days ago (52 weeks ago)
        yearStartCode = makeValidDatecode(todayDateCode - 10000 + 1)
        if todayDateCode % 10000 >= 229 && isLeapYear(yearToday) || yearStartCode % 10000 <= 229 && isLeapYear(yearToday - 1) {
            yearStartCode += 1
        }
        
        for i in 0..<workouts.count {
            let workout = workouts[i]
            
            if workout.dateCode > yearStartCode {
                yearWorkouts.append(workout)
                yearDuration += workout.hours * 60 + workout.minutes
            }
        }
        
        
        
        // Reverses the order of yearWorkouts
        for i in 0..<(yearWorkouts.count / 2) {
            let tempWorkout: Workout = yearWorkouts[i]
            yearWorkouts[i] = yearWorkouts[yearWorkouts.count - 1 - i]
            yearWorkouts[yearWorkouts.count - 1 - i] = tempWorkout
            
        }
        
        
        // Fills yearDateCodes with the datecodes corresponding to the year's workouts
        for i in 0..<yearWorkouts.count {
            yearDatecodes.append(yearWorkouts[i].dateCode)
        }

        
        
        
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
    
    func findAvgMoodEnergy() -> CGPoint {
        var mood = 0.0
        var energy = 0.0
        
        for i in 0..<workouts.count {
            let workout = workouts[i]
            
            mood += Double(workout.mood) - 3
            energy += Double(workout.energy) - 3
            
        }
        
        
        mood = mood / Double(workouts.count) * 40
        energy = energy / Double(workouts.count) * 40
        
        
        return CGPoint(x: mood, y: energy)
    }
    
}

//#Preview {
//    StatsView()
//}
