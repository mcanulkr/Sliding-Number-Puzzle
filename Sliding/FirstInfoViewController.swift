//
//  FirstInfoViewController.swift
//  Sliding
//
//  Created by Muratcan on 11.04.2023.
//

import UIKit

class FirstInfoViewController: UIViewController {

    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image1.layer.cornerRadius = 15
        image2.layer.cornerRadius = 15
        
    }
    
    
    
    @IBAction func iUnderstand(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "isFirtInfo")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "3x3VC")
        self.present(vc, animated: true)
    }
    
}
