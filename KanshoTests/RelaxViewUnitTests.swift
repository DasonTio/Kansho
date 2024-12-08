//
//  RelaxViewUnitTests.swift
//  Kansho
//
//  Created by Dason Tiovino on 08/12/24.
//

import Testing
import Combine
import AVFAudio
@testable import Kansho

class MockAVAudioPlayer: AVAudioPlayer {
    var playCalled = false
    var stopCalled = false
    
    override func play() -> Bool {
        playCalled = true
        return true
    }
    
    override func stop() {
        stopCalled = true
    }
}

struct RelaxViewUnitTests {
    
    var hapticManager: MockHapticManager = .init()
    var mqttManager: MockMQTTManager = .init()
    lazy var viewModel: RelaxViewModel = .init(
        hapticManager: hapticManager,
        mqttManager: mqttManager,
        breathInAudio: MockAVAudioPlayer(),
        breathOutAudio: MockAVAudioPlayer()
    )
    
    var cancellables: Set<AnyCancellable> = .init()
    
    @Test mutating func toggleTimeStartTimer() async throws {
        self.viewModel.toggleTimer()
                
        #expect(viewModel.isActive == true)
        #expect(mqttManager.publishedMessages.count == 1)
        #expect(mqttManager.publishedMessages.first?.topic == "Dason/Mobile/Relax")
        #expect(mqttManager.publishedMessages.first?.message == "Hello it's from publisher")
        #expect(hapticManager.isHapticGenerated == true)
        #expect(viewModel.timerCancellable != nil)
    }

}
