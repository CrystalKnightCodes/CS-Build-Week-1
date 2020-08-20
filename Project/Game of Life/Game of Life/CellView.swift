//
//  CellView.swift
//  Game of Life
//
//  Created by Christy Hicks on 8/19/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

let testCell1 = Cell(row: 1, column: 1, isAlive: true)
let testCell2 = Cell(row: 5, column: 7, isAlive: true)
let testCell3 = Cell(row: 5, column: 6, isAlive: true)
let testCell4 = Cell(row: 5, column: 5)
let testCells: [Cell] = [testCell1, testCell2, testCell3, testCell4]

class CellView: UIView {
    // MARK: - Properties
    private var path = UIBezierPath()

    fileprivate var heightAndWidth: CGFloat {
        return 25
    }

    fileprivate var gridWidth: CGFloat {
        return bounds.width/CGFloat(heightAndWidth)
    }

    fileprivate var gridHeight: CGFloat {
        return bounds.height/CGFloat(heightAndWidth)
    }

    fileprivate var gridCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    // MARK: - Methods
    fileprivate func drawSquares() {
        path = UIBezierPath()
        path.lineWidth = 2.0

        for index in 0...Int(heightAndWidth) {
            let start = CGPoint(x: CGFloat(index) * gridWidth, y: 0)
            let end = CGPoint(x: CGFloat(index) * gridWidth, y:bounds.height)
            path.move(to: start)
            path.addLine(to: end)
        }

        for index in 0...Int(heightAndWidth) {
            let start = CGPoint(x: 0, y: CGFloat(index) * gridHeight)
            let end = CGPoint(x: bounds.width, y: CGFloat(index) * gridHeight)
            path.move(to: start)
            path.addLine(to: end)
        }

        path.close()
        UIColor.purple.setStroke()
        path.stroke()
    }
    
    func fillGrid(cells: [Cell]) {
        path = UIBezierPath()
        path.lineWidth = 1.0
        
        for cell in cells {
            if cell.isAlive {
                path.move(to: CGPoint(x: (cell.column - 1) * gridWidth, y: (cell.row - 1) * gridHeight))
                path.addLine(to: CGPoint(x: (cell.column - 1) * gridWidth + gridWidth, y: (cell.row - 1) * gridHeight))
                path.addLine(to: CGPoint(x: (cell.column - 1) * gridWidth + gridWidth, y: (cell.row - 1) * gridHeight + gridHeight))
                path.addLine(to: CGPoint(x: (cell.column - 1) * gridWidth, y: (cell.row - 1) * gridHeight + gridHeight))
                path.close()
                UIColor.black.set()
                path.lineWidth = 1
                path.fill()
            }
        }
    }

    override func draw(_ rect: CGRect) {
        drawSquares()
        fillGrid(cells: testCells)
    }
}
