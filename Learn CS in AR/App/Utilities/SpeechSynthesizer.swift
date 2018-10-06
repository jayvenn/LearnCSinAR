//
//  SpeechSynthesizer.swift
//  Learn CS in AR
//
//  Created by Macbook on 8/19/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import AVFoundation

final class SpeechSynthesizer {
    
    static let shared = SpeechSynthesizer()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
        guard !synthesizer.isSpeaking else { return stopSpeaking() }
        let utterance = AVSpeechUtterance(string: text)
        if isEnglish() {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        }
        utterance.rate = 0.56 // 0.54
        synthesizer.speak(utterance)
    }
    
    private func isEnglish() -> Bool {
        return NSLocale.preferredLanguages[0].range(of:"en") != nil
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .word)
    }
    
}
