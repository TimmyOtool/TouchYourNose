//
//  ContentView.swift
//  TouchYourNose
//
//  Created by Michael Melin on 20/02/2022.
//

import SwiftUI
import UserNotifications


struct ContentView: View {

   @StateObject private var prefs = Prefs()
   @State private var viewID: Int = 0
    
    var body: some View {
        
        VStack {
            
            Group{
                HStack{
                    VStack{
                        
                        Toggle("00:00", isOn: $prefs.HToggle[0])
                        Toggle("01:01", isOn: $prefs.HToggle[1])
                        Toggle("02:02", isOn: $prefs.HToggle[2])
                        Toggle("03:03", isOn: $prefs.HToggle[3])
                        Toggle("04:04", isOn: $prefs.HToggle[4])
                        Toggle("05:05", isOn: $prefs.HToggle[5])
                        Toggle("06:06", isOn: $prefs.HToggle[6])
                        Toggle("07:07", isOn: $prefs.HToggle[7])
                        
                    }.border(Color.green, width: 1)
                    VStack{
                        Toggle("08:08", isOn: $prefs.HToggle[8])
                        Toggle("09:09", isOn: $prefs.HToggle[9])
                        Toggle("10:10", isOn: $prefs.HToggle[10])
                        Toggle("11:11", isOn: $prefs.HToggle[11])
                        Toggle("12:12", isOn: $prefs.HToggle[12])
                        Toggle("13:13", isOn: $prefs.HToggle[13])
                        Toggle("14:14", isOn: $prefs.HToggle[14])
                        Toggle("15:15", isOn: $prefs.HToggle[15])
                    }.border(Color.green, width: 2)
                    
                    VStack{
                        Toggle("16:16", isOn: $prefs.HToggle[16])
                        Toggle("17:17", isOn: $prefs.HToggle[17])
                        Toggle("18:18", isOn: $prefs.HToggle[18])
                        Toggle("19:19", isOn: $prefs.HToggle[19])
                        Toggle("20:20", isOn: $prefs.HToggle[20])
                        Toggle("21:21", isOn: $prefs.HToggle[21])
                        Toggle("22:22", isOn: $prefs.HToggle[22])
                        Toggle("23:23", isOn: $prefs.HToggle[23])
                    }.border(Color.green, width: 2)
                }.id(viewID)
            }
            
           /* Button("GetNoti"){
                
                print("-----------------------")
                let center = UNUserNotificationCenter.current()
                center.getPendingNotificationRequests(completionHandler: { requests in
                    for request in requests {
                        print(request)
                    }
                    
                })
                print("-----------------------")
                
            }*/

           /* Button("DebugNot") {
                notiAsk()
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                content.title = "Touch Your Nose"
                content.badge = true
                content.sound = UNNotificationSound.default

                
                var calendar = Calendar.current
                calendar.timeZone = TimeZone.current
                var date = Date()
                let testDate1 = calendar.dateComponents(
                    [.calendar, .timeZone,
                     .era, .quarter,
                     .year, .month, .day,
                     .hour, .minute, .second , .nanosecond,
                     .weekday, .weekdayOrdinal,
                     .weekOfMonth, .weekOfYear, .yearForWeekOfYear],
                    from: date)
                
                var dateS = DateComponents()
                dateS.hour = testDate1.hour
                dateS.minute = 18
                
                print(dateS)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateS, repeats: true)
                // Create request
                let uniqueID = UUID().uuidString // Keep a record of this if necessary
                let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }*/
            
            Spacer()
            Button("Schedule Notification") {
                prefs.save()
                notiAsk()
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                content.title = "Touch Your Nose"
                //content.badge = true
                content.sound = UNNotificationSound.default
                
                for i in 0...23 {
                    if $prefs.HToggle[i].wrappedValue == true {
                    // Setup trigger time
                    var date = DateComponents()
                    date.hour = i
                    date.minute = i
                    print("add timer for \(i):\(i)")
                    content.subtitle = "It's \(i):\(i)"
                    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                    // Create request
                    let uniqueID = UUID().uuidString // Keep a record of this if necessary
                    let request = UNNotificationRequest(identifier: uniqueID, content: content, trigger: trigger)
                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                        
                    }
                }
                viewID += 1
            }.frame(width: 250, height: 50, alignment: .center).font(.system(size: 25)).toggleStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Toggle Style@*/DefaultToggleStyle()/*@END_MENU_TOKEN@*/).border(Color.green, width: 2)
        }.onAppear(){
            prefs.load()
            viewID += 1
           // print("apear")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func notiAsk(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            print("All set!")
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
  
}
