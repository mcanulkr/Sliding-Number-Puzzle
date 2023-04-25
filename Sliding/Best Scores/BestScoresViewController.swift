//
//  BestScoresViewController.swift
//  Sliding
//
//  Created by Muratcan on 26.03.2023.
//

import UIKit
//import GoogleMobileAds

class BestScoresViewController: UIViewController{
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var goTo3x3View: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goTo4x4View: UIButton!
    @IBOutlet weak var goTo6x6View: UIButton!
    @IBOutlet weak var goTo5x5View: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    
    private var square = ""
    //private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addAds()
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 10
        
        nameLabel.layer.masksToBounds = true
        nameLabel.backgroundColor = .white.withAlphaComponent(0.7)
        nameLabel.layer.cornerRadius = 10
        
        goTo3x3View.layer.cornerRadius = 10
        goTo3x3View.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo3x3View.layer.shadowOpacity = 1
        goTo3x3View.layer.shadowOffset = CGSize.zero
        goTo3x3View.layer.shadowRadius = 10
        
        goTo4x4View.layer.cornerRadius = 10
        goTo4x4View.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo4x4View.layer.shadowOpacity = 1
        goTo4x4View.layer.shadowOffset = CGSize.zero
        goTo4x4View.layer.shadowRadius = 10
        
        goTo5x5View.layer.cornerRadius = 10
        goTo5x5View.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo5x5View.layer.shadowOpacity = 1
        goTo5x5View.layer.shadowOffset = CGSize.zero
        goTo5x5View.layer.shadowRadius = 10
        
        goTo6x6View.layer.cornerRadius = 10
        goTo6x6View.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        goTo6x6View.layer.shadowOpacity = 1
        goTo6x6View.layer.shadowOffset = CGSize.zero
        goTo6x6View.layer.shadowRadius = 10
        
        warningLabel.text = "Click and see\ntop 30 scores"
        
    }
    

    @IBAction func returnToBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func goTo3x3(_ sender: Any) {
        square = "3x3"
        /*if self.interstitial != nil {
            self.interstitial!.present(fromRootViewController: self)
        } else {
            performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
        }*/
        performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
        
    }
    
    @IBAction func goTo4x4(_ sender: Any) {
        square = "4x4"
        /*if self.interstitial != nil {
            self.interstitial!.present(fromRootViewController: self)
        } else {
            performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
        }*/
        performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
    }
    
    @IBAction func goTo5x5(_ sender: Any) {
        square = "5x5"
        /*if self.interstitial != nil {
            self.interstitial!.present(fromRootViewController: self)
        } else {
            performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
        }*/
        performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
    }
    
    @IBAction func goTo6x6(_ sender: Any) {
        square = "6x6"
        /*if self.interstitial != nil {
            self.interstitial!.present(fromRootViewController: self)
        } else {
            performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
        }*/
        performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toBestScoreDetail"){
            let destination = segue.destination as! BestScoresDetailViewController
            destination.square = square
        }
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
        performSegue(withIdentifier: "toBestScoreDetail", sender: .none)
    }*/
    
}
