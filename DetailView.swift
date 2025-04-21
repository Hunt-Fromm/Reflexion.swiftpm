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
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("\(workout.descr)")
                
            } // End VStack
            
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
                    
                    NavigationLink {
                        AddView(workouts: $workouts)
                    } label: {
                        Image(systemName: "plus.circle.fill")
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
            .navigationBarHidden(true)
            
        }
        
    }
}

//#Preview {
//    DetailView(workout: Workout)
//}
