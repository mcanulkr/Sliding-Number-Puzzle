//
//  ViewController3x3.swift
//  Sliding
//
//  Created by Muratcan on 12.03.2023.
//

import UIKit
import Lottie
import AVFoundation

class ViewController3x3: UIViewController {
    
    @IBOutlet weak var congratsAlertView: UIView!
    @IBOutlet weak var congratsAlertViewWidth: NSLayoutConstraint!
    @IBOutlet weak var congratsAlertParentView: UIView!
    @IBOutlet weak var congratsAlertMoveView: UIView!
    @IBOutlet weak var congratsAlertMoveLabel: UILabel!
    @IBOutlet weak var congratsAlerTimeView: UIView!
    @IBOutlet weak var congratsAlerTimeLabel: UILabel!
    
    
    @IBOutlet weak var boardView: Board3x3View!
    
    @IBOutlet weak var boardViewBackground: UIView!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var coinAnimation: LottieAnimationView!
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var bestScoreView: UIView!
    
    @IBOutlet weak var congratsAnimation: LottieAnimationView!
    var timeCount: Int = 0
    var gameTimer: Timer = Timer()
    
    var moveCount: Int = 0
    private var level = 0
    private var coin = 0
    
    private var userDefaults = UserDefaults()
    var AudioPlayerClick = AVAudioPlayer()
    var AudioPlayerBackground = AVAudioPlayer()
    private var sound = true
    
    //private var interstitial: GADInterstitialAd?
    
    @objc func timerAction(_ timer: Timer) {
        timeCount += 1
        timeLabel.text = timeFormatted(totalSeconds: timeCount)
    }

    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = totalSeconds / 60
        return String(format: "%02d:%02d", minutes, seconds)
     }
    
    func _foregroundTimer(repeated: Bool) -> Void {
        gameTimer.invalidate()
        timeCount = 0
        moveCount = 0
        moveLabel.text = String(moveCount)
        self.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction(_:)), userInfo: nil, repeats: true);
    }
    
    
    @IBAction func tileSelected(_ sender: UIButton) {
        clickSound()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board3x3
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
            moveCount += 1
            moveLabel.text = String(moveCount)
            if (board!.isSolved()) {
                
                CheckRecors().Check(move: moveCount, time: timeLabel.text ?? "", levelSquare: "3x3")
                if(userDefaults.string(forKey: "name") != ""){
                    //AddFirebase().addMoveFirebase(square: "3x3", move: moveCount)
                }
                
                congratsAnimation.play()
                congratsAnimation.loopMode = .loop
                congratsAnimation.isHidden = false
                level+=1
                coin+=5
                userDefaults.setValue(level, forKey: "level")
                userDefaults.setValue(coin, forKey: "coin")
                gameTimer.invalidate()
                openDialog()
            }
        } // end if slide
    } // end tileSelected
    
    private func openDialog(){
        congratsAlertMoveLabel.text = String(moveCount)
        congratsAlerTimeLabel.text = timeLabel.text
        congratsAlertView.layer.cornerRadius = 15
        congratsAlertView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        congratsAlertView.layer.shadowOpacity = 1
        congratsAlertView.layer.shadowOffset = CGSize.zero
        congratsAlertView.layer.shadowRadius = 20
        congratsAlertViewWidth.constant = view.frame.width - 40
        congratsAlerTimeView.layer.cornerRadius = 15
        congratsAlertMoveView.layer.cornerRadius = 15
        UIView.animate(withDuration: 0.3, animations: {
            self.congratsAlertParentView.isHidden = false
            self.view.layoutIfNeeded()
        }){(status) in
            //
        }
        
    }
    
    @IBAction func congratsAlertGoHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc, animated: true)
    }
    
    @IBAction func congratsAlertNext(_ sender: Any) {
        /*if self.interstitial != nil {
            self.interstitial!.present(fromRootViewController: self)
        } else {
            nextLevel()
        }*/
        nextLevel()
    }
    
    func resetBoard() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board3x3
        board?.scramble(numTimes: appDelegate.numShuffles)
        self._foregroundTimer(repeated: true)
        self.boardView.setNeedsLayout()
    }
    
    
    
    @IBAction func shuffleTiles(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board3x3
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
        
        boardViewBackground.layer.cornerRadius = 10
        boardViewBackground.backgroundColor = .black.withAlphaComponent(0.3)
        
        moveView.backgroundColor = .white.withAlphaComponent(0.7)
        moveView.layer.cornerRadius = 10
        
        
        timeView.backgroundColor = .white.withAlphaComponent(0.7)
        timeView.layer.cornerRadius = 10
        
        
        bestScoreView.backgroundColor = .white.withAlphaComponent(0.7)
        bestScoreView.layer.cornerRadius = 10
        
        levelLabel.layer.masksToBounds = true
        levelLabel.layer.cornerRadius = 10
    
        coinAnimation.contentMode = .scaleAspectFit
        coinAnimation.loopMode = .loop
        coinAnimation.play()
        coinAnimation.translatesAutoresizingMaskIntoConstraints = false
        
        
        firstOpen()
    }
    
    @IBAction func goToMain(_ sender: Any) {
        AudioPlayerBackground.stop()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(vc, animated: true)
    }
    
    @IBAction func restart(_ sender: Any) {
        firstOpen()
    }
    
    private func firstOpen(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board3x3
        self._foregroundTimer(repeated: true)
        board?.scramble(numTimes: appDelegate.numShuffles)
        moveCount = 0
        self.boardView.setNeedsLayout()
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    private func startBackgroundSound(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bg_music", ofType: "mp3")!)
        AudioPlayerBackground = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayerBackground.prepareToPlay()
        AudioPlayerBackground.numberOfLoops = -1
        AudioPlayerBackground.play()
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
        
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        nextLevel()
    }*/
    
    private func nextLevel(){
        if(level == 2){
            UIView.animate(withDuration: 0.3, animations: {
                self.firstOpen()
                self.levelLabel.text = "Level 2"
                self.coinLabel.text = String(self.coin)
                self.congratsAlertParentView.isHidden = true
                self.view.layoutIfNeeded()
                self.addAds()
            }){(status) in
                //
            }
        }else{
            AudioPlayerBackground.stop()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "3x3BackVC")
            self.present(vc, animated: true)
        }
    }
    
    
}
