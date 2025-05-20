import SwiftUI
import SwiftData

struct ContentView: View {
    // Workouts list currently filled with sample workouts
    @State var workouts: [Workout] = [
        Workout(type: "Run", dayOfTheWeek: "Tuesday", date: 15, month: 4, year: 2025, hours: 0, minutes: 30, mood: 4, energy: 2, reflection: "test test test test test test test test test test test test test test test test test test"),
        Workout(type: "Yoga", date: 17, month: 4, year: 2025),
        Workout(type: "Bike", date: 16, month: 4, year: 2025),
        Workout(type: "Hike", date: 16, month: 5, year: 2025),
        Workout(type: "Run", dayOfTheWeek: "Wednesday", date: 7, month: 5, year: 2025, hours: 1, minutes: 20, mood: 4, energy: 4, reflection: "")
    ]
        
    // This object holds the persistent workouts list and is accessable and editable from views
    @StateObject var workoutsViewModel = WorkoutsViewModel()
    
    @State var workoutsByMonth: [[Workout]] = []
    
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let appFont:String = "DINAlternate-Bold"
    
    @State var darkMode: Bool = true
    
    var body: some View {
        
        // Navigation Stack to which toolbar is applied
        NavigationStack {
            
            VStack {
                ZStack {
                    Text("Workout Log")
                        .font(.custom(appFont, size: 40))
                        .foregroundStyle(darkMode ? .white : . black)
                        .onAppear {
                            workoutsViewModel.retreiveWorkouts()
                            workouts = workoutsViewModel.workouts
                            
                            sortWorkoutsByMonth()
                        }
                    
                    // Clickable settings icon
                    HStack {
                        
                        Spacer()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                        
                            
                        NavigationLink {
                            SettingsView(workouts: $workouts, workoutsViewModel: workoutsViewModel, sortWorkoutsByMonth: sortWorkoutsByMonth(), darkMode: $darkMode)
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 25))
                                .padding(.leading)
                        }
                        .offset(y: -20)
                        
                        Spacer()
                            .frame(maxWidth: 30, maxHeight: 1)
                        
                    }
                    
                    
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
                                .foregroundStyle(darkMode ? .white : . black)
                            
                            
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
                                                    .foregroundStyle(darkMode ? .white : . black)
                                                    
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
                    
                    else {
                        Text("You haven't created any workouts yet.\nAdd one to get started!")
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .font(.custom(appFont, size: 20))
                    }
                    
                    
                    
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
                        AddView(workouts: $workouts, didDismiss: {sortWorkoutsByMonth()}, darkMode: $darkMode)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60, weight: .bold))
                            .offset(x: 0, y: -10)
                    }
                    
                    Spacer()
                    
                    // Stats View
                    NavigationLink {
                        StatsView(workouts: $workouts, darkMode: $darkMode)
                    } label: {
                        Image(systemName: "chart.xyaxis.line")
                            .font(.system(size: 25))
                            .padding(.trailing)
                    }

                }
            } // End toolbar
            
            
        } // End NavStack
        
        // Injects persistent data into the environment so it is usable
        .environmentObject(workoutsViewModel)
        
        // Changes background/theme
        .foregroundStyle(darkMode ? .white : . black)
        .preferredColorScheme(darkMode ? .dark : .light)
        .navigationBarHidden(true)

        
        
    }
    
    
    
    /// Sets the Value of workoutsByMonth to a 2D Array of workouts, each internal array representing a different month, in reverse chronological order
    func sortWorkoutsByMonth() -> Void {
        workoutsByMonth = []
        
        // Sorting workouts in reverse chronological order
        sortWorkouts(&workouts)
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


/// Sorts Workout Objects in 'workouts' in chronological order
/// Because workouts is an inout variable, parameter needs to be called as '&workout'
func sortWorkouts(_ workouts: inout [Workout]) {
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


func determineDayOfWeek(year: Int, month: Int, date: Int) -> Int {
    let monthCodes: [Int] = [0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5]
    
    
    return ( (date + monthCodes[month - 1] + (year - 1) / 100 + (year / 100) / 4) ) % 7
}

func determineDayOfWeek(_ datecode: Int) -> Int {
    return determineDayOfWeek(year: datecode / 10000, month: datecode % 10000 / 100, date: datecode % 100)
}

//#Preview {
//    ContentView()
//}
