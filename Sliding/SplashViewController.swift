//
//  SplashViewController.swift
//  Sliding
//
//  Created by Muratcan on 26.03.2023.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var welcome: LottieAnimationView!
    private var userDefaults = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        userDefaults = UserDefaults.standard
        
        welcome.play()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            if NetworkMonitor.shared.isConnected{
                self.performSegue(withIdentifier: "toMain", sender: .none)
            }else{
                self.performSegue(withIdentifier: "toNoConnect", sender: .none)
            }
            
        }
        
    }

}
