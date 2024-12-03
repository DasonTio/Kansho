//
//  MQTTManager.swift
//  Kansho
//
//  Created by Dason Tiovino on 03/12/24.
//

import Foundation
import CocoaMQTT

protocol MQTTManagerDelegate: AnyObject {
    func mqttDidConnect(host: String, port: Int)
    func mqttDidDisconnect(error: Error?)
    func mqttDidReceiveMessage(topic: String, message: String)
    func mqttDidSubscribe(topic: String)
    func mqttDidUnsubscribe(topic: String)
    func mqttDidPublish(message: String, onTopic: String)
}

class MQTTManager: NSObject {

    static let shared = MQTTManager()

    private var mqtt: CocoaMQTT?
    weak var delegate: MQTTManagerDelegate?

    private let clientID = "iOSClient-\(UUID().uuidString)"
    private let host = "broker.hivemq.com"
    private let port: UInt16 = 1883
    private let keepAlive: UInt16 = 60
    private let cleanSession = true
    private let username: String? = nil
    private let password: String? = nil

    private override init() {
        super.init()
        setupMQTT()
    }

    private func setupMQTT() {
        mqtt = CocoaMQTT(clientID: clientID, host: host, port: port)
        mqtt?.keepAlive = keepAlive
        mqtt?.delegate = self
        mqtt?.cleanSession = cleanSession

        if let username = username {
            mqtt?.username = username
        }

        if let password = password {
            mqtt?.password = password
        }

        // Optional configurations
        mqtt?.willMessage = CocoaMQTTMessage(topic: "/will", string: "HELLOO")
        mqtt?.autoReconnect = true
    }

    func connect() {
        mqtt?.connect()
    }

    func disconnect() {
        mqtt?.disconnect()
    }

    func publish(message: String, onTopic topic: String, qos: CocoaMQTTQoS = .qos1, retained:Bool = true) {
        mqtt?.publish(topic, withString: message, qos: qos, retained: retained)
        print("Try To Publish")
    }

    func subscribe(topic: String, qos: CocoaMQTTQoS = .qos1) {
        mqtt?.subscribe(topic, qos: qos)
    }

    func unsubscribe(topic: String) {
        mqtt?.unsubscribe(topic)
    }
}

extension MQTTManager: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("Unsubsribced from topics: \(topics)")
    }
    
    
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("Connected to host: \(host) on port: \(port)")
        delegate?.mqttDidConnect(host: host, port: port)
    }

    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        if ack == .accept {
            print("Connection acknowledged by broker.")
            // Optionally, subscribe to topics here
        } else {
            print("Connection failed with ack: \(ack)")
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("Published message: \(message.string ?? "") on topic: \(message.topic)")
        delegate?.mqttDidPublish(message: message.string ?? "", onTopic: message.topic)
    }

    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        // Handle publish acknowledgment if needed
    }

    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("Received message: \(message.string ?? "") on topic: \(message.topic)")
        delegate?.mqttDidReceiveMessage(topic: message.topic, message: message.string ?? "")
    }

    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        for (topic, qos) in success {
            print("Subscribed to topic: \(topic) with QoS: \(qos)")
            delegate?.mqttDidSubscribe(topic: topic as! String)
        }

        for topic in failed {
            print("Failed to subscribe to topic: \(topic)")
            // Handle failed subscriptions if necessary
        }
    }

    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("Unsubscribed from topic: \(topic)")
        delegate?.mqttDidUnsubscribe(topic: topic)
    }

    func mqttDidPing(_ mqtt: CocoaMQTT) {
        // Optional: Handle ping if needed
    }

    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        // Optional: Handle pong if needed
    }

    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("Disconnected from MQTT broker.")
        if let error = err {
            print("Error: \(error.localizedDescription)")
        }
        delegate?.mqttDidDisconnect(error: err)
    }
}

