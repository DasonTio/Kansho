//
//  MQTTManager.swift
//  Kansho
//
//  Created by Dason Tiovino on 03/12/24.
//

import SwiftMQTT
import Foundation

protocol MQTTManagerProtocol{
    
    func connect()
    func subscribe(topic:String)
    func publish(topic:String, message:String)
    func disconnect()
}

class MQTTManager: MQTTManagerProtocol, MQTTSessionDelegate {
    public static let shared = MQTTManager()
    
    private let session: MQTTSession
    
    private init(){
        session = MQTTSession(
            host: "192.168.250.171",
            port: 1883,
            clientID: "kansho-mqtt-client-swift",
            cleanSession: true,
            keepAlive: 15
        )
        
        session.delegate = self
    }
    
    public func connect(){
        session.connect { error in
            if error == .none {
                self.subscribe(topic: "Dason/VibratorControl")
            }else{
                print(error.description)
            }
        }
    }
    
    public func subscribe(topic: String){
        session.subscribe(to: topic, delivering: .atLeastOnce){ error in
            if error == .none {
                print("Subscribed to \(topic)!")
            } else {
                print(error.description)
            }
        }
    }
    
    public func publish(topic: String, message: String){
        
        session.publish(Data(message.utf8), in: topic, delivering: .atLeastOnce, retain: false){error in
            if error == .none {
                print("Published data in \(topic)!")
            } else {
                print(error.description)
            }
        }
    }
    
    public func disconnect(){
        session.disconnect()
    }
    
    func mqttDidReceive(message: SwiftMQTT.MQTTMessage, from session: SwiftMQTT.MQTTSession) {
        print("Receive Message!")
        print(message)
        print(session)
    }
    
    func mqttDidAcknowledgePing(from session: SwiftMQTT.MQTTSession) {
        print("Acknowledged Ping!")
        print(session)
    }
    
    func mqttDidDisconnect(session: SwiftMQTT.MQTTSession, error: SwiftMQTT.MQTTSessionError) {
        print("Disconnected")
    }
}

class MockMQTTManager: MQTTManagerProtocol{
    var isConnected: Bool = false
    var isSubscribed: Bool = false
    var publishedMessages: [(topic: String, message: String)] = []

    func connect() {
        isConnected = true
    }
    
    func subscribe(topic: String) {
        isSubscribed = true
    }
    
    func publish(topic: String, message: String) {
        publishedMessages.append((topic, message))
    }
    
    func disconnect() {
        isConnected = false
    }
    
    
    
}
