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
            updateViews()
        } else {
            cellController.createGlider()
            gliderIsAlive.toggle()
            gliderButton.isSelected.toggle()
            updateViews()
        }
    }
    
    @IBAction func spaceshipButton(_ sender: UIButton) {
        if spaceshipIsAlive {
            cellController.destroySpaceship()
            spaceshipIsAlive.toggle()
            spaceshipButton.isSelected.toggle()
            updateViews()
        } else {
            cellController.createSpaceship()
            spaceshipIsAlive.toggle()
            spaceshipButton.isSelected.toggle()
            updateViews()
        }
    }
    
    @IBAction func pulsarButton(_ sender: UIButton) {
        if pulsarIsAlive {
            cellController.destroyPulsar()
            pulsarIsAlive.toggle()
            pulsarButton.isSelected.toggle()
            updateViews()
        } else {
            cellController.createPulsar()
            pulsarIsAlive.toggle()
            pulsarButton.isSelected.toggle()
            updateViews()
        }
    }
    
    @IBAction func playPauseToggle(_ sender: UIButton) {
        if isPlaying {
            // Pause Generations
            presetButtonsToggle()
            playToggle()
            cancelTimer()
            if isPlayingFast {
                playFastToggle()
                cancelTimer()
            }
        } else {
            // Play Generations
            presetButtonsToggle()
            playToggle()
            startTimer()
        }
    }
    
    @IBAction func fastForwardToggle(_ sender: UIButton) {
        if isPlaying {
            if isPlayingFast {
                // Slow down to normal speed
                playFastToggle()
                startTimer()
            } else {
                // Speed up generations
                playFastToggle()
                startFastTimer()
            }
        } else {
            // Play quickly
            presetButtonsToggle()
            playToggle()
            playFastToggle()
            startFastTimer()
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        // Stop and clear grid
        if isPlaying {
            presetButtonsToggle()
            playToggle()
            if isPlayingFast {
                playFastToggle()
            }
        }
        cancelTimer()
        cellController.grid = Grid()
        cellController.generations = 0
        deselectPresetButtons()
        updateViews()
    }
    
    // MARK: - Methods
    // Timer
    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.nextGeneration()
        })
    }
    
    func startFastTimer() {
                timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.nextGeneration()
        })
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func nextGeneration() {
        cellController.updateGrid()
        updateViews()
    }
    
    // Button Helpers
    func presetButtonsToggle() {
        // Enables all preset buttons
        toadButton.isEnabled.toggle()
        gliderButton.isEnabled.toggle()
        spaceshipButton.isEnabled.toggle()
        pulsarButton.isEnabled.toggle()
    }
    
    func deselectPresetButtons() {
        let buttons = [toadButton, gliderButton, spaceshipButton, pulsarButton]
        for button in buttons {
            if button!.isSelected {
                button?.isSelected = false
            }
        }
        if toadIsAlive {
            toadIsAlive.toggle()
        }
        if gliderIsAlive {
            gliderIsAlive.toggle()
        }
        if spaceshipIsAlive {
            spaceshipIsAlive.toggle()
        }
        if pulsarIsAlive {
            pulsarIsAlive.toggle()
        }
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

