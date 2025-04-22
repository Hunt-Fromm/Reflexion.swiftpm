//
//  StopWatch.swift
//  Reflexion
//
//  Created by Frommelt, Hunter (512131) on 4/23/25.
//

import SwiftUI

class StopWatch: ObservableObject { // ObservableObject means that other views are always listening
    
    // Instance Variables
    @Published var seconds = 0.0 // Should instead be : Double
    @Published var minutes = 0 // Should Instead be : Int
    @Published var hours = 0 // Should Instead be : Int
    
    private var timer: Timer? //Not creating the Timer just yet...
    
    
    // StopWatch Constructor
    init() {
        reset()
        
//        seconds = 0.0
//        minutes = 0
//        hours = 0
    }
    
    init(hours: Int, minutes: Int, seconds: Double) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    
    
    func reset() {
        stop()
        
        seconds = 0.0
        minutes = 0
        hours = 0
    }
    
    func getSeconds() -> Double {
        return seconds
    }
    
    func getMinutes() -> Int {
        return minutes
    }
    
    func getHours() -> Int {
        return hours
    }
    
    
    func start() {
        timer?.invalidate() // Removes any pre-existing timers (if this function was called before)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.seconds += 0.1
            
            if self.seconds >= 60.0 {
                self.seconds -= 60.0
                self.minutes += 1
            }
            
            if self.minutes >= 60 {
                self.minutes -= 60
                self.hours += 1
            }
        })
        
        
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

