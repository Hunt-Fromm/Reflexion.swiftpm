//
//  DetailView.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/17/25.
//

import SwiftUI

struct DetailView: View {
    @Binding var workouts: [Workout]
    
    var workout: Workout
    
    // Makes dismissing possible
    @Environment(\.dismiss) var dismiss
    
    let appFont:String = "DINAlternate-Bold"
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("\(workout.descr)")
                    .font(.custom(appFont, size: 20))
                Text("\(workout.dateCode)")
                
                Text("Duration: \(workout.hours):\(workout.minutes) hr")
                    .font(.custom(appFont, size: 20))
                
                if workout.mood != 0 {
                    Text("Mood: \(workout.mood)")
                        .font(.custom(appFont, size: 20))
                }
                
                if workout.energy != 0 {
                    Text("Energy: \(workout.energy)")
                        .font(.custom(appFont, size: 20))
                }
                
                if workout.reflection != "" {
                    Text("Reflection: \(workout.reflection)")
                        .font(.custom(appFont, size: 20))
                    let reflLength:Double = Double(workout.reflection.count)*10
                    let reflHeight:Double = Double((workout.reflection.count)/50)*20 + 25
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 500, height: reflHeight)
                            .foregroundStyle(.red)
                        Rectangle()
                            .frame(width: reflLength, height: reflHeight)
                            .foregroundStyle(.cyan)
                        Text(workout.reflection)
                            .backgroundStyle(.black)
                        Text("\(reflHeight)")
                            .backgroundStyle(.black)
                    }
                    
                }
                
            } // End VStack
            
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.blue)
                            .font(.system(size: 20))
                            .bold()
                        Image(systemName: "list.dash")
                            .foregroundStyle(.blue)
                            .font(.system(size: 25))
                            .bold()
                    }
                    
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    

                }
            } // End toolbar
            .navigationBarBackButtonHidden(true)
            
        } // End of NavStack
        
    }
}

//#Preview {
//    DetailView(workout: Workout)
//}
