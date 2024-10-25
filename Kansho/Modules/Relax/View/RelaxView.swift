//
//  RelaxView.swift
//  Kansho
//
//  Created by Dason Tiovino on 24/10/24.
//
import SwiftUI

struct RelaxView: View {
    var defaultMaxTimer: Int = 60;
    @State var timer: Int = 60;
    
    var plantImage: String{
        let step = timer / 5
        if(timer > step * 4){
            return "plant_0"
        }else if(timer > step * 3){
            return "plant_1"
        }else if(timer > step * 2){
            return "plant_2"
        }else if(timer > step){
            return "plant_3"
        }else {
            return "plant_4"
        }
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
                            Circle()
                                .frame(width: buttonWidth, height: buttonWidth)
                                .position(CGPoint(
                                    x: width * 50,
                                    y: height * 95)
                                )
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
    
        
    }
}

#Preview {
    RelaxView()
}
