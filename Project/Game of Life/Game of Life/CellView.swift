//
//  CellView.swift
//  Game of Life
//
//  Created by Christy Hicks on 8/19/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

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
    fileprivate func drawGrid() {
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
    }
    
    override func draw(_ rect: CGRect) {
        drawGrid()
        
        UIColor.purple.setStroke()
        path.stroke()
    }
}
