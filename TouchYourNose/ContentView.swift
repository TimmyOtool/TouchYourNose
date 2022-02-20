//
//  ContentView.swift
//  TouchYourNose
//
//  Created by Michael Melin on 20/02/2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        
        
        
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }.frame(width: 300, height: 50, alignment: .center).font(.system(size: 33))

            
 
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Touch Your Nose"
                
                content.sound = UNNotificationSound.default

                for i in 0...24 {
     
                // Setup trigger time
                var date = DateComponents()
                date.hour = i
                date.minute = i
                    
                    content.subtitle = "It's "+date.hour+":"+date.minute
                    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

                // Create request
                let uniqueID = UUID().uuidString // Keep a record of this if necessary
                let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
    
    
                // add our notification request
                UNUserNotificationCenter.current().add(request)
                }
            }.frame(width: 300, height: 50, alignment: .center).font(.system(size: 33))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
