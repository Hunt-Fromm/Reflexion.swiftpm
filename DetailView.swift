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
                
                var list:[String] = []
                
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
                        .onAppear {
                            list = createTextBox(reflection: workout.reflection)
                            print("hello")
                        }
                    
                    let reflLength:Double = Double(workout.reflection.count)*10
                    let reflHeight:Double = Double((workout.reflection.count)/35)*20 + 25
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 350, height: reflHeight)
                            .foregroundStyle(.red)
                        Rectangle()
                            .frame(width: reflLength, height: reflHeight)
                            .foregroundStyle(.cyan)
//                        Text(workout.reflection)
//                            .backgroundStyle(.black)
//                        
                        
                    }
                    
                    Text("\(reflHeight)")
                        .backgroundStyle(.black)
                    
                    List(list.indices, id: \.self) { // MARK: IM OVER HERE  PLS FINISH!
                        index in
                        Text("\(index) IM OVER HERE")
                            .backgroundStyle(.white)
                        Text(list[index])
                            .backgroundStyle(.white)
                    }
                    
                } // end of if statement
                
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
    } // End of body
}

func createTextBox(reflection: String) -> [String] {
        
    var list:[String] = []
    
    let refl = reflection
    
    for i in 1...(reflection.count/35) {
        print(i)
        let start = refl.index(refl.startIndex, offsetBy: 0)
        let end = (refl.count > 100) ? refl.index(refl.startIndex, offsetBy: 100) : refl.index(refl.startIndex, offsetBy: refl.count)
        let part = String(reflection[start..<end])
        print(part)
        print("new line")
        list.append(part)
    }
    
    return list
}

//#Preview {
//    DetailView(workout: Workout)
//}
