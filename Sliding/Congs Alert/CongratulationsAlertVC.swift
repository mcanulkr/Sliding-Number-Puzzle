//
//  CongratulationsAlertVC.swift
//  Sliding
//
//  Created by Muratcan on 4.04.2023.
//

import UIKit

protocol CongratulationsAlertDelegeta: AnyObject {
    func goHome(_ alert: CongratulationsAlertVC)
    func nextLevel(_ alert: CongratulationsAlertVC)
}

class CongratulationsAlertVC: UIViewController {
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    weak var delegate: CongratulationsAlertDelegeta?
    
    init() {
        super.init(nibName: "CongratulationsAlertVC", bundle: Bundle(for: CongratulationsAlertVC.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        // Do any additional setup after loading the view.
    }
    
    private func design(){
        generalView.layer.cornerRadius = 10
        moveView.layer.cornerRadius = 10
        timeView.layer.cornerRadius = 10
    }
    
    func show() {
        if #available(iOS 13, *) {
            UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
        }
    }
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.goHome(self)
    }
    
    @IBAction func nextLevel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.nextLevel(self)
    }
    
    
}
