//
//  ViewController4x4Back.swift
//  Sliding
//
//  Created by Muratcan on 26.03.2023.
//

import UIKit
import Lottie
import AVFoundation

class ViewController4x4Back: UIViewController {
    
    @IBOutlet weak var congsAlertParentView: UIView!
    @IBOutlet weak var congsAlertAnimation: LottieAnimationView!
    @IBOutlet weak var congsAlertView: UIView!
    @IBOutlet weak var congsAlertMoveView: UIView!
    @IBOutlet weak var congsAlertMoveLabel: UILabel!
    @IBOutlet weak var congsAlertTimeView: UIView!
    @IBOutlet weak var congsAlertTimeLabel: UILabel!
    
    @IBOutlet weak var moveOverParentView: UIView!
    @IBOutlet weak var moveOverView1: UIView!
    @IBOutlet weak var moveOverView2: UIView!
    @IBOutlet weak var moveOverAnimation: LottieAnimationView!
    
    
    @IBOutlet weak var boardView: Board4x4BackView!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var boardViewBackground: UIView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var coinView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var coinAnimation: LottieAnimationView!
    
    var timeCount: Int = 0
    var gameTimer: Timer = Timer()
    
    var moveCount: Int = 0
    var moveCountPlus = 0
    private var userDefaults = UserDefaults()
    var AudioPlayerClick = AVAudioPlayer()
    var AudioPlayerBackground = AVAudioPlayer()
    private var sound = true
    private var level = 0
    private var coin = 0
    
    //private var rewardedAd: GADRewardedAd?
    //private var interstitial: GADInterstitialAd?
    private var isRewardedAd = false
    
