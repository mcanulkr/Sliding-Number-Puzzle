//
//  File.swift
//  Sliding
//
//  Created by Muratcan on 9.04.2023.
//

import Foundation
//import FirebaseFirestore

class AddFirebase{
    
    let userDefaults = UserDefaults.standard
    
    /*func addMoveFirebase(square:String, move:Int){
        let name = userDefaults.string(forKey: "name")
        let firebaseRef = Firestore.firestore().collection("users").document(name?.lowercased() ?? "")
        
        firebaseRef.getDocument { value, error in
            if(value != nil){
                let field = value?.get(square)
                
                if(field == nil){
                    firebaseRef.updateData([square : move])
                }else{
                    if ((field as! Int) > move){
                        firebaseRef.updateData([square : move])
                    }
                }
                
            }
        }
    }*/
    
}
