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
            if !isInitialSetup {
                updateFutureGrid { currentCells in
                    self.futureGrid = Grid(cells: currentCells)
                }
            }
        }
    }
    
    var futureGrid: Grid? {
        didSet {
            guard updateReady else { return }
            updateReady = false
            updateGrid()
        }
    }
    
    var generations = 0
    var updateReady = false
    var isInitialSetup = false
    
    // MARK: - Initializers
    init(grid: Grid? = nil) {
        if let grid = grid {
            self.grid = grid
        } else {
            self.grid = Grid()
        }
    }
    
    // MARK: - Methods
    func updateGrid() {
        guard let currentGrid = futureGrid else {
            updateReady = true
            return
        }
        
        grid = currentGrid
        generations += 1
        
        updateFutureGrid { currentCells in
            self.futureGrid = Grid(cells: currentCells)
        }
    }
    
    // To find next generation:
    // Any live cell wih fewer than two live neighbors will die.
    // Any live cell with 2-3 live neighbors will live.
    // Any live cell with more than three live neighbors will die.
    // Any dead cell with exactly 3 live neighbors will become a live cell.
    
    func updateFutureGrid(completion: @escaping ([Cell]) -> Void) {
        let currentCells = grid.cells
        var futureCells = currentCells
        futureGrid = nil
        
        DispatchQueue.global(qos: .background).sync {
            for (index, currentCell) in currentCells.enumerated() {
                switch self.numberOfAliveNeighbors(for: currentCell) {
                    
                // Dead cells with exactly 3 live neighbors become alive.
                case 3 where currentCell.isAlive == false:
                    futureCells[index].isAlive = true

                // Live cells with 2-3 live neighbors will continue to live.
                case 2...3 where currentCell.isAlive == true:
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
        var neighbors = [Cell]()
        
        for y in -1...1 {
            for x in -1...1 {
                guard !(y == 0 && x == 0) else { continue }
                let neighbor = grid.findCell(row: cell.row + x, column: cell.column + y)
                if neighbor != nil {
                    neighbors.append(neighbor!)
                }
            }
        }
        
        let uniqueNeighbors = Array(Set(neighbors))
        return uniqueNeighbors
    }
    
    func numberOfAliveNeighbors(for cell: Cell) -> Int {
        return neighbors(for: cell).filter { $0.isAlive == true }.count
    }
    
    
    // Setting the cell state
    func activateCell(cellRow: Int, cellColumn: Int) {
        futureGrid?.toggleCell(row: cellRow, column: cellColumn, isAlive: true)
    }
    
    func deactivateCell(cellRow: Int, cellColumn: Int) {
        futureGrid?.toggleCell(row: cellRow, column: cellColumn, isAlive: false)
    }
    
    // Preset configurations
    func createToad() {
        futureGrid = grid
        activateCell(cellRow: 3, cellColumn: 22)
        activateCell(cellRow: 3, cellColumn: 23)
        activateCell(cellRow: 3, cellColumn: 21)
        activateCell(cellRow: 4, cellColumn: 21)
        activateCell(cellRow: 4, cellColumn: 22)
        activateCell(cellRow: 4, cellColumn: 20)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
    
    func destroyToad() {
        futureGrid = grid
        deactivateCell(cellRow: 3, cellColumn: 22)
        deactivateCell(cellRow: 3, cellColumn: 23)
        deactivateCell(cellRow: 3, cellColumn: 21)
        deactivateCell(cellRow: 4, cellColumn: 21)
        deactivateCell(cellRow: 4, cellColumn: 22)
        deactivateCell(cellRow: 4, cellColumn: 20)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
    
    func createGlider() {
        futureGrid = grid
        activateCell(cellRow: 3, cellColumn: 14)
        activateCell(cellRow: 4, cellColumn: 12)
        activateCell(cellRow: 4, cellColumn: 14)
        activateCell(cellRow: 5, cellColumn: 13)
        activateCell(cellRow: 5, cellColumn: 14)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
    
    func destroyGlider() {
        futureGrid = grid
        deactivateCell(cellRow: 3, cellColumn: 14)
        deactivateCell(cellRow: 4, cellColumn: 12)
        deactivateCell(cellRow: 4, cellColumn: 14)
        deactivateCell(cellRow: 5, cellColumn: 13)
        deactivateCell(cellRow: 5, cellColumn: 14)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
    
    func createPulsar() {
        futureGrid = grid
        activateCell(cellRow: 7, cellColumn: 9)
        activateCell(cellRow: 7, cellColumn: 10)
        activateCell(cellRow: 7, cellColumn: 11)
        activateCell(cellRow: 7, cellColumn: 15)
        activateCell(cellRow: 7, cellColumn: 16)
        activateCell(cellRow: 7, cellColumn: 17)
        activateCell(cellRow: 9, cellColumn: 7)
        activateCell(cellRow: 9, cellColumn: 12)
        activateCell(cellRow: 9, cellColumn: 14)
        activateCell(cellRow: 9, cellColumn: 19)
        activateCell(cellRow: 10, cellColumn: 7)
        activateCell(cellRow: 10, cellColumn: 12)
        activateCell(cellRow: 10, cellColumn: 14)
        activateCell(cellRow: 10, cellColumn: 19)
        activateCell(cellRow: 11, cellColumn: 7)
        activateCell(cellRow: 11, cellColumn: 12)
        activateCell(cellRow: 11, cellColumn: 14)
        activateCell(cellRow: 11, cellColumn: 19)
        activateCell(cellRow: 12, cellColumn: 9)
        activateCell(cellRow: 12, cellColumn: 10)
        activateCell(cellRow: 12, cellColumn: 11)
        activateCell(cellRow: 12, cellColumn: 15)
        activateCell(cellRow: 12, cellColumn: 16)
        activateCell(cellRow: 12, cellColumn: 17)
        activateCell(cellRow: 14, cellColumn: 9)
        activateCell(cellRow: 14, cellColumn: 10)
        activateCell(cellRow: 14, cellColumn: 11)
        activateCell(cellRow: 14, cellColumn: 15)
        activateCell(cellRow: 14, cellColumn: 16)
        activateCell(cellRow: 14, cellColumn: 17)
        activateCell(cellRow: 15, cellColumn: 7)
        activateCell(cellRow: 15, cellColumn: 12)
        activateCell(cellRow: 15, cellColumn: 14)
        activateCell(cellRow: 15, cellColumn: 19)
        activateCell(cellRow: 16, cellColumn: 7)
        activateCell(cellRow: 16, cellColumn: 12)
        activateCell(cellRow: 16, cellColumn: 14)
        activateCell(cellRow: 16, cellColumn: 19)
        activateCell(cellRow: 17, cellColumn: 7)
        activateCell(cellRow: 17, cellColumn: 12)
        activateCell(cellRow: 17, cellColumn: 14)
        activateCell(cellRow: 17, cellColumn: 19)
        activateCell(cellRow: 19, cellColumn: 9)
        activateCell(cellRow: 19, cellColumn: 10)
        activateCell(cellRow: 19, cellColumn: 11)
        activateCell(cellRow: 19, cellColumn: 15)
        activateCell(cellRow: 19, cellColumn: 16)
        activateCell(cellRow: 19, cellColumn: 17)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
    
    func destroyPulsar() {
        futureGrid = grid
        deactivateCell(cellRow: 7, cellColumn: 9)
        deactivateCell(cellRow: 7, cellColumn: 10)
        deactivateCell(cellRow: 7, cellColumn: 11)
        deactivateCell(cellRow: 7, cellColumn: 15)
        deactivateCell(cellRow: 7, cellColumn: 16)
        deactivateCell(cellRow: 7, cellColumn: 17)
        deactivateCell(cellRow: 9, cellColumn: 7)
        deactivateCell(cellRow: 9, cellColumn: 12)
        deactivateCell(cellRow: 9, cellColumn: 14)
        deactivateCell(cellRow: 9, cellColumn: 19)
        deactivateCell(cellRow: 10, cellColumn: 7)
        deactivateCell(cellRow: 10, cellColumn: 12)
        deactivateCell(cellRow: 10, cellColumn: 14)
        deactivateCell(cellRow: 10, cellColumn: 19)
        deactivateCell(cellRow: 11, cellColumn: 7)
        deactivateCell(cellRow: 11, cellColumn: 12)
        deactivateCell(cellRow: 11, cellColumn: 14)
        deactivateCell(cellRow: 11, cellColumn: 19)
        deactivateCell(cellRow: 12, cellColumn: 9)
        deactivateCell(cellRow: 12, cellColumn: 10)
        deactivateCell(cellRow: 12, cellColumn: 11)
        deactivateCell(cellRow: 12, cellColumn: 15)
        deactivateCell(cellRow: 12, cellColumn: 16)
        deactivateCell(cellRow: 12, cellColumn: 17)
        deactivateCell(cellRow: 14, cellColumn: 9)
        deactivateCell(cellRow: 14, cellColumn: 10)
        deactivateCell(cellRow: 14, cellColumn: 11)
        deactivateCell(cellRow: 14, cellColumn: 15)
        deactivateCell(cellRow: 14, cellColumn: 16)
        deactivateCell(cellRow: 14, cellColumn: 17)
        deactivateCell(cellRow: 15, cellColumn: 7)
        deactivateCell(cellRow: 15, cellColumn: 12)
        deactivateCell(cellRow: 15, cellColumn: 14)
        deactivateCell(cellRow: 15, cellColumn: 19)
        deactivateCell(cellRow: 16, cellColumn: 7)
        deactivateCell(cellRow: 16, cellColumn: 12)
        deactivateCell(cellRow: 16, cellColumn: 14)
        deactivateCell(cellRow: 16, cellColumn: 19)
        deactivateCell(cellRow: 17, cellColumn: 7)
        deactivateCell(cellRow: 17, cellColumn: 12)
        deactivateCell(cellRow: 17, cellColumn: 14)
        deactivateCell(cellRow: 17, cellColumn: 19)
        deactivateCell(cellRow: 19, cellColumn: 9)
        deactivateCell(cellRow: 19, cellColumn: 10)
        deactivateCell(cellRow: 19, cellColumn: 11)
        deactivateCell(cellRow: 19, cellColumn: 15)
        deactivateCell(cellRow: 19, cellColumn: 16)
        deactivateCell(cellRow: 19, cellColumn: 17)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
    
    func createSpaceship() {
        futureGrid = grid
        activateCell(cellRow: 3, cellColumn: 7)
        activateCell(cellRow: 3, cellColumn: 8)
        activateCell(cellRow: 4, cellColumn: 3)
        activateCell(cellRow: 4, cellColumn: 4)
        activateCell(cellRow: 4, cellColumn: 5)
        activateCell(cellRow: 4, cellColumn: 6)
        activateCell(cellRow: 4, cellColumn: 8)
        activateCell(cellRow: 4, cellColumn: 9)
        activateCell(cellRow: 5, cellColumn: 3)
        activateCell(cellRow: 5, cellColumn: 4)
        activateCell(cellRow: 5, cellColumn: 5)
        activateCell(cellRow: 5, cellColumn: 6)
        activateCell(cellRow: 5, cellColumn: 7)
        activateCell(cellRow: 5, cellColumn: 8)
        activateCell(cellRow: 6, cellColumn: 4)
        activateCell(cellRow: 6, cellColumn: 5)
        activateCell(cellRow: 6, cellColumn: 6)
        activateCell(cellRow: 6, cellColumn: 7)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
    
    func destroySpaceship() {
        futureGrid = grid
        deactivateCell(cellRow: 3, cellColumn: 7)
        deactivateCell(cellRow: 3, cellColumn: 8)
        deactivateCell(cellRow: 4, cellColumn: 3)
        deactivateCell(cellRow: 4, cellColumn: 4)
        deactivateCell(cellRow: 4, cellColumn: 5)
        deactivateCell(cellRow: 4, cellColumn: 6)
        deactivateCell(cellRow: 4, cellColumn: 8)
        deactivateCell(cellRow: 4, cellColumn: 9)
        deactivateCell(cellRow: 5, cellColumn: 3)
        deactivateCell(cellRow: 5, cellColumn: 4)
        deactivateCell(cellRow: 5, cellColumn: 5)
        deactivateCell(cellRow: 5, cellColumn: 6)
        deactivateCell(cellRow: 5, cellColumn: 7)
        deactivateCell(cellRow: 5, cellColumn: 8)
        deactivateCell(cellRow: 6, cellColumn: 4)
        deactivateCell(cellRow: 6, cellColumn: 5)
        deactivateCell(cellRow: 6, cellColumn: 6)
        deactivateCell(cellRow: 6, cellColumn: 7)
        isInitialSetup = true
        grid = futureGrid!
        isInitialSetup = false
    }
}


