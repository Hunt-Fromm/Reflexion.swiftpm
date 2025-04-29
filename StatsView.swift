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
    
    // Number of minutes the user worked out this year
    @State var yearDuration = 0
    
    @State var yearStartCode = 0
    
    let daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let todayDateCode = yearToday * 10000 + monthToday * 100 + dateToday
    
    
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
                
                HStack(spacing: 2.5) {
                    ForEach(0...51, id: \.self) { i in
                        
                        
                        
                        VStack(spacing: 2.5) {
                            ForEach(0...6, id: \.self) { j in
                                
                                let thisDayCode =
                                
                                Rectangle()
                                    .frame(width: 5, height: 5)
                                    .foregroundStyle(.white)
                                
                            }
                        }
                        
                    }
                }
                
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
    
    func yearOfWorkouts() {
        
        yearWorkouts = []
        yearDuration = 0
        
        yearStartCode = todayDateCode - 100000 + 1
        
        
        
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
        
        
        
    }
    
    func isLeapYear(_ year: Int) -> Bool {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
    }
    
    func isValidDatecode(datecode: Int) -> Bool {
        let month = (datecode / 10000) % 100
        
        if month == 2 {
            
            if isLeapYear(datecode / 10000) {
                return datecode % 100 > 0 && datecode % 100 <= 29
            } else {
                return datecode % 100 > 0 && datecode % 100 <= 28
            }
            
        } else {
            return datecode % 100 > 0 && datecode % 100 <= daysInMonth[month - 1]
        }
    }
    
    // MARK: Hunter continues from here
    func makeValidDatecode(datecode: Int) -> Int {
        var year = datecode / 10000
        var month = (datecode % 10000) / 100
        var date = datecode % 100
        
        if isLeapYear(year) && month == 2 {
            if date > 29 {
                month = 3
                date = date - 29
            }
        }
        
        return year * 10000 + month * 100 + date
        
    }
    
}

//#Preview {
//    StatsView()
//}
