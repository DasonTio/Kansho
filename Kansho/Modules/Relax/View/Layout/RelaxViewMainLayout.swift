//
//  MainLayout.swift
//  Kansho
//
//  Created by Dason Tiovino on 26/10/24.
//

import SwiftUI
import Combine

struct RelaxViewMainLayout: View{
    @EnvironmentObject var hapticManager: HapticManager
    
    @State private var isActive = false
    @State private var timer = 60
    @State private var plantImage = "plant_0"
    
    private let defaultMaxTimer = 60
    
    private var timerDisplay: String {
        let minutes = timer / 60
        let seconds = timer % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View{
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .fill(.appPrimary)
            .overlay{
                ZStack(alignment: Alignment(
                    horizontal: .leading,
                    vertical: .top)
                ){
                    headerView
                    plantImageView
                    plantBackgroundView
                    actionButton
                }
                .clipped()
                .cornerRadius(30)
                .onReceive(timerPublisher) { _ in
                    guard isActive else { return }
                    if timer > 0 {
                        timer -= 1
                        updatePlantImage()
                    } else {
                        resetTimer()
                    }
                }
            }
    }
    
    
    // MARK: - Subviews
    private var headerView: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8){
                Text("Haptic\nFeedback")
                    .font(.themeTitle(weight: .heavy))
                
                Link(destination: URL(string: "https://dl.acm.org/doi/abs/10.1145/2994310.2994368")!){
                    HStack{
                        Image("symbol_url")
                        Text("Research Prove")
                            .font(.themeFootnote())
                            .foregroundStyle(.appSecondary.opacity(0.4))
                    }
                }
            }
            Spacer()
            Image("circle_logo_image")
        }
        .opacity(isActive ? 0.4 : 1)
        .animation(.easeInOut, value: isActive)
        .padding(.horizontal, 25)
        .padding(.top, 47)
        
    }
    
    private var plantImageView: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 100
            let height = geometry.size.height / 100
            
            Image(plantImage)
                .alignmentGuide(.bottom) {_ in 0}
                .position(x: width * 50, y: height * 50)
                .animation(.easeInOut, value: plantImage)
        }
    }
    
    private var plantBackgroundView: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 100
            let height = geometry.size.height / 100
            let radius = width * 130
            
            Circle()
                .fill(.appAccent)
                .frame(width: radius, height: radius)
                .position(CGPoint(
                    x: width * 50,
                    y: height * 100)
                )
        }
    }
    
    private var actionButton: some View {
        GeometryReader{ geometry in
            let width = geometry.size.width / 100
            let height = geometry.size.height  / 100
            
            let radius = width * 70
            Button(action: toggleTimer){
                Circle()
                    .fill(.appSecondary)
                    .overlay{
                        if (!isActive){
                            VStack{
                                Image("hourglass_image")
                                Text("tap here to start")
                                    .font(.themeCaption())
                                    .foregroundStyle(Color.white)
                            }.offset(x: 0, y: -30)
                        }else {
                            Text(timerDisplay)
                                .foregroundStyle(Color.white)
                                .font(.themeTitle(weight: .heavy))
                                .offset(x: 0, y: -30)
                        }
                    }
            }
            .contentShape(Circle())
            .frame(width: radius, height: radius)
            .position(x: width * 50, y: height * 95)
        }
    }
    
    
    
    // MARK: - Timer
    private var timerPublisher: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    private func toggleTimer() {
        if isActive {
            isActive = false
            timer = defaultMaxTimer
            hapticManager.stopHapticPattern()
        } else {
            isActive = true
            hapticManager.generateHapticPattern()
        }
    }
    
    private func resetTimer() {
        isActive = false
        timer = defaultMaxTimer
        updatePlantImage()
    }
    
    private func updatePlantImage() {
        let progress = Double(defaultMaxTimer - timer) / Double(defaultMaxTimer)
        let stage = min(4, Int(progress * 5))
        plantImage = "plant_\(stage)"
    }
}
