//
//  FreeModeViewController.swift
//  Sliding
//
//  Created by Muratcan on 26.03.2023.
//

import UIKit
import AVFAudio

class FreeModeViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var goTo3x3Button: UIButton!
    @IBOutlet weak var goTo4x4Button: UIButton!
    @IBOutlet weak var goTo5x5Button: UIButton!
    @IBOutlet weak var goTo6x6Button: UIButton!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    var AudioPlayer = AVAudioPlayer()
    var AudioPlayerClick = AVAudioPlayer()
    
    private var userDefaults = UserDefaults()
    
    private var level = 0
    //private var interstitial: GADInterstitialAd?
    private var clickLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAds()
        userDefaults = UserDefaults.standard
        level = userDefaults.integer(forKey: "level")
        
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 10
        
        nameLabel.layer.masksToBounds = true
        nameLabel.backgroundColor = .white.withAlphaComponent(0.7)
        nameLabel.layer.cornerRadius = 10
        
        goTo3x3Button.layer.cornerRadius = 10
        goTo3x3Button.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo3x3Button.layer.shadowOpacity = 1
        goTo3x3Button.layer.shadowOffset = CGSize.zero
        goTo3x3Button.layer.shadowRadius = 10
        
        goTo4x4Button.layer.cornerRadius = 10
        goTo4x4Button.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo4x4Button.layer.shadowOpacity = 1
        goTo4x4Button.layer.shadowOffset = CGSize.zero
        goTo4x4Button.layer.shadowRadius = 10
        
        goTo5x5Button.layer.cornerRadius = 10
        goTo5x5Button.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo5x5Button.layer.shadowOpacity = 1
        goTo5x5Button.layer.shadowOffset = CGSize.zero
        goTo5x5Button.layer.shadowRadius = 10

        goTo6x6Button.layer.cornerRadius = 10
        goTo6x6Button.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo6x6Button.layer.shadowOpacity = 1
        goTo6x6Button.layer.shadowOffset = CGSize.zero
        goTo6x6Button.layer.shadowRadius = 10
        
        warningLabel.text = "Make your best score\nand enter the top 30\nin the rankings"
    }
    
    
    @IBAction func returnToBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goTo3x3(_ sender: Any) {
        clickSound()
        /*if self.interstitial != nil {
            self.interstitial!.present(fromRootViewController: self)
            clickLevel = 1
        } else {
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to3x3Free", sender: .none)
        }*/
        Music.sharedInstance.stop()
        performSegue(withIdentifier: "to3x3Free", sender: .none)
    }
    
    @IBAction func goTo4x4(_ sender: Any) {
        clickSound()
        if(level <= 3){
            let dialogMessage = UIAlertController(title: "COMPLETE LEVEL 3", message: "Complete Level 3 and Try Again", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
              })
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }else{
            /*if self.interstitial != nil {
                self.interstitial!.present(fromRootViewController: self)
                clickLevel = 2
            } else {
                Music.sharedInstance.stop()
                performSegue(withIdentifier: "to4x4Free", sender: .none)
            }*/
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to4x4Free", sender: .none)
        }
        
    }
    
    @IBAction func goTo5x5(_ sender: Any) {
        clickSound()
        if(level <= 25){
            let dialogMessage = UIAlertController(title: "COMPLETE LEVEL 25", message: "Complete Level 25 and Try Again", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
              })
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }else{
            /*if self.interstitial != nil {
                self.interstitial!.present(fromRootViewController: self)
                clickLevel = 3
            } else {
                Music.sharedInstance.stop()
                performSegue(withIdentifier: "to5x5Free", sender: .none)
            }*/
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to5x5Free", sender: .none)
            
        }
    }
    
    
    @IBAction func goTo6x6(_ sender: Any) {
        clickSound()
        if(level <= 42){
            let dialogMessage = UIAlertController(title: "COMPLETE LEVEL 42", message: "Complete Level 42 and Try Again", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
              })
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }else{
            /*if self.interstitial != nil {
                self.interstitial!.present(fromRootViewController: self)
                clickLevel = 4
            } else {
                Music.sharedInstance.stop()
                performSegue(withIdentifier: "to6x6Free", sender: .none)
            }*/
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to6x6Free", sender: .none)
        }
        
    }
    
    private func clickSound(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "mp3")!)
        AudioPlayerClick = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayerClick.prepareToPlay()
        AudioPlayerClick.numberOfLoops = 0
        AudioPlayerClick.play()
    }
    
    private func addAds(){
        // test "ca-app-pub-3940256099942544/4411468910"
        /*let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                              }
            )*/
    }
    
    /*func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        
      }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        if(clickLevel == 1){
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to3x3Free", sender: .none)
        }else if(clickLevel == 2){
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to4x4Free", sender: .none)
        }else if(clickLevel == 3){
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to5x5Free", sender: .none)
        }else if(clickLevel == 4){
            Music.sharedInstance.stop()
            performSegue(withIdentifier: "to6x6Free", sender: .none)
        }
    }*/
    
}
