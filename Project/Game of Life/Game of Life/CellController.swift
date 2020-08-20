//
//  CellController.swift
//  Game of Life
//
//  Created by Crystal Knight on 8/19/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation
import UIKit

class CellController {
    // MARK: - Properties
    var currentCells: [Cell] = []
    var futureCells: [Cell] = []
    
    // MARK: - Methods
    func initializeGrid() {
        for row in 1...25 {
            for column in 1...25 {
                let cell = Cell(row: CGFloat(row), column: CGFloat(column))
                currentCells.append(cell)
                futureCells.append(cell)
            }
        }
    }
    
    func activateCell(cellRow: CGFloat, cellColumn: CGFloat) {
        let newCell = Cell(row: cellRow, column: cellColumn, isAlive: true)
        futureCells.remove(at: newCell.id - 1)
        futureCells.insert(newCell, at: newCell.id - 1)
    }
    
    func deactivateCell(cellRow: CGFloat, cellColumn: CGFloat) {
        let newCell = Cell(row: cellRow, column: cellColumn, isAlive: false)
        futureCells.remove(at: newCell.id - 1)
        futureCells.insert(newCell, at: newCell.id - 1)
    }
    
    func nextGeneration() {
        currentCells = futureCells
    }
}
