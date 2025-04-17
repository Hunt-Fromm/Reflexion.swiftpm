import SwiftUI

struct ContentView: View {
    @State var workouts: [Workout] = [Workout(type: "Run", dayOfTheWeek: "Tuesday", date: 15, month: 4, year: 2025, hours: 0, minutes: 30, mood: 4, energy: 2, reflection: "")]
    
    var body: some View {
        
        // Navigation Stack to which toolbar is applied
        NavigationStack {
            
            VStack {
                Text("Workout Log")
                    .font(.custom("Arial Bold", size: 40))
                
                // Scrollview holding this page's data
                ScrollView {
                    
                    // This TextView is to be changed later
                    Text("April 2025")
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        .fontWeight(.bold)
                    
                    
                    
                    ForEach(0..<workouts.count, id: \.self) { index in
                        
                        let workout = workouts[index]
                        
                        Text("\(workout.type) - \(workout.month)/\(workout.date)/\(workout.year)")
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                    Spacer()
                    
                    
                    
                } // End ScrollView
            } // End VStack
        } // End NavStack
        
        // Changes background/theme
        .foregroundColor(.white)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)

        
        
    }
    
    // Bare bones of sortWorkouts function
    func sortWorkouts() {
        var temp: Workout
        
        
        for i in 0..<workouts.count {
            
            var minIndex = i
            
            for j in i..<workouts.count {
                
                if workouts[j].dateCode < workouts[minIndex].dateCode {
                    minIndex = j
                }
                
            }
            
            if minIndex != i {
                temp = workouts[minIndex]
                workouts[minIndex] = workouts[i]
                workouts[i] = temp
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
