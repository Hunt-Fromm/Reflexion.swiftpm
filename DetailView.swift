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
                
            } // End VStack
            
//            // Same toolbar for all views
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                        Image(systemName: "list.dash")
                            .font(.system(size: 25))
                            //.padding(.leading)
                    }
                    
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    // Content View
//                    NavigationLink {
//                        ContentView()
//                        //dismiss()
//                    } label: {
//                        Image(systemName: "list.dash")
//                            .font(.system(size: 25))
//                            .padding(.leading)
//                    }
//                    
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "list.dash")
//                            .font(.system(size: 25))
//                            .padding(.leading)
//                    }
//                    .offset(x: -144, y: 0)
                    
//                    Spacer()
//                    
//                    // Add View
//                    NavigationLink {
//                        AddView(workouts: $workouts)
//                    } label: {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.system(size: 60, weight: .bold))
//                            .offset(x: 0, y: -10)
//                    }
//                    
//                    Spacer()
//                    
//                    // Stats View
//                    NavigationLink {
//                        StatsView(workouts: $workouts)
//                    } label: {
//                        Image(systemName: "chart.xyaxis.line")
//                            .font(.system(size: 25))
//                            .padding(.trailing)
//                    }

                }
            } // End toolbar
            .navigationBarBackButtonHidden(true)
            
        }
        
    }
}

//#Preview {
//    DetailView(workout: Workout)
//}
