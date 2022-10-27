//
//  ContentView.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var cloudHeight: CGFloat = 0.0
    @State var score: Int = 0
    var body: some View {
        
        GeometryReader{
            geo in
            ZStack{
                
                SpriteView(scene: skScene)
                    .frame(width: geo.size.width, height: geo.size.height)
                
                
            }
            .ignoresSafeArea()
            
//            WaveForm(color: Color.white, amplify: 140, cloudHeight: self.cloudHeight, isReversed: false)
//                .frame(height: 6/7 * geo.size.height)
//                .ignoresSafeArea()
            
            WaveForm(color: Color.yellow.opacity(0.5), amplify: 70, cloudHeight: self.cloudHeight, isReversed: true)
                .frame(height: 6/7 * geo.size.height)
                .ignoresSafeArea()
            
            WaveForm(color: Color.blue.opacity(0.8), amplify: 140, cloudHeight: self.cloudHeight, isReversed: true)
                .frame(height: 6/7 * geo.size.height)
                .ignoresSafeArea()
            
            WaveForm(color: Color.yellow.opacity(0.5), amplify: 200, cloudHeight: self.cloudHeight, isReversed: false)
                .frame(height: 6/7 * geo.size.height)
                .ignoresSafeArea()
            
            
            
            WaveForm(color: Color.purple.opacity(0.9), amplify: 140, cloudHeight: self.cloudHeight, isReversed: false)
                .frame(height: 6/7 * geo.size.height)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 40){
                Text("Toque a tela com dois dedos para pausar")
                    .font(Font.subheadline)
                    .foregroundColor(Color.white)
                    
                Text("\(score)")
                    .font(Font.subheadline)
                    .foregroundColor(Color.white)

                
                

            }
            .padding(50)
            
           

        }
        .ignoresSafeArea()
        
    
    }

    var skScene: SKScene{ // SKScene lembra muito uma view
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let ballNode = SKSpriteNode(imageNamed: "neonBall")  // Node = Objetos
        ballNode.size = CGSize(width: 60, height: 60)
        
        let raqueteNode = SKSpriteNode(color: .purple, size: CGSize(width: UIScreen.main.bounds.width/2.5, height: 25))
        let nuvemNode = SKSpriteNode(color: .clear, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))


        
        let scene = PongScene(ballNode: ballNode, size: viewFrame.size, raquete: raqueteNode, nuvem: nuvemNode, cloudHeight: $cloudHeight, score: $score)
//        scene.backgroundColor = .darkGray
//        scene.cloudHeight = $cloudHeight
        return scene
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
//let π = CGFloat(Double.pi)
//
//extension SKAction {
//    static func oscillation(amplitude a: CGFloat, timePeriod t: CGFloat, midPoint: CGPoint) -> SKAction {
//        let action = SKAction.customAction(withDuration: Double(t)) { node, currentTime in
//            let displacement = a * sin(2 * π * currentTime / t)
//            node.position.y = midPoint.y + displacement
//        }
//
//        return action
//    }
//}
struct WaveForm: View {
    var color: Color
    var amplify: CGFloat
    var cloudHeight: CGFloat
    var isReversed: Bool
//  var waveHeight: CGFloat
  var body: some View {
    TimelineView(.animation) { timeLine in
      Canvas{context, size in
        let timeNow = timeLine.date.timeIntervalSinceReferenceDate
        let angle = timeNow.remainder(dividingBy: 2)
        let offset = angle * size.width
        context.draw(Text("\(angle)"), at: CGPoint(x: size.width / 2, y: -100))
          context.translateBy(x: isReversed ? -offset: offset, y: size.height - cloudHeight)
        context.fill(getPath(size: size), with: .color(color))
        context.translateBy(x: -size.width, y: 0)
        context.fill(getPath(size: size), with: .color(color))
        context.translateBy(x: size.width * 2, y: 0)
        context.fill(getPath(size: size), with: .color(color))
      }
    }
  }
    func getPath(size: CGSize) -> Path {
      return Path{path in
        let midHeight = size.height / 2
        let width = size.width
        path.move(to: CGPoint(x: 0, y: midHeight))
        path.addCurve(to: CGPoint(x: width, y: midHeight), control1: CGPoint(x: width * 0.4, y: midHeight - amplify), control2: CGPoint(x: width * 0.65, y: midHeight + amplify))
        path.addLine(to: CGPoint(x: width, y: 1 - size.height))
        path.addLine(to: CGPoint(x: 0, y: 1 - size.height))
    }
  }
}
