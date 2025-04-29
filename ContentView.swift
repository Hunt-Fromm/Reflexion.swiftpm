import SwiftUI

struct ContentView: View {
    // Workouts list currently filled with sample workouts
    @State var workouts: [Workout] = [
        Workout(type: "Run", dayOfTheWeek: "Tuesday", date: 15, month: 4, year: 2025, hours: 0, minutes: 30, mood: 4, energy: 2, reflection: "test test test test test test test test test test test test test test test test test test"),
        Workout(type: "Yoga", date: 17, month: 4, year: 2025),
        Workout(type: "Bike", date: 16, month: 4, year: 2025),
        Workout(type: "Hike", date: 16, month: 5, year: 2025)
    ]
    
    @State var workoutsByMonth: [[Workout]] = []
    
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let appFont:String = "DINAlternate-Bold"
    
    
    var body: some View {
        
        // Navigation Stack to which toolbar is applied
        NavigationStack {
            
            VStack {
                Text("Workout Log")
                    .font(.custom(appFont, size: 40))
                    .onAppear {
                        sortWorkoutsByMonth()
                    }
                
                
                // Scrollview holding this page's data
                ScrollView {
                    
                    // Only runs if workoutsByMonth list isn't empty
                    if workoutsByMonth != [] {
                        
                        // Accesses sublist of workouts by month
                        ForEach(0..<workoutsByMonth.count, id: \.self) { i in
                            
                            let month = workoutsByMonth[i][0].month
                            let year = workoutsByMonth[i][0].year
                            let yearStr = String(year)
                            
                            Text("\(months[month - 1]) \(yearStr.prefix(1))\(yearStr.suffix(3))")
                                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                                .fontWeight(.bold)
                                .underline()
                                .font(.custom(appFont, size: 20))
                            
                            
                            HStack {
                                
                                //
                                Spacer()
                                    .frame(width: 20)
                                
                                VStack {
                                    
                                    // Access each workout in a month
                                    ForEach(0..<workoutsByMonth[i].count, id: \.self) { j in
                                        
                                        let workout = workoutsByMonth[i][j]
                                        
                                        NavigationLink(destination: {
                                            DetailView(workouts: $workouts, workout: workout)
                                        }, label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(lineWidth: 3)
                                                    .foregroundStyle(.blue)
                                                Text("\(workout.descr)")
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .padding(4)
                                                    .offset(x: 5)
                                                    .font(.custom(appFont, size: 18))
                                                    
                                            }
                                        })
                                        
                                    } // End ForEach giving each workout index in a given month
                                    
                                    Spacer()
                                        .frame(height: 30)
                                    
                                } // End VStack
                                
                                Spacer()
                                    .frame(width: 200)
                                
                            }
                            
                            
                            
                        } // end ForEach statement regarding each month
                        
                    } // end if statement
                    
                    /*
                    // This TextView is to be changed later
                    Text("April 2025")
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        .fontWeight(.bold)
                        .underline()
                    
                    HStack {
                        
                        //
                        Spacer()
                            .frame(width: 20)
                        
                        VStack {
                            
                            ForEach(0..<workouts.count, id: \.self) { index in
                                
                                let workout = workouts[index]
                                
                                NavigationLink(destination: {
                                    DetailView(workouts: $workouts, workout: workouts[index])
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(lineWidth: 3)
                                            .foregroundStyle(.blue)
                                        Text("\(workout.descr)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(4)
                                            .offset(x: 5)
                                            
                                    }
                                })
                                
                            }
                            
                        } // End VStack
                        
                        Spacer()
                            .frame(width: 200)
                        
                    }
                    
                    Spacer()
                     */
                    
                    
                    
                } // End ScrollView
            } // End VStack
        
            // Same toolbar for all views
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    // Content View
                    Button {
                        // Do not need any code
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
                    NavigationLink {
                        StatsView(workouts: $workouts)
                    } label: {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.system(size: 25))
                            .padding(.trailing)
                    }

                }
            } // End toolbar
            
        } // End NavStack
        
        // Changes background/theme
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)

        
        
    }
    
    /// Sorts Workout Objects in 'workouts' in chronological order
    func sortWorkouts() {
        var temp: Workout
        
        
        for i in 0..<workouts.count {
            
            var maxIndex = i
            
            for j in i..<workouts.count {
                
                if workouts[j].dateCode > workouts[maxIndex].dateCode {
                    maxIndex = j
                }
                
            }
            
            if maxIndex != i {
                temp = workouts[maxIndex]
                workouts[maxIndex] = workouts[i]
                workouts[i] = temp
            }
            
            
        }
        
        
        
    }
    
    
    func sortWorkoutsByMonth() {
        workoutsByMonth = []
        
        // Sorting workouts in reverse chronological order
        sortWorkouts()
        // End sorting workouts in reverse chronological order
        
        
        
        // Start list containing datecode for each month with logged workout
        var monthCodes: [Int] = []
        
        for i in 0..<workouts.count {
            if !monthCodes.contains(workouts[i].dateCode / 100) {
                monthCodes.append(workouts[i].dateCode / 100)
            }
        }
        // End creating list for each relevant month's datecode
        
        
        // Start organizing workouts into a list of list, each 1D item is a list of workouts from a specific month and each 2D item is a workout object
                
        for i in 0..<monthCodes.count {
            
            
            let monthCode = monthCodes[i]
            var thisMonthWorkouts: [Workout] = []
            
            
            for j in 0..<workouts.count {
                
                
                // If selected workout is from desired month...
                if workouts[j].dateCode / 100 == monthCode {
                    
                    thisMonthWorkouts.append(workouts[j])
                }
                 
                
            }
            
            
            workoutsByMonth.append(thisMonthWorkouts)
        }
         
        
    }
    
    
}

//#Preview {
//    ContentView()
//}
