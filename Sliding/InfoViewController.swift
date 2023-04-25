//
//  InfoViewController.swift
//  Sliding
//
//  Created by Muratcan on 9.04.2023.
//

import UIKit

class InfoViewController: UIViewController {

    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image1.layer.cornerRadius = 10
        image2.layer.cornerRadius = 10
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
