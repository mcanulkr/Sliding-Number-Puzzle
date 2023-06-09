//
//  Board4x4Back.swift
//  Sliding
//
//  Created by Muratcan on 26.03.2023.
//

import Foundation

class Board4x4Back{
    var state : [[Int]] = [
        [1, 2, 3, 4],
        [5, 6, 7 ,8],
        [9, 10, 11, 12],
        [13, 14, 15, 0]
    ]

    let rows = 4
    let cols = 4
    
    func random(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    func swapTile(fromRow row1: Int, Column column1: Int, toRow row2: Int, Column column2: Int) {
        state[row2][column2] = state[row1][column1]
        state[row1][column1] = 0
    }

    // Choose one of the “slidable” tiles at random and slide it into the empty space; repeat n times. We use this method to start a new game using a large value (e.g., 150) for n.
    func scramble(numTimes n: Int) {
        resetBoard()
        for _ in 1...n {
            var movingTiles : [(atRow: Int, Column: Int)] = []
            var numMovingTiles : Int = 0
            for row in 0..<rows {
                for column in 0..<cols {
                    if canSlideTile(atRow: row, Column: column) {
                        movingTiles.append((row, column))
                        numMovingTiles = numMovingTiles + 1
                    }
                }
            }
            let randomTile = random(numMovingTiles)
            var moveRow : Int, moveCol : Int
            (moveRow , moveCol) = movingTiles[randomTile]
            slideTile(atRow: moveRow, Column: moveCol)
        } // end for i
    } // end scamble()
    
    // Fetch the tile at the given position (0 is used for the space).
    func getTile(atRow r: Int, atColumn c: Int) -> Int {
        return state[r][c]
    } // end getTile()
    
    // Find the position of the given tile (0 is used for the space) – returns tuple holding row and column.
    func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
        if (tile > (rows * cols-1)) {
            return nil
        }
        for x in 0..<rows {
            for y in 0..<cols {
                if ((state[x][y]) == tile) {
                    return (row: x,column: y)
                }
            }
        }
        return nil
    } // end getRowAndColumn()
    
    // Determine if puzzle is in solved configuration.
    func canSlideTileUp(atRow r : Int, Column c : Int) -> Bool {
            return (r < 1) ? false : ( state[r-1][c] == 0 )
    } // end canSlideTileUp
    
    // Determine if the specified tile can be slid up into the empty space.
    func canSlideTileDown(atRow r :  Int, Column c :  Int) -> Bool {
        return (r > (rows-2)) ? false : ( state[r+1][c] == 0 )
    } // end canSlideTileDown
    
    func canSlideTileLeft(atRow r :  Int, Column c :  Int) -> Bool {
            return (c < 1) ? false : ( state[r][c-1] == 0 )
    } // end canSlideTileLeft
    
    func canSlideTileRight(atRow r :  Int, Column c :  Int) -> Bool {
            return (c > (cols-2)) ? false : ( state[r][c+1] == 0 )
    } // end canSlideTileRight
    
    func canSlideTile(atRow r :  Int, Column c :  Int) -> Bool {
        return  (canSlideTileRight(atRow: r, Column: c) ||
            canSlideTileLeft(atRow: r, Column: c) ||
            canSlideTileDown(atRow: r, Column: c) ||
            canSlideTileUp(atRow: r, Column: c))
    } // canSlideTile()

    // Slide the tile into the empty space, if possible.
    // tile is at [r,c]
    // 0 is at [r-1,c], [r+1,c], [r,c-1], [r, c+1]
    func slideTile(atRow r: Int, Column c: Int) {
        // basecase
        if (r > rows || c > cols || r < 0 || c < 0) {
            return
        }
        if (canSlideTile(atRow: r, Column: c)) {
            if (canSlideTileUp(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r-1, Column: c)
            }
            if (canSlideTileDown(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r+1, Column: c)
            }
            if (canSlideTileLeft(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r, Column: c-1)
            }
            if (canSlideTileRight(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r, Column: c+1)
            }
        } // end if canSlideTile
    } // end slideTile()
    
    func isSolved() -> Bool {
        var comparison = 1
        for r in 0..<rows {
            for c in 0..<cols {
                if state[r][c] != comparison%16 {
                    return false
                } // end if
                comparison = comparison + 1
            }
        }
        return true
    } // end isSolved()
    
    // reset board to default
    func resetBoard() {
        var set = 1
        for r in 0..<rows {
            for c in 0..<cols {
                state[r][c] = set%16
                set = set + 1
            }
        }
    } // end resetBoard()
}
