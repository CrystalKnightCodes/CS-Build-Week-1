//
//  Cell.swift
//  Game of Life
//
//  Created by Crystal Knight on 8/19/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//
import UIKit
import Foundation

struct Cell: Hashable {
    
    let index: Int
    let row: Int
    let column: Int
    var isAlive: Bool
    
    init(row: Int, column: Int, isAlive: Bool = false) {
        self.index = (((row - 1) * 25) + column)
        self.row = row
        self.column = column
        self.isAlive = isAlive
    }
}
