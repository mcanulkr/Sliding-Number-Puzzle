//
//  FinishViewController.swift
//  Sliding
//
//  Created by Muratcan on 9.04.2023.
//

import UIKit
import Lottie

class FinishViewController: UIViewController {

    @IBOutlet weak var congsAnimation: LottieAnimationView!
    @IBOutlet weak var animation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animation.play()
        animation.loopMode = .loop
        congsAnimation.play()
        congsAnimation.loopMode = .loop
    }
    
    @IBAction func goHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc, animated: true)
    }
    
}
