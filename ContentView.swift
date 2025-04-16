import SwiftUI

struct ContentView: View {
    @State var workouts: [Workout] = []
    
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
                    
                    Spacer()
                    
                    
                    
                } // End ScrollView
            } // End VStack
        } // End NavStack
        
        
    }
    
    // Bare bones of sortWorkouts function
    func sortWorkouts() {
        var temp: Workout
        
        for i in 0..<workouts.count {
            
            for j in i..<workouts.count {
                
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
