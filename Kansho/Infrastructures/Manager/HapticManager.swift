//
//  HapticManager.swift
//  Kansho
//
//  Created by Dason Tiovino on 26/10/24.
//

import CoreHaptics
import SwiftUI

protocol HapticManagerProtocol {
    func prepareHapticEngine()
    func stopHapticPattern()
    func generateHapticPattern()
}

class HapticManager:ObservableObject, HapticManagerProtocol {
    private var engine: CHHapticEngine?
    private var player: CHHapticAdvancedPatternPlayer?
    
    init() {
        prepareHapticEngine()
    }
    
    func prepareHapticEngine() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic Engine Error: \(error)")
        }
    }
    
    func stopHapticPattern(){
        try? player?.stop(atTime: CHHapticTimeImmediate)
    }
    
    func generateHapticPattern() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            // Define the haptic event
            let event = CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
                ],
                relativeTime: 0,
                duration: 1.8
            )
            
            // Define the intensity curve
            let intensityCurve = CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    CHHapticParameterCurve.ControlPoint(relativeTime: 0.0, value: 0.0),
                    CHHapticParameterCurve.ControlPoint(relativeTime: 0.9, value: 0.6),
                    CHHapticParameterCurve.ControlPoint(relativeTime: 1.8, value: 0.0)
                ],
                relativeTime: 0
            )
            
            // Create the haptic pattern
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [intensityCurve])
            doc://com.apple.documentation/186btzw
            if let engine = engine {
                let advancedPlayer = try engine.makeAdvancedPlayer(with: pattern)
                advancedPlayer.loopEnabled = true
                
                self.player = advancedPlayer
                try advancedPlayer.start(atTime: CHHapticTimeImmediate)
            }
        } catch {
            print("Error creating haptic pattern: \(error)")
        }
    }
    
}


class MockHapticManager: HapticManagerProtocol {
    var isHapticEnginePrepared = false
    var isHapticGenerated = false
    var isHapticStopped = false
    
    func prepareHapticEngine() {
        isHapticEnginePrepared = true
    }
    
    func generateHapticPattern() {
        isHapticGenerated = true
    }
    
    func stopHapticPattern() {
        isHapticStopped = true
    }
}
