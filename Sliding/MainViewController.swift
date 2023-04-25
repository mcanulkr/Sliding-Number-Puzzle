//
//  MainViewController.swift
//  Sliding
//
//  Created by Muratcan on 26.03.2023.
//

import UIKit
import Lottie
import AVFoundation
//import FirebaseFirestore
//import GoogleMobileAds

class MainViewController: UIViewController {
    
    @IBOutlet weak var earnCoinParentView: UIVisualEffectView!
    
    @IBOutlet weak var earnCoinParentNewCoin: UILabel!
    @IBOutlet weak var earnCoinParentAnimation1: LottieAnimationView!
    @IBOutlet weak var earnCoinParentAnimation: LottieAnimationView!
    
    @IBOutlet weak var nicknameView: UIView!
    @IBOutlet weak var nicknameAnimation: LottieAnimationView!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nicknameTopView: UIView!
    @IBOutlet weak var nicknameBottomView: UIView!
    @IBOutlet weak var nicknameCenterView: UIView!
    
    
    @IBOutlet weak var checkNicnameView: UIView!
    @IBOutlet weak var checkNickname: UILabel!
    
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var topBarView: UIView!
    
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var topBarCoinAnimation: LottieAnimationView!
    @IBOutlet weak var topBarCoinLabel: UILabel!
    @IBOutlet weak var topBarLevelLabel: UILabel!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var bestScoresView: UIView!
    @IBOutlet weak var freeModeView: UIView!
    @IBOutlet weak var earnCoinView: UIView!
    @IBOutlet weak var earnCoinAnimation: LottieAnimationView!
    
    private var userDefaults = UserDefaults()
    var AudioPlayer = AVAudioPlayer()
    var AudioPlayerClick = AVAudioPlayer()
    var AudioCurrenPosition : TimeInterval = 0.0
    
    private var firstOpen = false
    //private var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDefaults = UserDefaults.standard
        loadRewardedAd()
        
        firstOpen = userDefaults.bool(forKey: "isFirstOpen")
        checkNicnameView.isHidden = true
        
        if(firstOpen == false){
            createNewNicknameView()
        }else{
            nicknameView.isHidden = true
        }
        
        Music.sharedInstance.play()
        
        let level = userDefaults.integer(forKey: "level")
        levelLabel.text = String(level)
        
        let coin = userDefaults.integer(forKey: "coin")
        coinLabel.text = String(coin)
        
        topBarCoinAnimation.play()
        topBarCoinAnimation.loopMode = .loop
        
        earnCoinAnimation.play()
        earnCoinAnimation.loopMode = .loop
        
        infoButton.layer.masksToBounds = true
        infoButton.layer.cornerRadius = 10
        infoButton.tintColor = .white
        
        statisticsButton.layer.masksToBounds = true
        statisticsButton.layer.cornerRadius = 10
        statisticsButton.tintColor = .white
        
        topBarView.layer.cornerRadius = 10
        
        playView.layer.cornerRadius = 10
        playView.layer.borderColor = UIColor(named: "color next level txt")?.cgColor
        playView.layer.borderWidth = 3
        
        statisticsView.layer.cornerRadius = 10
        freeModeView.layer.cornerRadius = 10
        bestScoresView.layer.cornerRadius = 10
        earnCoinView.layer.cornerRadius = 10
        
