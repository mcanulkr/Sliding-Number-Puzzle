//
//  CheckRecors.swift
//  Sliding
//
//  Created by Muratcan on 4.04.2023.
//

import Foundation

class CheckRecors{
    func Check(move : Int, time:String, levelSquare : String){
        
        let recordMove = UserDefaults.standard.string(forKey: "recordMove"+levelSquare) ?? "0"
        let recordTime = UserDefaults.standard.string(forKey: "recordTime"+levelSquare) ?? "00:00"
        
        if(Int(recordMove) ?? 0 == 0){
            UserDefaults.standard.setValue(String(move), forKey: "recordMove"+levelSquare)
        }else{
            if(Int(recordMove) ?? 0 > move){
                UserDefaults.standard.setValue(String(move), forKey: "recordMove"+levelSquare)
            }
        }
        
        let time1_mn = time[time.index(time.startIndex, offsetBy: 0)]
        let time2_mn = time[time.index(time.startIndex, offsetBy: 1)]
        let totalMinute = Int(String(time1_mn) + String(time2_mn)) ?? 0
        
        let time1_s = time[time.index(time.startIndex, offsetBy: 3)]
        let time2_s = time[time.index(time.startIndex, offsetBy: 4)]
        let totalSecond = Int(String(time1_s)+String(time2_s)) ?? 0
        
        let checkTime = totalMinute * 60 + totalSecond
        
        let recordTime1_mn = recordTime[recordTime.index(recordTime.startIndex, offsetBy: 0)]
        let recordTime2_mn = recordTime[recordTime.index(recordTime.startIndex, offsetBy: 1)]
        let recordTotalMinute = Int(String(recordTime1_mn) + String(recordTime2_mn)) ?? 0
        
        let recordTime1_s = recordTime[recordTime.index(recordTime.startIndex, offsetBy: 3)]
        let recordTime2_s = recordTime[recordTime.index(recordTime.startIndex, offsetBy: 4)]
        let recordTotalSecond = Int(String(recordTime1_s)+String(recordTime2_s)) ?? 0
        
        let checkRecordTime = recordTotalMinute * 60 + recordTotalSecond
        
        if(recordTime == "00:00"){
            UserDefaults.standard.setValue(time, forKey: "recordTime"+levelSquare)
        }else{
            if(checkTime < checkRecordTime){
                UserDefaults.standard.setValue(time, forKey: "recordTime"+levelSquare)
            }
        }
    }
}
