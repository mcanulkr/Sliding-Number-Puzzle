//
//  CongsAlertView.swift
//  Sliding
//
//  Created by Muratcan on 3.04.2023.
//

import Foundation
import UIKit

class CongsAlertViewUI : UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var generalView: UIView!
    private var userDefaults = UserDefaults()
    
    init() {
    super.init(nibName: "CongsAlertView", bundle: Bundle(for: CongsAlertViewUI.self))
    self.modalPresentationStyle = .overCurrentContext
    self.modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        commitInit()
        userDefaults = UserDefaults.standard
    }
    
    private func commitInit(){
        // Tasarım kodu
        parentView.backgroundColor = .black.withAlphaComponent(0.6)
        generalView.layer.cornerRadius = 10
        moveView.layer.cornerRadius = 10
        timeView.layer.cornerRadius = 10
    }
    
    func showAlert(move:Int,time:String,levelSquare:String){
        moveLabel.text = String(move)
        timeLabel.text = time
        if #available(iOS 13, *) {
        UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
        } else {
        UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
        }
    }
    
    func closeAlert(){
        parentView.removeFromSuperview()
    }
    
    @IBAction func goHome(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
    @IBAction func nextLevel(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
    private func checkRecords(move : Int, time:String, levelSquare : String){
        
        let recordMove = userDefaults.integer(forKey: "recordMove"+levelSquare)
        let recordTime = userDefaults.string(forKey: "recordTime"+levelSquare) ?? "00:00"
        
        if(recordMove > move){
            userDefaults.setValue(move, forKey: "recordMove"+levelSquare)
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
        
        if(checkTime < checkRecordTime){
            userDefaults.setValue(time, forKey: "recordTime"+levelSquare)
        }
    }
    
}
