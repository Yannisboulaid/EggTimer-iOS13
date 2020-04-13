//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let time : [String : Int] = ["Soft" : 10, "Medium" : 420, "Hard" : 720];
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    var test3 = 0
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var labelTimer: UILabel!
    @IBAction func timerSelectPressed(_ sender: UIButton)
    {
        progressBar.progress = 0
        secondsPassed = 0
        test3 = 1

        timer.invalidate()
        let choix = sender.currentTitle
        totalTime = time[choix!]!
        labelTimer.text = choix

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    @objc func updateCounter() {
    //example functionality
    if(secondsPassed < totalTime) {
        
        secondsPassed += 1;
        
        progressBar.progress  = Float(secondsPassed) / Float(totalTime)
    }else{
        timer.invalidate()
        labelTimer.text = "Done !!!"
        playSound()
        }
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
    

