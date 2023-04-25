//
//  CongsAlertVC.swift
//  Sliding
//
//  Created by Muratcan on 4.04.2023.
//

import UIKit

class CongsAlertVC: UIViewController {
    
    @IBOutlet var parentView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init() {
    super.init(nibName: "CongsAlertVC", bundle: Bundle(for: CongsAlertVC.self))
    self.modalPresentationStyle = .overCurrentContext
    self.modalTransitionStyle = .crossDissolve
    }
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    func showAlert(move:Int,time:String,levelSquare:String){
        if #available(iOS 13, *) {
        UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
        } else {
        UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
        }
    }

}
