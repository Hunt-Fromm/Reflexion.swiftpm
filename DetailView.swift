//
//  DetailView.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/17/25.
//

import SwiftUI

struct DetailView: View {
    var workout: Workout
    
    var body: some View {
        Text("\(workout.descr)")
    }
}

//#Preview {
//    DetailView(workout: Workout)
//}
