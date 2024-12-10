//
//  RelaxViewModel+Haptic.swift
//  Kansho
//
//  Created by Dason Tiovino on 08/11/24.
//

import Foundation

extension RelaxViewModel {
func startHaptic() {
        hapticManager.generateHapticPattern()
    }
    
    func stopHaptic(){
        hapticManager.stopHapticPattern()
    }
}
