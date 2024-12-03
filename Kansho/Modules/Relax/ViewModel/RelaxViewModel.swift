//
//  RelaxViewModel.swift
//  Kansho
//
//  Created by Dason Tiovino on 27/10/24.
//
import SwiftUI
import Combine
import AVFoundation


enum RelaxOption{
    case Haptic
    case Breath
}

class RelaxViewModel: ObservableObject {
    
    @Published var currentStep: Int = 0;
    @Published var breathState: BreathState = .BreathIn
    
    @Published var isActive: Bool = false
    @Published var isJournaling: Bool = false
    
    @Published var timer: Double = 0
    @Published var plantImage: String = "plant_0"
    
    @Published var selectedRelaxOption: RelaxOption = .Haptic
    
    public let defaultMaxTimer:Double = 30
    public var timerCancellable: AnyCancellable?
    public var breathCancellable: AnyCancellable?
    public var hapticManager: HapticManager
    
    public var breathInAudio: AVAudioPlayer?
    public var breathOutAudio: AVAudioPlayer?
    
    init(hapticManager: HapticManager) {
        self.hapticManager = hapticManager
        self.timer = defaultMaxTimer
        
        guard let breathInAudioPath = Bundle.main.path(forResource: "BreathIn", ofType: "m4a"),
        let breathOutAudioPath = Bundle.main.path(forResource: "BreathOut", ofType: "m4a") else {
            return
        }
        breathInAudio = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: breathInAudioPath))
        breathOutAudio = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: breathOutAudioPath))
    }
    
    var timerDisplay: String {
        let minutes = Int(timer) / 60
        let seconds = Int(timer) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func toggleTimer() {
        MQTTManager.shared.publish(message: "Publish", onTopic: "Dason/Mobile/Haptic", qos: .qos1)
        if isActive {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        isActive = true
        
        switch selectedRelaxOption {
            case .Haptic:
                startHaptic()
            case .Breath:
                startBreath()
        }
        
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    public func stopTimer() {
        isActive = false
        timer = defaultMaxTimer
        
        switch selectedRelaxOption {
            case .Haptic:
                stopHaptic()
            case .Breath:
                stopBreath()
        }
        
        timerCancellable?.cancel()
    }
    
    public func updateTimer() {
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
