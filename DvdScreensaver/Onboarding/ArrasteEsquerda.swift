//
//  OnboardingQuatro.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ArrasteEsquerda: View {
    
    @State private var shouldShow: Bool = false
    
    @State var arraste = 100
    
    var body: some View {
        ZStack{
            NavigationLink("",destination: DoisDedos().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Text("\(Text("Arraste").foregroundColor(.yellow)) para os lados para \(Text("navegar").foregroundColor(.yellow)) pelo menu")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .minimumScaleFactor(15)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(40)

                Circle()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.yellow)
                    .offset(x: CGFloat(arraste))
                    .animation(.easeInOut(duration: 2)
                        .repeatForever(autoreverses: true))

                    .onAppear{
                        arraste = -100
            }
        }.highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
            .onEnded { value in
                if abs(value.translation.height) < abs(value.translation.width) {
                    if abs(value.translation.width) > 50.0 {
                        if value.translation.width < 0 {
                            self.swipeRightToLeft()
                        } else if value.translation.width > 0 {
                            self.swipeLeftToRight()
                        }
                    }
                }
            }
                              )
    }
    func  swipeRightToLeft(){
        shouldShow.toggle()
    }
    func swipeLeftToRight(){
        shouldShow.toggle()
    }
}
struct ArrasteEsquerda_Previews: PreviewProvider {
    static var previews: some View {
        ArrasteEsquerda()
    }
}
