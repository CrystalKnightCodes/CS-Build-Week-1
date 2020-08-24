//
//  LifeViewController.swift
//  Game of Life
//
//  Created by Crystal Knight on 8/18/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

class LifeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet var playButton: UIButton!
    @IBOutlet var fastForwardButton: UIButton!
    @IBOutlet var generationLabel: UILabel!
    @IBOutlet var toadButton: UIButton!
    @IBOutlet var gliderButton: UIButton!
    @IBOutlet var spaceshipButton: UIButton!
    @IBOutlet var pulsarButton: UIButton!
    @IBOutlet var cellView: CellView!
    
    // MARK: - Properties
    var cellController = CellController()
    var toadIsAlive = false
    var gliderIsAlive = false
    var spaceshipIsAlive = false
    var pulsarIsAlive = false
    var isPlaying = false
    var isPlayingFast = false
    var timer: Timer?
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        cellView.grid = cellController.grid
    }
    
    func updateViews() {
        cellView.grid = cellController.grid
        generationLabel.text = "\(cellController.generations)"
    }
    
    // MARK: - Actions
    @IBAction func toadButton(_ sender: UIButton) {
        if toadIsAlive {
            cellController.destroyToad()
            toadIsAlive.toggle()
            toadButton.isSelected.toggle()
            updateViews()
        } else {
            cellController.createToad()
            toadIsAlive.toggle()
            toadButton.isSelected.toggle()
            updateViews()
        }
    }
    
    @IBAction func gliderButton(_ sender: UIButton) {
        if gliderIsAlive {
            cellController.destroyGlider()
            gliderIsAlive.toggle()
            gliderButton.isSelected.toggle()
        } else {
            cellController.createGlider()
            gliderIsAlive.toggle()
            gliderButton.isSelected.toggle()
        }
    }
    
    @IBAction func spaceshipButton(_ sender: UIButton) {
        if spaceshipIsAlive {
            cellController.destroySpaceship()
            spaceshipIsAlive.toggle()
            spaceshipButton.isSelected.toggle()
        } else {
            cellController.createSpaceship()
            spaceshipIsAlive.toggle()
            spaceshipButton.isSelected.toggle()
        }
    }
    
    @IBAction func pulsarButton(_ sender: UIButton) {
        if pulsarIsAlive {
            cellController.destroyPulsar()
            pulsarIsAlive.toggle()
            pulsarButton.isSelected.toggle()
        } else {
            cellController.createSpaceship()
            pulsarIsAlive.toggle()
            pulsarButton.isSelected.toggle()
        }
    }
    
    @IBAction func playPauseToggle(_ sender: UIButton) {
        if isPlaying {
            // Pause Generations
            presetButtonsToggle()
            playToggle()
            if isPlayingFast {
                playFastToggle()
            }
            // TODO: Stop Cell Generation
        } else {
            // Play Generations
            presetButtonsToggle()
            playToggle()
            // TODO: Start Cell Generation
        }
    }
    
    @IBAction func fastForwardToggle(_ sender: UIButton) {
        if isPlaying {
            if isPlayingFast {
                // Slow down to normal speed
                playFastToggle()
                // TODO: Slow down generations
            } else {
                // Speed up generations
                playFastToggle()
                // TODO: Speed up generations
            }
        } else {
            // Play quickly
            presetButtonsToggle()
            playToggle()
            playFastToggle()
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        // Stop and clear grid
        if isPlaying {
            presetButtonsToggle()
            playToggle()
            cellController.grid = Grid()
            if isPlayingFast {
                playFastToggle()
            }
        }
        updateViews()
    }
    
    // MARK: - Methods
    func presetButtonsToggle() {
        // Enables all preset buttons
        toadButton.isEnabled.toggle()
        gliderButton.isEnabled.toggle()
        spaceshipButton.isEnabled.toggle()
        pulsarButton.isEnabled.toggle()
    }
    
    func playToggle() {
        playButton.isSelected.toggle()
        isPlaying.toggle()
    }
    
    func playFastToggle() {
        fastForwardButton.isSelected.toggle()
        isPlayingFast.toggle()
    }
}

