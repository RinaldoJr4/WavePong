//
//  Wave.swift
//  DvdScreensaver
//
//  Created by mvitoriapereirac on 27/10/22.
//

import Foundation
import SwiftUI

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
