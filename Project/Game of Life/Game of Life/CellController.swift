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
    var grid: Grid {
        didSet {
            updateFutureCellsBuffer { futureCells in
                self.futureCellsBuffer = Grid(cells: futureCells)
            }
        }
    }
    
    var futureCellsBuffer: Grid? {
        didSet {
            guard updateReady else { return }
            updateReady = false
            updateCells()
        }
    }
    
    var generations = 0
    var updateReady = false
    
    // MARK: - Initializers
    init(grid: Grid? = nil) {
        if let grid = grid {
            self.grid = grid
        } else {
            self.grid = Grid()
        }
    }
    
    // MARK: - Methods
    func updateCells() {
        guard let futureCells = futureCellsBuffer else {
            updateReady = true
            return
        }
        
        grid = futureCells
        generations += 1
        
        updateFutureCellsBuffer { futureCells in
            self.futureCellsBuffer = Grid(cells: futureCells)
        }
    }
    
    // To find next generation:
    // Any live cell wih fewer than two live neighbors will die.
    // Any live cell with 2-3 live neighbors will live.
    // Any live cell with more than three live neighbors will die.
    // Any dead cell with exactly 3 live neighbors will become a live cell.
    
    func updateFutureCellsBuffer(completion: @escaping ([Cell]) -> Void) {
        let currentCells = grid.cells
        var futureCells = currentCells
        futureCellsBuffer = nil
        
        DispatchQueue.global(qos: .background).async {
            for (index, currentCell) in currentCells.enumerated() {
                switch self.numberOfAliveNeighbors(for: currentCell) {
                // Live cells with 2-3 live neighbors will live.
                case 2...3 where currentCell.isAlive == true:
                    break
                // Dead cells with exactly 3 live neighbors become alive.
                case 3 where currentCell.isAlive == false:
                    futureCells[index].isAlive = true
                // Everything else dies.
                default:
                    futureCells[index].isAlive = false
                }
            }
        }
        DispatchQueue.main.async {
            completion(futureCells)
        }
    }

    
    // Finding the neighbors
    func neighbors(for cell: Cell) -> [Cell] {
        var neighbors = [Cell?]()
        
        for row in -1...1 {
            for column in -1...1 {
                guard !(column == 0 && row == 0) else { continue }
                let neighbor = grid.findCell(row: Int(cell.row) + row, column: Int(cell.column) + column)
                neighbors.append(neighbor)
            }
        }
        return neighbors.compactMap { $0 }
    }
    
    func numberOfAliveNeighbors(for cell: Cell) -> Int {
        neighbors(for: cell).filter { $0.isAlive == true }.count
    }
    
    
    // Setting the cell state
    func activateCell(cellRow: CGFloat, cellColumn: CGFloat) {
        let newCell = Cell(row: cellRow, column: cellColumn, isAlive: true)
        futureCellsBuffer?.cells.remove(at: newCell.id - 1)
        futureCellsBuffer?.cells.insert(newCell, at: newCell.id - 1)
    }
    
    func deactivateCell(cellRow: CGFloat, cellColumn: CGFloat) {
        let newCell = Cell(row: cellRow, column: cellColumn, isAlive: false)
        futureCellsBuffer?.cells.remove(at: newCell.id - 1)
        futureCellsBuffer?.cells.insert(newCell, at: newCell.id - 1)
    }
    
    // Preset configurations
    func createToad() {
        activateCell(cellRow: 3, cellColumn: 22)
        activateCell(cellRow: 3, cellColumn: 23)
        activateCell(cellRow: 3, cellColumn: 24)
        activateCell(cellRow: 4, cellColumn: 21)
        activateCell(cellRow: 4, cellColumn: 22)
        activateCell(cellRow: 4, cellColumn: 23)
        updateCells()
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
        updateCells()
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
        updateCells()
    }
    
    func createGlider() {
        activateCell(cellRow: 22, cellColumn: 24)
        activateCell(cellRow: 23, cellColumn: 22)
        activateCell(cellRow: 23, cellColumn: 24)
        activateCell(cellRow: 24, cellColumn: 23)
        activateCell(cellRow: 24, cellColumn: 24)
        updateCells()
    }
    
    func destroyToad() {
        deactivateCell(cellRow: 3, cellColumn: 22)
        deactivateCell(cellRow: 3, cellColumn: 23)
        deactivateCell(cellRow: 3, cellColumn: 24)
        deactivateCell(cellRow: 4, cellColumn: 21)
        deactivateCell(cellRow: 4, cellColumn: 22)
        deactivateCell(cellRow: 4, cellColumn: 23)
        updateCells()
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
        updateCells()
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
        updateCells()
    }
    
    func destroyGlider() {
        deactivateCell(cellRow: 22, cellColumn: 24)
        deactivateCell(cellRow: 23, cellColumn: 22)
        deactivateCell(cellRow: 23, cellColumn: 24)
        deactivateCell(cellRow: 24, cellColumn: 23)
        deactivateCell(cellRow: 24, cellColumn: 24)
        updateCells()
    }
}