    @objc func timerAction(_ timer: Timer) {
        if(moveCount != 0){
            timeCount += 1
            timeLabel.text = timeFormatted(totalSeconds: timeCount)
        }
    }

    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = totalSeconds / 60
        return String(format: "%02d:%02d", minutes, seconds)
     }
    
    func _foregroundTimer(repeated: Bool) -> Void {
        gameTimer.invalidate()
        timeCount = 0
        self.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction(_:)), userInfo: nil, repeats: true);
    }
    
    
    @IBAction func tileSelected(_ sender: UIButton) {
        clickSound()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board4x4Back
        let pos = board!.getRowAndColumn(forTile: sender.tag)
        let buttonBounds = sender.bounds
        var buttonCenter = sender.center
        var slide = true
        if board!.canSlideTileUp(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.y -= buttonBounds.size.height
        } else if board!.canSlideTileDown(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.y += buttonBounds.size.height
        } else if board!.canSlideTileLeft(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.x -= buttonBounds.size.width
        } else if board!.canSlideTileRight(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.x += buttonBounds.size.width
        } else {
            slide = false
        }
        if slide {
            board!.slideTile(atRow: pos!.row, Column: pos!.column)
            // sender.center = buttonCenter // or animate the change
            UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {sender.center = buttonCenter})
            moveCount -= 1
            moveCountPlus += 1
            moveLabel.text = String(moveCount)
            
            if(moveCount <= 10){
                moveView.backgroundColor = .red
                moveLabel.textColor = .white
            }
            
            if (board!.isSolved()) {
                CheckRecors().Check(move: moveCountPlus, time: timeLabel.text ?? "", levelSquare: "4x4")
                if(userDefaults.string(forKey: "name") != ""){
                    //AddFirebase().addMoveFirebase(square: "4x4", move: moveCountPlus)
                }
                level += 1
                coin += 5
                userDefaults.setValue(level, forKey: "level")
                userDefaults.setValue(coin, forKey: "coin")
                gameTimer.invalidate()
                showCongsAlert()
            }
        }
        
        if(moveCount == 0){
            showMoveOverAlert()
        }
    } // end tileSelected
    
    private func showMoveOverAlert(){
        moveOverParentView.isHidden = false
        moveOverView2.isHidden = true
        moveOverView1.layer.cornerRadius = 15
        moveOverView2.layer.cornerRadius = 15
        moveOverAnimation.play()
        moveOverAnimation.loopMode = .loop
    }
    
    @IBAction func moveOverRestart(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.firstOpen()
            self.moveOverParentView.isHidden = true
            self.view.layoutIfNeeded()
        }){(status) in
            //
        }
    }
    
    @IBAction func moveOverPlusMove(_ sender: Any) {
        moveOverView2.isHidden = false
    }
    
    @IBAction func moveOverUseCoin(_ sender: Any) {
        if(coin >= 30){
            coin -= 30
            userDefaults.setValue(coin, forKey: "coin")
            coinLabel.text = String(coin)
            moveCount += 30
            moveLabel.text = String(moveCount)
            moveView.backgroundColor = .orange
            moveOverParentView.isHidden = true
        }else{
            let dialogMessage = UIAlertController(title: "COINS ARE NOT ENOUGH", message: "You must have at least 30 coins", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
              })
            
            dialogMessage.addAction(ok)
        }
    }
    
    @IBAction func moveOverWatchAds(_ sender: Any) {
        /*if let ad = rewardedAd {
            ad.present(fromRootViewController: self) {
                let reward = ad.adReward
                self.isRewardedAd = true
            }
          } else {
            // Hata
          }*/
    }
    
    private func showCongsAlert(){
        congsAlertView.layer.cornerRadius = 15
        congsAlertParentView.isHidden = false
        congsAlertAnimation.play()
        congsAlertAnimation.loopMode = .loop
        congsAlertMoveLabel.text = String(moveCountPlus)
        congsAlertTimeLabel.text = timeLabel.text
    }
    
    @IBAction func congsAlertGoHome(_ sender: Any) {
        AudioPlayerBackground.stop()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc, animated: true)
    }
    
    @IBAction func congsAlertNext(_ sender: Any) {
        isRewardedAd = false
        /*if self.interstitial != nil {
            self.interstitial!.present(fromRootViewController: self)
        } else {
            nextLevelForAds()
        }*/
    }
    
    private func nextLevel(){
        UIView.animate(withDuration: 0.3, animations: {
            self.firstOpen()
            self.levelLabel.text = "Level "+String(self.level)
            self.coinLabel.text = String(self.coin)
            self.congsAlertParentView.isHidden = true
            self.view.layoutIfNeeded()
            self.moveCountPlus = 0
        }){(status) in
            //
        }
    }
    
    
    @IBAction func shuffleTiles(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board4x4Back
        let shuffle = (sender.tag == 30)
        
        if (shuffle) {
            self._foregroundTimer(repeated: true)
            board?.scramble(numTimes: appDelegate.numShuffles)
            sender.tag = 31
            sender.title = "Solve"
            self.boardView.setNeedsLayout()
        } else {
            gameTimer.invalidate()
            moveCount = 0
            sender.tag = 30
            sender.title = "Shuffle"
            board?.resetBoard()
            self.boardView.setNeedsLayout()
        }
    }  // end shuffleTiles()
    
    @IBAction func switchView(_ sender: UIBarButtonItem) {
        let viewOff = (sender.tag == 20)
        
        if (viewOff) {
            sender.tag = 21
            sender.title = "Image"
            boardView.switchTileImages(false)
        } else {
            sender.tag = 20
            sender.title = "Numbers"
            boardView.switchTileImages(true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAds()
        loadRewardedAd()
        startBackgroundSound()
        moveLabel.center.x = self.view.center.x
        timeLabel.center.x = self.view.center.x
        // Do any additional setup after loading the view, typically from a nib.
        
        userDefaults = UserDefaults.standard
        level = userDefaults.integer(forKey: "level")
        levelLabel.text = "Level "+String(level)
        coin = userDefaults.integer(forKey: "coin")
        coinLabel.text = String(coin)
        
        homeButton.layer.masksToBounds = true
        homeButton.layer.cornerRadius = 10
        
        soundButton.layer.masksToBounds = true
        soundButton.layer.cornerRadius = 10
        
        restartButton.layer.masksToBounds = true
        restartButton.layer.cornerRadius = 10
        
        moveView.backgroundColor = .white.withAlphaComponent(0.7)
        moveView.layer.cornerRadius = 10
        
        boardViewBackground.layer.cornerRadius = 10
        boardViewBackground.backgroundColor = .black.withAlphaComponent(0.3)
        
        
        timeView.backgroundColor = .white.withAlphaComponent(0.7)
        timeView.layer.cornerRadius = 10
        
        
        coinView.backgroundColor = .white.withAlphaComponent(0.7)
        coinView.layer.cornerRadius = 10
        
        levelLabel.layer.masksToBounds = true
        levelLabel.layer.cornerRadius = 10
        
        coinAnimation.contentMode = .scaleAspectFit
        coinAnimation.loopMode = .loop
        coinAnimation.play()
        
        firstOpen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func firstOpen(){
        setMoveCount()
        moveView.backgroundColor = .orange
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board4x4Back
        self._foregroundTimer(repeated: true)
        board?.scramble(numTimes: appDelegate.numShuffles)
        self.boardView.setNeedsLayout()
    }
    
    private func startBackgroundSound(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bg_music", ofType: "mp3")!)
        AudioPlayerBackground = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayerBackground.prepareToPlay()
        AudioPlayerBackground.numberOfLoops = -1
        AudioPlayerBackground.play()
    }
    
    private func clickSound(){
        if(sound == true){
            let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "mp3")!)
            AudioPlayerClick = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
            AudioPlayerClick.prepareToPlay()
            AudioPlayerClick.numberOfLoops = 0
            AudioPlayerClick.play()
        }
    }
    
    @IBAction func goToHome(_ sender: Any) {
        AudioPlayerBackground.stop()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc, animated: true)
    }
    
    @IBAction func setSound(_ sender: Any) {
        if(sound == true){
            AudioPlayerBackground.stop()
            sound = false
            soundButton.setImage(UIImage(systemName: "volume.zzz"), for: .normal)
        }else{
            AudioPlayerBackground.play()
            sound = true
            soundButton.setImage(UIImage(systemName: "volume.3"), for: .normal)
        }
    }
    @IBAction func restart(_ sender: Any) {
        firstOpen()
    }
    
    private func setMoveCount(){
        if(level == 9){
            moveCount = 150
            moveLabel.text = String(moveCount)
        }else if(level == 10){
            moveCount = 140
            moveLabel.text = String(moveCount)
        }else if(level == 11){
            moveCount = 130
            moveLabel.text = String(moveCount)
        }else if(level == 12){
            moveCount = 120
            moveLabel.text = String(moveCount)
        }else if(level == 13){
            moveCount = 110
            moveLabel.text = String(moveCount)
        }else if(level == 14){
            moveCount = 100
            moveLabel.text = String(moveCount)
        }
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
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        if(self.isRewardedAd == true){
            moveCount += 30
            moveLabel.text = String(moveCount)
            moveView.backgroundColor = .orange
            moveOverParentView.isHidden = true
            loadRewardedAd()
        }else{
            nextLevel()
            addAds()
        }
    }*/
    
    private func nextLevelForAds(){
        if(level == 9){
            moveCount = 150
            moveLabel.text = String(moveCount)
            nextLevel()
        }else if(level == 10){
            moveCount = 140
            moveLabel.text = String(moveCount)
            nextLevel()
        }else if(level == 11){
            moveCount = 130
            moveLabel.text = String(moveCount)
            nextLevel()
        }else if(level == 12){
            moveCount = 120
            moveLabel.text = String(moveCount)
            nextLevel()
        }else if(level == 13){
            moveCount = 110
            moveLabel.text = String(moveCount)
            nextLevel()
        }else if(level == 14){
            moveCount = 100
            moveLabel.text = String(moveCount)
            nextLevel()
        }else{
            AudioPlayerBackground.stop()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "5x5VC")
            self.present(vc, animated: true)
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

}
