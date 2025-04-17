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
                        .underline()
                    
                    HStack {
                        
                        //
                        Spacer()
                            .frame(width: 20)
                        
                        VStack {
                            
                            ForEach(0..<workouts.count, id: \.self) { index in
                                
                                let workout = workouts[index]
                                
                                Button() {
                                    // DetailView()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(lineWidth: 3)
                                            .foregroundStyle(.blue)
                                        Text("\(workout.type) - \(workout.month)/\(workout.date)/\(String(workout.year).prefix(1))\(String(workout.year).suffix(3))")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundStyle(.black)
                                            .padding(4)
                                            .offset(x: 5)
                                            
                                    }
                                }
                                
                            }
                            
                        } // End VStack
                        
                        Spacer()
                            .frame(width: 200)
                        
                    } // End HStack
                    
                    Spacer()
                    
                    
                    
                } // End ScrollView
            } // End VStack
        } // End NavStack
        
        
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
