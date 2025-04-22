//
//  AddView.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/15/25.
//

import SwiftUI

// Accesses Today's Date
let dateObject = Date()
let calendar = Calendar.current
let yearToday = calendar.component(.year, from: dateObject) // 2025
let monthToday = calendar.component(.month, from: dateObject) - 1 // 0 thru 11 for Jan thru Dec
let dateToday = calendar.component(.day, from: dateObject)

// IS THERE ALSO A WAY TO FIND DAY OF THE WEEK? 

struct AddView: View {
    @Binding var workouts: [Workout]
    
    // Variables YIPPEE!
    @State var userMood: Int = 0
    
    //@Binding var list:[Assignment]
    @Environment(\.dismiss) var dismiss
    @State var newAssignmentName = ""
    @State var newAssignmentSubj = ""
    @State var newAssignmentDay = dateToday
    @State var newAssignmentMonth = monthToday
    @State var newAssignmentYear = yearToday
    @State var newAssignmentHours = 0
    @State var newAssignmentMinutes = 30
    
    @StateObject var stopWatch = StopWatch()
    @State var stopWatchRunning = false
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    @State var pickerVal = 0
    
    var body: some View {
            
        NavigationStack {
        

            VStack(spacing: 0) {
                
                // Displays today's date
                Text("New Workout")
                    .bold()
                    .font(.title)
                    .padding(.bottom)
                
                Picker("", selection: $pickerVal) {
                    ForEach(0..<2, id: \.self) { index in
                        Text(index == 0 ? "Completed" : "Current")
                            .tag(index)
                            .font(.custom("Arial", size: 40))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: UIScreen.main.bounds.width - 80)
                
                
                // Workout details
                
                // MARK: Type
                Text("Type")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                
                TextField("Type of Workout", text: $newAssignmentName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                // MARK: Date
                Text("Date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                    .bold()
                
                HStack {
                    // Day
                    Picker("", selection: $newAssignmentDay) {
                        ForEach(1...31, id: \.self) {
                            index in
                            Text(String(index))
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 75, height: 100)
                    
                    // Date
                    Picker("", selection: $newAssignmentMonth) {
                        ForEach(0..<12, id: \.self) {
                            index in
                            Text(months[index])
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 100)
                    
                    // Year
                    Picker("", selection: $newAssignmentYear) {
                        ForEach(2025...3000, id: \.self) {
                            index in
                            Text(String(index))
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 100)
                }
                
                // MARK: Duration
                
                // If workout completed, show selector for duration
                if pickerVal == 0 {
                    
                    Text("Duration")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                        .bold()
                    
                    HStack {
                        // Hours
                        Picker("", selection: $newAssignmentHours) {
                            ForEach(0...23, id: \.self) {
                                index in
                                Text(String(index) + " hr")
                            }
                            
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 75, height: 100)
                        
                        // Minutes
                        Picker("", selection: $newAssignmentMinutes) {
                            ForEach(1...59, id: \.self) {
                                index in
                                Text(String(index) + " min")
                            }
                            
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 100)
                        
                    }
                } else { // Shows Timer to determine duration if workout is current
                    
                    HStack {
                        
                        Button() {
                            
                            if stopWatchRunning {
                                stopWatch.stop()
                            } else {
                                stopWatch.start()
                            }
                            
                            stopWatchRunning.toggle()
                            
                        } label: {
                            
                            Capsule()
                                .frame(width: 100, height: 50)
                                .foregroundStyle(stopWatchRunning ? .red : .green)
                                .overlay {
                                    Text(stopWatchRunning ? "Stop" : "Start")
                                        .font(.custom("Arial Bold", size: 30))
                                        .foregroundStyle(.white)
                                }
                        }
                        
                        Spacer()
                            .frame(width: 120)
                        
                        Text("\(stopWatch.hours)")
                        Text(":")
                        Text("\(stopWatch.minutes)")
                        Text(":")
                        Text("\(String(format: "%.1f", stopWatch.getSeconds()))")
                        
                        
                        
                    }
                    .foregroundStyle(.white)
                    
                }
                
                // MARK: Mood
                Text("Mood")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .bold()
                
                HStack {
                    let veryHappy = 0x1F601
                    let happy = 0x1F600
                    let neutral = 0x1F610
                    let sad = 0x1F641
                    let verySad = 0x1F614
                    
                    // Very sad
                    Button {
                        
                        userMood = 1
                        
                    } label: {
                        
                        Text(String(UnicodeScalar(verySad)!))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.gray.opacity(userMood == 1 ? 0.25 : 0))
                            .cornerRadius(20)
                            .font(.custom("very sad", size: 40))
                            
                    }
                    
                    // Sad
                    Button {
                        
                        userMood = 2
                        
                    } label: {
                        
                        Text(String(UnicodeScalar(sad)!))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.gray.opacity(userMood == 2 ? 0.25 : 0))
                            .cornerRadius(20)
                            .font(.custom("sad", size: 40))
                            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    
                    // Neutral
                    Button {
                        
                        userMood = 3
                        
                    } label: {
                        
                        Text(String(UnicodeScalar(neutral)!))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.gray.opacity(userMood == 3 ? 0.25 : 0))
                            .cornerRadius(20)
                            .font(.custom("neutral", size: 40))
                            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        
                    }
                    
                    // Happy
                    Button {
                        
                        userMood = 4
                        
                    } label: {
                        
                        Text(String(UnicodeScalar(happy)!))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.gray.opacity(userMood == 4 ? 0.25 : 0))
                            .cornerRadius(20)
                            .font(.custom("happy", size: 40))
                            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    
                    // Very happy
                    Button {
                        
                        userMood = 5
                        
                    } label: {
                        
                        Text(String(UnicodeScalar(veryHappy)!))
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color.gray.opacity(userMood == 5 ? 0.25 : 0))
                            .cornerRadius(20)
                            .font(.custom("very happy", size: 40))
                            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    
                }
                
                // MARK: Energy
                Text("Energy")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .bold()
                
                HStack {
                    let turtle = 0x1F422
                    let rabbit = 0x1F407
                    let personWalking = 0x1F6B6
                    
                    // Big snail (low energy)
                    Text(String(UnicodeScalar(turtle)!))
                        .font(.custom("turtle", size: 40))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .padding(.horizontal)
                    
                    // Small snail (some energy)
                    Text(String(UnicodeScalar(turtle)!))
                        .font(.custom("turtle", size: 30))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    
                    // Human (medium energy)
                    Text(String(UnicodeScalar(personWalking)!))
                        .font(.custom("human", size: 40))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .padding(.horizontal)
                    
                    // Small rabbit (more energy)
                    Text(String(UnicodeScalar(rabbit)!))
                        .font(.custom("rabbit", size: 30))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    
                    // Big rabbit (high energy)
                    Text(String(UnicodeScalar(rabbit)!))
                        .font(.custom("rabbit", size: 40))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .padding(.horizontal)
                    
                }
                
                // MARK: Reflection
                Text("Reflection (optional)")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                TextField("Enter text", text: $newAssignmentSubj)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .frame(width: 400)
                
                .navigationBarHidden(true)
                
            } // end of vstack
            
            // Same toolbar for all views
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    
                    NavigationLink {
                        ContentView()
                    } label: {
                        Image(systemName: "list.dash")
                            .font(.system(size: 25))
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                        // Dismiss view
                        dismiss()
                        
                    } label: {
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60, weight: .bold))
                            .offset(x: 0, y: -10)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        StatsView(workouts: $workouts)
                    } label: {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.system(size: 25))
                            .padding(.trailing)
                    }

                }
            } // End toolbar
            
        } // end of nav stack
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
            
    }
}

//#Preview {
//    AddView(workouts: $workouts)
//}
