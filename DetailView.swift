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
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                // Type
                Text("\(workout.type)")
                    .font(.custom(appFont, size: 50))
                
                // Date
                Text("\(months[workout.month-1]) \(workout.date), " + String(workout.year))
                    .font(.custom(appFont, size: 20))

                
                Spacer()
                    .frame(height: 100)
                      
                
                
                
                HStack {
                    
                    // Duration
                    VStack {
                        Text("Duration")
                            .font(.custom(appFont, size: 25))
                            .padding(.bottom)
                        
                        if workout.hours != 0 {
                            Text("\(workout.hours):\(workout.minutes) hr")
                                .font(.custom(appFont, size: 25))
                                .padding(.top)
                        }
                        else {
                            Text("\(workout.minutes) min")
                                .font(.custom(appFont, size: 25))

                        }
                    } // end of VStack (duration)
                    
                    Spacer()
                        .frame(width: 50)
                    
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
                        .frame(width: 50)
                    
                    VStack {
                        // Energy
                        
                        let turtle = 0x1F422
                        let rabbit = 0x1F407
                        let personWalking = 0x1F6B6
                        
                        if workout.energy != 0 {
                            
                            Text("Energy")
                                .font(.custom(appFont, size: 25))
                            
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
                
                //if workout.reflection != "" {
                    Text("Reflection:")
                        .font(.custom(appFont, size: 25))
                        .frame(alignment: .leadingFirstTextBaseline)
                        //.padding(.horizontal)

                    @State var reflection = "\(workout.reflection)" // need this bc TextEditor requires an @State var
                                        
                    // Multiline text input
                    TextEditor(text: $reflection)
                        .frame(height: 200)
                        .border(Color.gray, width: 4)
                        .padding(.horizontal)
                        .font(.custom(appFont, size: 20))
                    
               // } // end of if statement
                
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


//#Preview {
//    DetailView(workouts: workout[0])
//}
