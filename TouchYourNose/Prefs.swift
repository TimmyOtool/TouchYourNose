//
//  Prefs.swift
//  TouchYourNose
//
//  Created by Michael Melin on 22/02/2022.
//

import Foundation
import UIKit

class Prefs: ObservableObject {
    public var HToggle: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
    
    func save(){
        //print("save")
        let defaults = UserDefaults.standard
        defaults.set(HToggle, forKey: "pref")
        //print(HToggle)
    }

    func load(){
        let defaults = UserDefaults.standard
        if let ht = defaults.object(forKey: "pref"){
            HToggle = ht as? [Bool] ?? []
        }
    }
    
    
}
