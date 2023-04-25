//
//  StatisticsViewController.swift
//  Sliding
//
//  Created by Muratcan on 7.04.2023.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var view3x3_1: UIView!
    @IBOutlet weak var view_3x3_2: UIView!
    @IBOutlet weak var bestTime3x3Label: UILabel!
    @IBOutlet weak var bestMove3x3Label: UILabel!
    
    @IBOutlet weak var view4x4_1: UIView!
    @IBOutlet weak var view4x4_2: UIView!
    @IBOutlet weak var bestTime4x4Label: UILabel!
    @IBOutlet weak var bestMove4x4Label: UILabel!
    
    @IBOutlet weak var view5x5_1: UIView!
    @IBOutlet weak var view5x5_2: UIView!
    @IBOutlet weak var bestTime5x5Label: UILabel!
    @IBOutlet weak var bestMove5x5Label: UILabel!
    
    @IBOutlet weak var view6x6_1: UIView!
    @IBOutlet weak var view6x6_2: UIView!
    @IBOutlet weak var bestTime6x6Label: UILabel!
    @IBOutlet weak var bestMove6x6Label: UILabel!
    
    private var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDefaults = UserDefaults.standard
        
        view3x3_1.layer.cornerRadius = 10
        view_3x3_2.layer.cornerRadius = 10
        view4x4_1.layer.cornerRadius = 10
        view4x4_2.layer.cornerRadius = 10
        view5x5_1.layer.cornerRadius = 10
        view5x5_2.layer.cornerRadius = 10
        view6x6_1.layer.cornerRadius = 10
        view6x6_2.layer.cornerRadius = 10
        
        
        bestTime3x3Label.text = userDefaults.string(forKey: "recordTime3x3") ?? "00:00"
        bestMove3x3Label.text = userDefaults.string(forKey: "recordMove3x3") ?? "0"
        
        bestTime4x4Label.text = userDefaults.string(forKey: "recordTime4x4") ?? "00:00"
        bestMove4x4Label.text = userDefaults.string(forKey: "recordMove4x4") ?? "0"
        
        bestTime5x5Label.text = userDefaults.string(forKey: "recordTime5x5") ?? "00:00"
        bestMove5x5Label.text = userDefaults.string(forKey: "recordMove5x5") ?? "0"
        
        bestTime6x6Label.text = userDefaults.string(forKey: "recordTime6x6") ?? "00:00"
        bestMove6x6Label.text = userDefaults.string(forKey: "recordMove6x6") ?? "0"
        
    }
    
    
    @IBAction func backToReturn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    
}
