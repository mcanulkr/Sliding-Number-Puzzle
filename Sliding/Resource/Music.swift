//
//  Music.swift
//  Sliding
//
//  Created by Muratcan on 9.04.2023.
//

import Foundation
import AVFoundation

class Music {
    static let sharedInstance = Music()
    private var player: AVAudioPlayer?

    func play() {
        guard let url = Bundle.main.url(forResource: "main_bg_music_2", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    func stop() {
        player?.stop()
    }
}
