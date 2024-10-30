//
//  RelaxViewModel.swift
//  Kansho
//
//  Created by Dason Tiovino on 27/10/24.
//
import SwiftUI
import Combine

class RelaxViewModel: ObservableObject {
    
    @Published var isActive: Bool = false
    @Published var isJournaling: Bool = false
    
    @Published var timer: Double = 0
    @Published var plantImage: String = "plant_0"
    
    public let defaultMaxTimer:Double = 10
    private var timerCancellable: AnyCancellable?
    public var hapticManager: HapticManager
    
    init(hapticManager: HapticManager) {
        self.hapticManager = hapticManager
        self.timer = defaultMaxTimer
    }
    
    var timerDisplay: String {
        let minutes = Int(timer) / 60
        let seconds = Int(timer) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func toggleTimer() {
        if isActive {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isActive = true
        hapticManager.generateHapticPattern()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    private func stopTimer() {
        isActive = false
        timer = defaultMaxTimer
        hapticManager.stopHapticPattern()
        timerCancellable?.cancel()
    }
    
    private func updateTimer() {
        if timer > 0 {
            timer -= 1
            updatePlantImage()
        } else {
            resetTimer()
        }
    }
    
    private func resetTimer() {
        stopTimer()
        updatePlantImage()
    }
    
    private func updatePlantImage() {
        let progress = Double(defaultMaxTimer - timer) / Double(defaultMaxTimer)
        let stage = min(4, Int(progress * 5))
        plantImage = "plant_\(stage)"
    }
}
