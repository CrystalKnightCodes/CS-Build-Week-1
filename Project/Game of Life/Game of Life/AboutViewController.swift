//
//  AboutViewController.swift
//  Game of Life
//
//  Created by Crystal Knight on 8/18/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var moreTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreTextView.isHidden = true
    }
    
    @IBAction func moreButton(_ sender: UIButton) {
        moreTextView.isHidden.toggle()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
