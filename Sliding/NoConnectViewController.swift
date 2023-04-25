//
//  NoConnectViewController.swift
//  Sliding
//
//  Created by Muratcan on 9.04.2023.
//

import UIKit
import Lottie

class NoConnectViewController: UIViewController {

    @IBOutlet weak var animation: LottieAnimationView!
    @IBOutlet weak var noConnectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noConnectView.layer.cornerRadius = 15
        animation.play()
        animation.loopMode = .loop
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        if NetworkMonitor.shared.isConnected{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
            self.present(vc, animated: true)
        }
    }

}
