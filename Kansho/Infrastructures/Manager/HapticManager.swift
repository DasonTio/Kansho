//
//  HapticManager.swift
//  Kansho
//
//  Created by Dason Tiovino on 26/10/24.
//

import CoreHaptics
import SwiftUI

struct HapticManager {
    private var engine: CHHapticEngine?
    
    init() {
        prepareHapticEngine()
    }
    
    mutating func prepareHapticEngine() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic Engine Error: \(error)")
        }
    }
    
    func generateHapticPattern() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            // Create a continuous haptic event for the duration of 1.8 seconds
            let event = CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6), // Starting intensity
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5) // Sharpness
                ],
                relativeTime: 0,
                duration: 1.8
            )
            
            // Create an intensity control curve that rises and falls over 1.8 seconds
            let intensityCurve = CHHapticParameterCurve(
                parameterID: .hapticIntensityControl,
                controlPoints: [
                    CHHapticParameterCurve.ControlPoint(relativeTime: 0.0, value: 0.0),
                    CHHapticParameterCurve.ControlPoint(relativeTime: 0.9, value: 0.6),
                    CHHapticParameterCurve.ControlPoint(relativeTime: 1.8, value: 0.0)
                ],
                relativeTime: 0
            )
            
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [intensityCurve])
            
            // Create a player and start the pattern
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Error creating haptic pattern: \(error)")
        }
    }
}