        playView.isUserInteractionEnabled = true
        let playGesture = UITapGestureRecognizer(target: self, action: #selector(toLevels))
        playView.addGestureRecognizer(playGesture)
        
        freeModeView.isUserInteractionEnabled = true
        let freeModeGesture = UITapGestureRecognizer(target: self, action: #selector(toFreeMode))
        freeModeView.addGestureRecognizer(freeModeGesture)
        
        bestScoresView.isUserInteractionEnabled = true
        let bestScoresGesture = UITapGestureRecognizer(target: self, action: #selector(toBestScores))
        bestScoresView.addGestureRecognizer(bestScoresGesture)
        
        earnCoinView.isUserInteractionEnabled = true
        let earnCoinGesture = UITapGestureRecognizer(target: self, action: #selector(showRewardAd))
        earnCoinView.addGestureRecognizer(earnCoinGesture)
        
        statisticsView.isUserInteractionEnabled = true
        let statisticsGesture = UITapGestureRecognizer(target: self, action: #selector(goToStatistic))
        statisticsView.addGestureRecognizer(statisticsGesture)
        
    }
    
    
    @IBAction func checkNicknameCancel(_ sender: Any) {
        checkNicnameView.isHidden = true
    }
    
    
    @IBAction func goToInfo(_ sender: Any) {
        clickSound()
        performSegue(withIdentifier: "toInfo", sender: .none)
    }
    
    @IBAction func checkNickname(_ sender: Any) {
        let name = userDefaults.string(forKey: "name")
        if name != ""{
            checkNicnameView.layer.cornerRadius = 10
            checkNicnameView.layer.masksToBounds = true
            checkNickname.text = name
            checkNicnameView.isHidden = false
        }else{
            createNewNicknameView()
        }
        
    }
    
    @objc func goToStatistic(){
        clickSound()
        performSegue(withIdentifier: "toStatistics", sender: .none)
    }
    
    @objc func toLevels(){
        clickSound()
        performSegue(withIdentifier: "toLevels", sender: .none)
    }
    
    @objc func toFreeMode(){
        clickSound()
        performSegue(withIdentifier: "toFreeMode", sender: .none)
    }
    
    @objc func toBestScores(){
        if(userDefaults.string(forKey: "name") == ""){
            createNewNicknameView()
        }else{
            performSegue(withIdentifier: "toBestScores", sender: .none)
        }
        clickSound()
    }
    
    @objc func showRewardAd(){
        clickSound()
        /*if let ad = rewardedAd {
            ad.present(fromRootViewController: self) {
              let reward = ad.adReward
            }
          } else {
            // Hata
          }*/
    }
    
    @IBAction func earnCoinOkey(_ sender: Any) {
        clickSound()
        earnCoinParentView.isHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLevels" {
            let destinationVC = segue.destination as! LevelsViewController
            destinationVC.audioPlayerCurrentTime = AudioCurrenPosition
        }
    }
    
    private func createNewNicknameView(){
        
        nicknameAnimation.play()
        nicknameAnimation.loopMode = .loop
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 15, height: 60)
        nicknameTextField.leftView = leftView
        nicknameTextField.leftViewMode = .always
        nicknameTextField.layer.masksToBounds = true
        nicknameTextField.layer.cornerRadius = 15
        nicknameTopView.layer.cornerRadius = 15
        nicknameTopView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        nicknameCenterView.layer.cornerRadius = 15
        nicknameCenterView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMinYCorner]
        nicknameBottomView.layer.cornerRadius = 15
        nicknameBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        nicknameView.isHidden = false
        
    }
    
    @IBAction func create(_ sender: Any) {
        let name = nicknameTextField.text?.lowercased() ?? ""
        
        self.userDefaults.setValue(name, forKey: "name")
        self.nicknameView.isHidden = true
        if(self.firstOpen == false){
            self.setUserDefaults()
        }
        
        if(name != ""){
            /*let nameHashMap = ["name": name] as [String:Any]
            let firestoreRef = Firestore.firestore().collection("users").document(name)
            firestoreRef.getDocument { value, error in
                if(value != nil){
                    if(value!.exists){
                        let dialogMessage = UIAlertController(title: "OPPPSSSS !", message: "This Nickname Used", preferredStyle: .alert)
                        
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                             
                          })
                        
                        dialogMessage.addAction(ok)
                        
                        self.present(dialogMessage, animated: true, completion: nil)
                    }else{
                        firestoreRef.setData(nameHashMap)
                        self.userDefaults.setValue(name, forKey: "name")
                        self.nicknameView.isHidden = true
                        if(self.firstOpen == false){
                            self.setUserDefaults()
                        }
                    }
                }
                
            }*/
        }else{
            let dialogMessage = UIAlertController(title: "NICKNAME IS EMPTY", message: "Enter nickname or click i don't want button ", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 
              })
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func idontwant(_ sender: Any) {
        if(firstOpen == false){
            setUserDefaults()
        }
        nicknameView.isHidden = true
        userDefaults.setValue("", forKey: "name")
    }
    
    private func setUserDefaults(){
        userDefaults.setValue(true, forKey: "isFirstOpen")
        userDefaults.setValue("0", forKey: "recordMove3x3")
        userDefaults.setValue("00:00", forKey: "recordTime3x3")
        userDefaults.setValue("0", forKey: "recordMove4x4")
        userDefaults.setValue("00:00", forKey: "recordTime4x4")
        userDefaults.setValue("0", forKey: "recordMove5x5")
        userDefaults.setValue("00:00", forKey: "recordTime5x5")
        userDefaults.setValue("0", forKey: "recordMove6x6")
        userDefaults.setValue("00:00", forKey: "recordTime6x6")
        userDefaults.setValue(10, forKey: "coin")
        userDefaults.setValue(1, forKey: "level")
        
        let level = userDefaults.integer(forKey: "level")
        levelLabel.text = String(level)
        
        let coin = userDefaults.integer(forKey: "coin")
        coinLabel.text = String(coin)
    }
    
    private func clickSound(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "mp3")!)
        AudioPlayerClick = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayerClick.prepareToPlay()
        AudioPlayerClick.numberOfLoops = 0
        AudioPlayerClick.play()
    }
    
    func loadRewardedAd() {
        
        // Test ca-app-pub-3940256099942544/1712485313
        
        /*let request = GADRequest()
        GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
                           request: request,
                           completionHandler: { [self] ad, error in
          if let error = error {
            print("Failed to load rewarded ad with error: \(error.localizedDescription)")
            return
          }
          rewardedAd = ad
          print("Rewarded ad loaded.")
            rewardedAd?.fullScreenContentDelegate = self
        }
        )*/
      }
    
    /// Tells the delegate that the ad failed to present full screen content.
      /*func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
          earnCoinParentView.isHidden = false
          earnCoinParentAnimation.translatesAutoresizingMaskIntoConstraints  = false
          earnCoinParentAnimation.play()
          earnCoinParentAnimation.loopMode = .loop
          earnCoinParentAnimation.contentMode = .scaleAspectFill
          
          earnCoinParentAnimation1.translatesAutoresizingMaskIntoConstraints  = false
          earnCoinParentAnimation1.play()
          earnCoinParentAnimation1.loopMode = .loop
          earnCoinParentAnimation1.contentMode = .scaleAspectFill
          
          let coin = userDefaults.integer(forKey: "coin")
          userDefaults.setValue(coin+15, forKey: "coin")
          coinLabel.text = String(coin+15)
          
          earnCoinParentNewCoin.text = "New Coin : " + String(coin+15)
      }*/
    
}
