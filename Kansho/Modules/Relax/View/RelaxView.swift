//
//  RelaxView.swift
//  Kansho
//
//  Created by Dason Tiovino on 24/10/24.
//
import SwiftUI
import CoreHaptics

struct RelaxView: View {
    @State var hapticManager: HapticManager = .init()
    
    @State var defaultTimer: Timer?
    @State var defaultHapticTimer: Timer?
    var defaultMaxTimer: Int = 60;
    
    @State var isActive:Bool = false;
    @State var timer: Int = 60;
    @State var plantImage: String = "plant_0"
    
    var timerDisplay: String{
        let minutes = timer / 60
        let remainingSeconds = timer % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    var body: some View {
        ZStack{
            VStack{
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .fill(.appPrimary)
                    .overlay{
                        GeometryReader{ geometry in
                            let width = geometry.size.width / 100
                            let height = geometry.size.height / 100
                            
                            ZStack(alignment: Alignment(
                                horizontal: .leading,
                                vertical: .top)
                            ){
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
                                .padding(.horizontal, 25)
                                .padding(.top, 47)
                                
                                
                                Image(plantImage)
                                    .alignmentGuide(.bottom) { _ in 0 }
                                    .position(CGPoint(
                                        x: width*50,
                                        y: height*45
                                    ))
                                
                                let circleWidth = width * 130
                                Circle()
                                    .fill(.appAccent)
                                    .frame(width: circleWidth, height: circleWidth)
                                    .position(CGPoint(
                                        x: width*50,
                                        y: height * 95)
                                    )
                                
                                let buttonWidth = width * 70
                                Button{
                                    if(!isActive){
                                        self.timerStart()
                                    }else{
                                        self.timerStop()
                                    }
                                    
                                }label:{
                                    
                                    Circle()
                                        .fill(.appSecondary)
                                        .frame(
                                            width: buttonWidth,
                                            height: buttonWidth
                                        )
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
                                        .position(CGPoint(
                                            x: width * 50,
                                            y: height * 95)
                                        )
                                }
                            }
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity,
                                alignment: Alignment(
                                    horizontal: .leading,
                                    vertical: .top
                                )
                            )
                            .clipped()
                            .cornerRadius(30)
                        }
                    }
                
                Button{
                    
                } label: {
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                        .fill(.appPrimary)
                        .overlay{
                            
                        }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 100
                )
            }
        }.padding()
        .onAppear{
            self.hapticManager.prepareHapticEngine()
        }
    }
    
    func updatePlantImage(){
        let step = defaultMaxTimer / 5
        if(timer > step * 4){
            plantImage = "plant_0"
        }else if(timer > step * 3){
            plantImage = "plant_1"
        }else if(timer > step * 2){
            plantImage = "plant_2"
        }else if(timer > step){
            plantImage = "plant_3"
        }else {
            plantImage = "plant_4"
        }
    }
    
    func timerStart(){
        isActive = true
        defaultHapticTimer = Timer.scheduledTimer(withTimeInterval: 1.8, repeats: true){_ in 
            hapticManager.generateHapticPattern()
        }
        defaultTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            updatePlantImage()
            timer -= 1
        }
    }
    
    func timerStop(){
        isActive = false
        timer = 60
        defaultTimer?.invalidate()
    }
}

#Preview {
    RelaxView()
}
