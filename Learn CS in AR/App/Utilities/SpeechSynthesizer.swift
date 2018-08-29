//
//  SpeechSynthesizer.swift
//  Learn CS in AR
//
//  Created by Macbook on 8/19/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import AVFoundation

class SpeechSynthesizer {
    
    static let shared = SpeechSynthesizer()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
        guard !synthesizer.isSpeaking else { return }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.55
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .word)
    }
}
