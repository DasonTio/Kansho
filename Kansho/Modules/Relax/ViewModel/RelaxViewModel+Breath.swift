//
//  RelaxViewModel+Breath.swift
//  Kansho
//
//  Created by Dason Tiovino on 08/11/24.
//

import Foundation
import AVFoundation

enum BreathState {
    case BreathIn
    case Hold
    case BreathOut
}

extension RelaxViewModel {

    func startBreath() {
        // MARK: Breathing Method
        /// Breath In 4 Seconds
        /// Hold 7 Seconds
        /// Breath Out 8 Seconds
        breathCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] time in
                guard let self = self else{
                    return
                }
                self.currentStep += 1
                
                if self.currentStep > 20 {
                    self.currentStep = 1
                }
                
                if self.currentStep == 1 {
                    self.breathState = .BreathIn
                    breathInAudio?.play()
                    breathOutAudio?.stop()
                }
                else if self.currentStep == 4 {
                    self.breathState = .Hold
                    breathInAudio?.stop()
                }
                else if self.currentStep == 12 {
                    self.breathState = .BreathOut
                    breathOutAudio?.play()
                }
            }
        
    }
    func stopBreath(){
        breathCancellable?.cancel()
    }
}
