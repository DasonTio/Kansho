//
//  RelaxView.swift
//  Kansho
//
//  Created by Dason Tiovino on 24/10/24.
//
import SwiftUI

struct RelaxView: View {
    var body: some View {
        ZStack{
            VStack{
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                .fill(.appPrimary)
                .overlay{
                    ZStack{
                        
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
                            
                    }
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: Alignment(
                            horizontal: .leading,
                            vertical: .top
                        )
                    )
                }
                
                Button{
                    // Journaling Event
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
