//
//  Board4x4View.swift
//  Sliding
//
//  Created by Muratcan on 29.01.2023.
//

import Foundation
import UIKit

class Board4x4View: UIView {
    
    func boardRect() -> CGRect { // get square for holding 4x4 tiles buttons
        let W = self.bounds.size.width
        let H = self.bounds.size.height
        let margin : CGFloat = 0
        let size = ((W <= H) ? W : H) - margin
        let boardSize : CGFloat = CGFloat((Int(size) + 7)/8)*8.0 // next multiple of 8
        let leftMargin = (W - boardSize)/2
        let topMargin = (H - boardSize)/2
        return CGRect(x: leftMargin, y: topMargin, width: boardSize, height: boardSize)
    }
    
    // BoardView method that overrides UIViews layoutSubviews method to position the tile buttons to reflect the state of the board model.
    
    override func layoutSubviews() {
        super.layoutSubviews() // let autolayout engine finish first
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let board = appDelegate.board4x4  // get model from app delegate
        
        let boardSquare = boardRect()  // determine region to hold tiles (see below)
        let tileSize = (boardSquare.width) / 4.0
        let tileBounds = CGRect(x: 0, y: 0, width: tileSize, height: tileSize)
        
        for r in 0 ..< 4 {      // manually set the bounds, and of each tile
            for c in 0 ..< 4 {
                let tile = board!.getTile(atRow: r, atColumn: c)
                if tile > 0 {
                    let button = self.viewWithTag(tile)
                    button?.layer.masksToBounds = true
                    button?.layer.cornerRadius = 20
                    button?.layer.borderColor = UIColor.white.cgColor
                    button?.layer.borderWidth = 2
                    button?.bounds = tileBounds
                    button?.center = CGPoint(x: boardSquare.origin.x + (CGFloat(c) + 0.5)*tileSize,
                                            y: boardSquare.origin.y + (CGFloat(r) + 0.5)*tileSize)
                }
            }
        }
    } // end layoutSubviews()
    
    func switchTileImages(_ imageOn : Bool) {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let board = appDelegate.board4x4  // get model from app delegate
        
        for r in 0..<4 {
            for c in 0..<4 {
                let tile = board!.getTile(atRow: r, atColumn: c)
                if tile > 0 {
                    let button = self.viewWithTag(tile) as! UIButton
                    if (imageOn) {
                        button.setTitle("", for: UIControl.State.normal)
                        button.titleEdgeInsets = UIEdgeInsets.zero // no margins
                        button.imageEdgeInsets = UIEdgeInsets.zero
                        button.contentEdgeInsets = UIEdgeInsets.zero
                        //button.layoutMargins = UIEdgeInsets.zero
                        button.contentMode = .center
                        button.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
                        //button.imageView?.contentMode = .scaleAspectFit
                        let convert : UIImage? = UIImage(named: String(tile))
                        button.setImage(convert, for: .normal)
                    } else {
                        button.setTitle(String(tile), for: UIControl.State.normal)
                        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
                        button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
                        button.setImage(nil, for: .normal)
                    }
                }
            }
        }
    }
    
    func switchTileOrder(_ shuffle : Bool) {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let board = appDelegate.board4x4  // get model from app delegate
        
        if (shuffle) {
            board?.scramble(numTimes: 150)
        } else {
            board?.resetBoard()
        }
    }

} // end BoardView()
