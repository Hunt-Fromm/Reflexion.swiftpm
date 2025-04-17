//
//  AddView.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/15/25.
//

import SwiftUI

// Accesses Today's Date
let dateObject = Date()
let calendar = Calendar.current
let yearToday = calendar.component(.year, from: dateObject) // 2025
let monthToday = calendar.component(.month, from: dateObject) // 1 thru 12 for Jan thru Dec
let dateToday = calendar.component(.day, from: dateObject)

// IS THERE ALSO A WAY TO FIND DAY OF THE WEEK? 

struct AddView: View {
    
    //@Binding var list:[Assignment]
    @Environment(\.dismiss) var dismiss
    @State var newAssignmentName = ""
    @State var newAssignmentSubj = ""
    @State var newAssignmentDay = 0
    @State var newAssignmentMonth = 0
    @State var newAssignmentYear = 0
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var body: some View {
            
        NavigationStack {
        

            VStack(spacing: 0) {
                
                // Displays today's date
                Text("New Workout")
                    .bold()
                    .font(.title)
                    .padding(.bottom)
                
                
                
                // Workout details
                
                // Type
                Text("Type")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                TextField("Type of Workout", text: $newAssignmentName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                // Date
                Text("Date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                HStack {
                    // Day
                    Picker("", selection: $newAssignmentDay) {
                        ForEach(1...31, id: \.self) {
                            index in
                            Text(String(index))
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 75, height: 100)
                    
                    // Date
                    Picker("", selection: $newAssignmentMonth) {
                        ForEach(0..<12, id: \.self) {
                            index in
                            Text(months[index])
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 150, height: 100)
                    
                    // Year
                    Picker("", selection: $newAssignmentYear) {
                        ForEach(2025...3000, id: \.self) {
                            index in
                            Text(String(index))
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 100)
                }
                
                // Duration
                Text("Duration")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                HStack {
                    // Hours
                    Picker("", selection: $newAssignmentDay) {
                        ForEach(0...23, id: \.self) {
                            index in
                            Text(String(index) + " hr")
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 75, height: 100)
                    
                    // Minutes
                    Picker("", selection: $newAssignmentMonth) {
                        ForEach(1...59, id: \.self) {
                            index in
                            Text(String(index) + " min")
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 100)
                    
                }
                
                // Energy
                Text("Energy")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                HStack {
                    let snail = 0x1F40C
                    let rabbit = 0x1F407
                    let personWalking = 0x1F6B6
                    
                    // Big snail (low energy)
                    Text(String(UnicodeScalar(snail)!))
                        .font(.custom("snail", size: 40))
                        .padding(.horizontal)
                    
                    // Small snail (some energy)
                    Text(String(UnicodeScalar(snail)!))
                        .font(.custom("snail", size: 30))
                        .padding(.leading)
                    
                    // Human (medium energy)
                    Text(String(UnicodeScalar(personWalking)!))
                        .font(.custom("human", size: 40))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .padding(.horizontal)
                    
                    // Small rabbit (more energy)
                    Text(String(UnicodeScalar(rabbit)!))
                        .font(.custom("rabbit", size: 30))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                    
                    // Big rabbit (high energy)
                    Text(String(UnicodeScalar(rabbit)!))
                        .font(.custom("rabbit", size: 40))
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .padding(.horizontal)
                    
                }
                
                // Reflection
                Text("Reflection (optional)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                TextField("Enter text", text: $newAssignmentSubj)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                
                
                // Mrs. Carlson, I know this looks ugly but I just wanted to be able to create an assignment. If I have time I will make it look nicer.
                
                Button {
                    //                        let newAssignment = Assignment(name:newAssignmentName, subject: newAssignmentSubj, dueDate: String("\(newAssignmentMonth)/\(newAssignmentDay)/\(newAssignmentYear)"))
                    //
                    //                        list.append(newAssignment)
                    
                    print("list appended!!")
                    
                    // clears vars
                    newAssignmentName = ""
                    newAssignmentSubj = ""
                    newAssignmentMonth = 0
                    newAssignmentDay = 0
                    newAssignmentYear = 0
                    
                    // Dismiss view
                    dismiss()
                    
                } label: {
                    
                    Label("", systemImage: "checkmark.circle.fill")
                        .font(.system(size:75, weight: .bold))
                    
                }
                
                
                .navigationBarHidden(true)
                
                
            }
            
        } // end of nav stack
        .foregroundStyle(.white)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            
    }
}

#Preview {
    AddView()
}
