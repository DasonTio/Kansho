//
//  MainLayout.swift
//  Kansho
//
//  Created by Dason Tiovino on 26/10/24.
//

import SwiftUI

struct RelaxViewMainLayout: View {
    @EnvironmentObject var relaxViewModel: RelaxViewModel 
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .fill(.appPrimary)
            .overlay {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    headerView
                    plantImageView
                    actionSelect
                    actionButton
                }
                .clipped()
                .cornerRadius(30)
            }
    }
    
    // MARK: - Subviews
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(relaxViewModel.selectedRelaxOption == .Haptic ? "Haptic\nFeedback" : "Breathing\nMethod")
                    .font(.themeTitle(weight: .heavy))
                    .animation(.easeInOut, value: relaxViewModel.selectedRelaxOption)
                Link(destination: URL(string: "https://dl.acm.org/doi/abs/10.1145/2994310.2994368")!) {
                    HStack {
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
        .opacity(relaxViewModel.isActive ? 0.4 : 1)
        .animation(.easeInOut, value: relaxViewModel.isActive)
        .padding(.horizontal, 25)
        .padding(.top, 47)
    }
    
    private var plantImageView: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 100
            let height = geometry.size.height / 100
            
            Image(relaxViewModel.plantImage)
                .alignmentGuide(.bottom) { _ in 0 }
                .position(x: width * 50, y: height * 40)
                .animation(.easeInOut, value: relaxViewModel.plantImage)
        }
    }
    
    private var actionSelect: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 100
            let height = geometry.size.height / 100
            let radius = width * 130
            let circleCenter = CGPoint(x: width * 50, y: height * 100)
            let orbitRadius: CGFloat = 195 // Distance from the circle center to the icons
            let angle = Angle(degrees: 270 - (relaxViewModel.selectedRelaxOption == .Haptic ? 0 : 50)) // Rotation angle

            Circle()
                .fill(Color.appAccent)
                .frame(width: radius, height: radius)
                .position(circleCenter)
                .overlay {
                    ZStack {
                        // Calculate new positions for the images using trigonometry
                        Button(action: {
                            relaxViewModel.selectedRelaxOption = .Haptic
                        }){
                            Image("haptic_icon")
                                .opacity(relaxViewModel.selectedRelaxOption == .Haptic ? 1 : 0.5)
                                .animation(.easeInOut, value: angle)
                        }.position(
                            x: circleCenter.x + orbitRadius * cos(angle.radians),
                            y: circleCenter.y + orbitRadius * sin(angle.radians)
                        )
                        
                        Button(action:{
                            relaxViewModel.selectedRelaxOption = .Breath
                        }){
                            Image("breathing_icon")
                                .opacity(relaxViewModel.selectedRelaxOption == .Breath ? 1 : 0.5)
                                .animation(.easeInOut, value: angle)
                        }.position(
                            x: circleCenter.x + orbitRadius * cos(angle.radians + .pi / 4),
                            y: circleCenter.y + orbitRadius * sin(angle.radians + .pi / 3.2)
                        )
                        
                    }
                }
                
        }
    }
    
    private var actionButton: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / 100
            let height = geometry.size.height / 100
            
            let radius = width * 70
            Button(action: relaxViewModel.toggleTimer) {
                Circle()
                    .fill(.appSecondary)
                    .overlay {
                        if !relaxViewModel.isActive {
                            VStack {
                                Image("hourglass_image")
                                Text("tap here to start")
                                    .font(.themeCaption())
                                    .foregroundStyle(Color.white)
                            }
                            .offset(x: 0, y: -30)
                        } else {
                            Text(relaxViewModel.timerDisplay)
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
}
