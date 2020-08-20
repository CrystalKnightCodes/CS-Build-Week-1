//
//  Cell.swift
//  Game of Life
//
//  Created by Crystal Knight on 8/19/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import Foundation

class Cell {
    let id: Int
    let row: Int
    let column: Int
    var isAlive: Bool
    
    init(id: Int, row: Int, column: Int, isAlive: Bool = false) {
        self.id = id
        self.row = row
        self.column = column
        self.isAlive = isAlive
    }
}
