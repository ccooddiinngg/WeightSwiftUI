//
//  AudioPlayer.swift
//  Weight
//
//  Created by Hanjun Kang on 6/5/21.
//

import Foundation
import AVFoundation

class AudioPlayer {
    let fileName: String
    var audioPlayer: AVAudioPlayer?

    init(fileName: String) {
        self.fileName = fileName
    }

    func play() {
        if let path = Bundle.main.path(forResource: fileName, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print(error)
            }
        }
    }
}
