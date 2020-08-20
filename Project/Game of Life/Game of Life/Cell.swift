//
//  Cell.swift
//  Game of Life
//
//  Created by Crystal Knight on 8/19/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//
import UIKit
import Foundation

class Cell {
    let id: Int
    let row: CGFloat
    let column: CGFloat
    var isAlive: Bool
    
    init(row: CGFloat, column: CGFloat, isAlive: Bool = false) {
        self.id = Int(((row - 1) * 25) + column)
        self.row = row
        self.column = column
        self.isAlive = isAlive
    }
}
