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
    @State var list:[String] = []
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                // Title
                Text("\(workout.descr)")
                    .font(.custom(appFont, size: 35))
                    .frame(alignment: .top)
                
                Spacer()
                    .frame(height: 100)
                      
                // Duration
                VStack {
                    Text("Duration")
                        .font(.custom(appFont, size: 25))
                        .foregroundStyle(.blue)
                    
                    if workout.hours != 0 {
                        Text("\(workout.hours):\(workout.minutes) hr")
                            .font(.custom(appFont, size: 20))
                    }
                    else {
                        Text("\(workout.minutes) min")
                            .font(.custom(appFont, size: 20))
                    }
                } // end of VStack (duration)
                
                
                HStack {
                    VStack {
                        // Mood
                        
                        let veryHappy = 0x1F601
                        let happy = 0x1F600
                        let neutral = 0x1F610
                        let sad = 0x1F641
                        let verySad = 0x1F614
                        
                        if workout.mood != 0 {
                            
                            Text("Mood")
                                .font(.custom(appFont, size: 25))
                                .foregroundStyle(.blue)
                            
                            if workout.mood == 1 {
                                Text(String(UnicodeScalar(verySad)!))
                                    .font(.custom(appFont, size: 50))
                            }
                            else if workout.mood == 2 {
                                Text(String(UnicodeScalar(sad)!))
                                    .font(.custom(appFont, size: 50))
                            }
                            else if workout.mood == 3 {
                                Text(String(UnicodeScalar(neutral)!))
                                    .font(.custom(appFont, size: 50))
                            }
                            else if workout.mood == 4 {
                                Text(String(UnicodeScalar(happy)!))
                                    .font(.custom(appFont, size: 50))
                            }
                            else {
                                Text(String(UnicodeScalar(veryHappy)!))
                                    .font(.custom(appFont, size: 50))
                            }
                            
                        }
                    } // end of VStack (mood)
                    
                    Spacer()
                        .frame(width: 150)
                    
                    VStack {
                        // Energy
                        
                        let turtle = 0x1F422
                        let rabbit = 0x1F407
                        let personWalking = 0x1F6B6
                        
                        if workout.energy != 0 {
                            
                            Text("Energy")
                                .font(.custom(appFont, size: 25))
                                .foregroundStyle(.blue)
                            
                            if workout.energy == 1 {
                                Text(String(UnicodeScalar(turtle)!))
                                    .font(.custom(appFont, size: 50))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                            }
                            else if workout.energy == 2 {
                                Text(String(UnicodeScalar(turtle)!))
                                    .font(.custom(appFont, size: 40))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                                    .padding(1)
                            }
                            else if workout.energy == 3 {
                                Text(String(UnicodeScalar(personWalking)!))
                                    .font(.custom(appFont, size: 50))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                            }
                            else if workout.energy == 4 {
                                Text(String(UnicodeScalar(rabbit)!))
                                    .font(.custom(appFont, size: 40))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                                    .padding(1)
                            }
                            else {
                                Text(String(UnicodeScalar(rabbit)!))
                                    .font(.custom(appFont, size: 50))
                                    .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                            }
                            
                        }
                    } // end of VStack (energy)
                } // end of HStack (emoji)
                
                if workout.reflection != "" {
                    Text("Reflection:")
                        .font(.custom(appFont, size: 25))
                        .foregroundStyle(.blue)
                        .frame(alignment: .leadingFirstTextBaseline)
                        //.padding(.horizontal)

                    @State var reflection = "\(workout.reflection)" // need this bc TextEditor requires an @State var
                                        
                    // Multiline text input
                    TextEditor(text: $reflection)
                        .frame(height: 200)
                        .border(Color.blue, width: 4)
                        .padding(.horizontal)
                        .font(.custom(appFont, size: 20))
                    
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
        let end = (refl.count > 50) ? refl.index(refl.startIndex, offsetBy: 50) : refl.index(refl.endIndex, offsetBy: 0)
        let part = String(reflection[start..<end])
        print(part)
        print("new line")
        list.append(part)
    }
    
    return list
}

//#Preview {
//    DetailView(workouts: workout[0])
//}
