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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AddView()
}
