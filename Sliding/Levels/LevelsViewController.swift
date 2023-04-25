//
//  LevelsViewController.swift
//  Sliding
//
//  Created by Muratcan on 12.03.2023.
//

import UIKit
import AVFoundation
//import GoogleMobileAds

class LevelsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var levelsCollectionView: UICollectionView!
    @IBOutlet weak var levelLabel: UILabel!
    private var level = 0
    //private var interstitial: GADInterstitialAd?
    
    var AudioPlayer = AVAudioPlayer()
    var audioPlayerCurrentTime : TimeInterval = 0.0
    var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAds()
        level = UserDefaults.standard.integer(forKey: "level")
        levelLabel.text = String(level)
        
        levelsCollectionView.isScrollEnabled = true
        levelsCollectionView.clipsToBounds = false
        levelsCollectionView.delegate = self
        levelsCollectionView.dataSource = self

        topBarView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        topBarView.layer.cornerRadius = 10
        
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
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Level Collection Cell", for: indexPath) as! LevelsCollectionViewCell
        
        let index = indexPath.row
        cell.clipsToBounds = false
    
        cell.levelsContentView.layer.cornerRadius = 20
        cell.levelsLabel.text = "Level " + String(index + 1)
        
        if(index < 3){
            cell.squareInfoLabel.text = "3 x 3"
            cell.levelsImage.image = UIImage(named: "medal")
        }else if (index < 14){
            cell.squareInfoLabel.text = "4 x 4"
            cell.levelsImage.image = UIImage(named: "medal_2")
        }else if(index < 32){
            cell.squareInfoLabel.text = "5 x 5"
            cell.levelsImage.image = UIImage(named: "medal_3")
        }else{
            cell.squareInfoLabel.text = "6 x 6"
            cell.levelsImage.image = UIImage(named: "medal_4")
        }
        
        if(level == index+1){
            cell.levelsContentView.backgroundColor = UIColor(named: "color next level")
            cell.levelsLabel.textColor = UIColor(named: "color next level txt")
            cell.squareInfoLabel.textColor = .darkGray
            cell.levelsContentView.layer.borderColor = UIColor.white.cgColor
            cell.levelsContentView.layer.borderWidth = 2
            cell.levelsImage.alpha = 1
            cell.levelsContentView.clipsToBounds = false
            cell.levelsContentView.layer.shadowRadius = 5
            cell.levelsContentView.layer.shadowOpacity = 0.8
            cell.levelsContentView.layer.shadowOffset = CGSize(width: 5, height: 5)
            cell.lockView.isHidden = true
        }else{
            if (level > index+1){
                cell.levelsContentView.backgroundColor = UIColor(named: "color next level txt")
                cell.levelsContentView.layer.borderColor = UIColor(named: "color next level")?.cgColor
                cell.levelsContentView.layer.borderWidth = 2
                cell.levelsLabel.textColor = .white
                cell.levelsImage.alpha = 1
                cell.squareInfoLabel.textColor = .lightGray
                cell.levelsContentView.clipsToBounds = false
                cell.levelsContentView.layer.shadowRadius = 5
                cell.levelsContentView.layer.shadowOpacity = 0.8
                cell.levelsContentView.layer.shadowOffset = CGSize(width: 5, height: 5)
                cell.lockView.isHidden = true
            }else{
                cell.levelsContentView.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
                cell.levelsContentView.layer.borderWidth = 2
                cell.levelsContentView.backgroundColor = UIColor(named: "color next level txt")
                cell.levelsLabel.textColor = .systemGray5
                cell.levelsContentView.layer.borderColor = UIColor.clear.cgColor
                cell.levelsImage.alpha = 0.6
                cell.squareInfoLabel.textColor = .lightGray
                cell.levelsContentView.clipsToBounds = true
                cell.lockView.isHidden = false
                cell.lockImage.alpha = 0.5
            }
        }
        
        if (level == indexPath.row + 1){
            cell.levelsContentView.isUserInteractionEnabled = true
            let goToGameGesture = SetTypeGestureRecognizer(target: self, action: #selector(goToGame(sender:)))
            goToGameGesture.uiLoadingView = cell.levelsLoading
            goToGameGesture.uiLabel = cell.levelsLabel
            goToGameGesture.uiLabel1 = cell.squareInfoLabel
            goToGameGesture.uiImage = cell.levelsImage
            cell.levelsContentView.addGestureRecognizer(goToGameGesture)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //CGSize(width: (tableViewCellCollV.frame.width / 3) - 23, height: 30)
        return CGSize(width: (levelsCollectionView.frame.width - 17 ) / 2, height: 95)
    }
    
    @objc func goToGame(sender : SetTypeGestureRecognizer){
        clickSound()
        sender.uiLoadingView.isHidden = false
        sender.uiLabel.isHidden = true
        sender.uiLabel1.isHidden = true
        sender.uiImage.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            /*if self.interstitial != nil {
                self.interstitial!.present(fromRootViewController: self)
            } else {
                self.goToGameViewController()
            }*/
            self.goToGameViewController()
        }
    }
    
    /*func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        performSegue(withIdentifier: "toFoodsVC", sender: nil)
      }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        goToGameViewController()
    }*/
    
    
    private func goToGameViewController(){
        Music.sharedInstance.stop()
        
        if(level < 3){
            if(level == 1){
                let firstOpen = userDefaults.bool(forKey: "isFirtInfo")
                if(firstOpen == false){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "firstInfo")
                    self.present(vc, animated: true)
                }else{
                    performSegue(withIdentifier: "to3x3", sender: .none)
                }
            }else{
                performSegue(withIdentifier: "to3x3", sender: .none)
            }
        }else if(level == 3){
            performSegue(withIdentifier: "to3x3Back", sender: .none)
        }else if(level <= 8){
            performSegue(withIdentifier: "to4x4", sender: .none)
        }else if(level <= 14){
            performSegue(withIdentifier: "to4x4Back", sender: .none)
        }else if(level <= 25){
            performSegue(withIdentifier: "to5x5", sender: .none)
        }else if(level <= 32){
            performSegue(withIdentifier: "to5x5Back", sender: .none)
        }else if(level <= 42){
            performSegue(withIdentifier: "to6x6", sender: .none)
        }else{
            performSegue(withIdentifier: "to6x6Back", sender: .none)
        }
    }
    
    
    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func clickSound(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = 0
        AudioPlayer.play()
    }
    
}

class SetTypeGestureRecognizer : UITapGestureRecognizer {
    var uiLoadingView: UIActivityIndicatorView = UIActivityIndicatorView()
    var uiImage = UIImageView()
    var uiLabel = UILabel()
    var uiLabel1 = UILabel()
}
