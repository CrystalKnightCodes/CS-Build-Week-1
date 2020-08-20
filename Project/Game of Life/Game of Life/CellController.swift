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
    
    func copyOver() {
        currentCells = futureCells
    }
    
    // Preset configurations
    func createToad() {
        activateCell(cellRow: 3, cellColumn: 22)
        activateCell(cellRow: 3, cellColumn: 23)
        activateCell(cellRow: 3, cellColumn: 24)
        activateCell(cellRow: 4, cellColumn: 21)
        activateCell(cellRow: 4, cellColumn: 22)
        activateCell(cellRow: 4, cellColumn: 23)
        copyOver()
    }
    
    func createPulsar() {
        activateCell(cellRow: 9, cellColumn: 10)
        activateCell(cellRow: 9, cellColumn: 11)
        activateCell(cellRow: 9, cellColumn: 15)
        activateCell(cellRow: 9, cellColumn: 16)
        activateCell(cellRow: 10, cellColumn: 9)
        activateCell(cellRow: 10, cellColumn: 12)
        activateCell(cellRow: 10, cellColumn: 14)
        activateCell(cellRow: 10, cellColumn: 17)
        activateCell(cellRow: 11, cellColumn: 9)
        activateCell(cellRow: 11, cellColumn: 12)
        activateCell(cellRow: 11, cellColumn: 14)
        activateCell(cellRow: 11, cellColumn: 17)
        activateCell(cellRow: 12, cellColumn: 10)
        activateCell(cellRow: 12, cellColumn: 11)
        activateCell(cellRow: 12, cellColumn: 15)
        activateCell(cellRow: 12, cellColumn: 16)
        activateCell(cellRow: 14, cellColumn: 10)
        activateCell(cellRow: 14, cellColumn: 11)
        activateCell(cellRow: 14, cellColumn: 15)
        activateCell(cellRow: 14, cellColumn: 16)
        activateCell(cellRow: 15, cellColumn: 9)
        activateCell(cellRow: 15, cellColumn: 12)
        activateCell(cellRow: 15, cellColumn: 14)
        activateCell(cellRow: 15, cellColumn: 17)
        activateCell(cellRow: 16, cellColumn: 9)
        activateCell(cellRow: 16, cellColumn: 12)
        activateCell(cellRow: 16, cellColumn: 14)
        activateCell(cellRow: 16, cellColumn: 17)
        activateCell(cellRow: 17, cellColumn: 10)
        activateCell(cellRow: 17, cellColumn: 11)
        activateCell(cellRow: 17, cellColumn: 15)
        activateCell(cellRow: 17, cellColumn: 16)
        copyOver()
    }
    
    func createSpaceship() {
        activateCell(cellRow: 2, cellColumn: 6)
        activateCell(cellRow: 2, cellColumn: 7)
        activateCell(cellRow: 3, cellColumn: 2)
        activateCell(cellRow: 3, cellColumn: 3)
        activateCell(cellRow: 3, cellColumn: 4)
        activateCell(cellRow: 3, cellColumn: 5)
        activateCell(cellRow: 3, cellColumn: 7)
        activateCell(cellRow: 3, cellColumn: 8)
        activateCell(cellRow: 4, cellColumn: 2)
        activateCell(cellRow: 4, cellColumn: 3)
        activateCell(cellRow: 4, cellColumn: 4)
        activateCell(cellRow: 4, cellColumn: 5)
        activateCell(cellRow: 4, cellColumn: 6)
        activateCell(cellRow: 4, cellColumn: 7)
        activateCell(cellRow: 5, cellColumn: 3)
        activateCell(cellRow: 5, cellColumn: 4)
        activateCell(cellRow: 5, cellColumn: 5)
        activateCell(cellRow: 5, cellColumn: 6)
        copyOver()
    }
    
    func createGlider() {
        activateCell(cellRow: 22, cellColumn: 24)
        activateCell(cellRow: 23, cellColumn: 22)
        activateCell(cellRow: 23, cellColumn: 24)
        activateCell(cellRow: 24, cellColumn: 23)
        activateCell(cellRow: 24, cellColumn: 24)
        copyOver()
    }
    
    func destroyToad() {
        deactivateCell(cellRow: 3, cellColumn: 22)
        deactivateCell(cellRow: 3, cellColumn: 23)
        deactivateCell(cellRow: 3, cellColumn: 24)
        deactivateCell(cellRow: 4, cellColumn: 21)
        deactivateCell(cellRow: 4, cellColumn: 22)
        deactivateCell(cellRow: 4, cellColumn: 23)
        copyOver()
    }
    
    func destroyPulsar() {
        deactivateCell(cellRow: 9, cellColumn: 10)
        deactivateCell(cellRow: 9, cellColumn: 11)
        deactivateCell(cellRow: 9, cellColumn: 15)
        deactivateCell(cellRow: 9, cellColumn: 16)
        deactivateCell(cellRow: 10, cellColumn: 9)
        deactivateCell(cellRow: 10, cellColumn: 12)
        deactivateCell(cellRow: 10, cellColumn: 14)
        deactivateCell(cellRow: 10, cellColumn: 17)
        deactivateCell(cellRow: 11, cellColumn: 9)
        deactivateCell(cellRow: 11, cellColumn: 12)
        deactivateCell(cellRow: 11, cellColumn: 14)
        deactivateCell(cellRow: 11, cellColumn: 17)
        deactivateCell(cellRow: 12, cellColumn: 10)
        deactivateCell(cellRow: 12, cellColumn: 11)
        deactivateCell(cellRow: 12, cellColumn: 15)
        deactivateCell(cellRow: 12, cellColumn: 16)
        deactivateCell(cellRow: 14, cellColumn: 10)
        deactivateCell(cellRow: 14, cellColumn: 11)
        deactivateCell(cellRow: 14, cellColumn: 15)
        deactivateCell(cellRow: 14, cellColumn: 16)
        deactivateCell(cellRow: 15, cellColumn: 9)
        deactivateCell(cellRow: 15, cellColumn: 12)
        deactivateCell(cellRow: 15, cellColumn: 14)
        deactivateCell(cellRow: 15, cellColumn: 17)
        deactivateCell(cellRow: 16, cellColumn: 9)
        deactivateCell(cellRow: 16, cellColumn: 12)
        deactivateCell(cellRow: 16, cellColumn: 14)
        deactivateCell(cellRow: 16, cellColumn: 17)
        deactivateCell(cellRow: 17, cellColumn: 10)
        deactivateCell(cellRow: 17, cellColumn: 11)
        deactivateCell(cellRow: 17, cellColumn: 15)
        deactivateCell(cellRow: 17, cellColumn: 16)
        copyOver()
    }
    
    func destroySpaceship() {
        deactivateCell(cellRow: 2, cellColumn: 6)
        deactivateCell(cellRow: 2, cellColumn: 7)
        deactivateCell(cellRow: 3, cellColumn: 2)
        deactivateCell(cellRow: 3, cellColumn: 3)
        deactivateCell(cellRow: 3, cellColumn: 4)
        deactivateCell(cellRow: 3, cellColumn: 5)
        deactivateCell(cellRow: 3, cellColumn: 7)
        deactivateCell(cellRow: 3, cellColumn: 8)
        deactivateCell(cellRow: 4, cellColumn: 2)
        deactivateCell(cellRow: 4, cellColumn: 3)
        deactivateCell(cellRow: 4, cellColumn: 4)
        deactivateCell(cellRow: 4, cellColumn: 5)
        deactivateCell(cellRow: 4, cellColumn: 6)
        deactivateCell(cellRow: 4, cellColumn: 7)
        deactivateCell(cellRow: 5, cellColumn: 3)
        deactivateCell(cellRow: 5, cellColumn: 4)
        deactivateCell(cellRow: 5, cellColumn: 5)
        deactivateCell(cellRow: 5, cellColumn: 6)
        copyOver()
    }
    
    func destroyGlider() {
        deactivateCell(cellRow: 22, cellColumn: 24)
        deactivateCell(cellRow: 23, cellColumn: 22)
        deactivateCell(cellRow: 23, cellColumn: 24)
        deactivateCell(cellRow: 24, cellColumn: 23)
        deactivateCell(cellRow: 24, cellColumn: 24)
        copyOver()
    }
}
