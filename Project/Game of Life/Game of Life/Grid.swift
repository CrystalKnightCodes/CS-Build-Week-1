//
//  Grid.swift
//  Game of Life
//
//  Created by Christy Hicks on 8/23/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation
import UIKit

struct Grid {
    // MARK: - Properties
    var cells = [Cell]()
    
    // MARK: - Initializer
    public init(cells: [Cell]? = nil) {
        if let cells = cells {
            self.cells = cells
        } else {
            for row in 1...25 {
                for column in 1...25 {
                    let cell = Cell(row: CGFloat(row), column: CGFloat(column))
                    self.cells.append(cell)
                }
                
            }
        }
    }
    
    func findCell(row: Int, column: Int) -> Cell? {
        guard row >= 0, row < 25,
        column >= 0, column < 25 else { return nil }
        
        return cells[column * 25 + row]
    }
}
