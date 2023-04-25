//
//  BestScoresDetailViewController.swift
//  Sliding
//
//  Created by Muratcan on 7.04.2023.
//

import UIKit
//import FirebaseFirestore
import Lottie

class BestScoresDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingViewAnimation: LottieAnimationView!
    
    @IBOutlet weak var squareLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var nameList = [String]()
    private var scoreList = [Int]()
    
    var square = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        squareLabel.text = square
        
        //getScores()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BestScoreTableViewCell") as! BestScoreTableViewCell
        cell.itemNumberLabel.text = String(indexPath.row + 1)
        cell.itemNameLabel.text = nameList[indexPath.row]
        cell.itemScoreLabel.text = String(scoreList[indexPath.row])
        cell.isSelected = false
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func returnToBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*private func getScores(){
        Firestore.firestore().collection("users").order(by: square).limit(to: 30)
            .getDocuments { (value, error) in
                if(value != nil){
                    for doc in value!.documents{
                        if let field = doc.get(self.square){
                            if let name = doc.get("name"){
                                self.nameList.append(name as! String)
                                self.scoreList.append(field as! Int)
                                
                            }
                        }
                    }
                    self.tableView.reloadData()
                    self.loadingViewAnimation.play()
                    self.loadingViewAnimation.loopMode = .loop
                    self.loadingView.isHidden = true
                }
            }
    }*/
    
    
}
