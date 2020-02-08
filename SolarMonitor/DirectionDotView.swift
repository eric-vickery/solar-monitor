//
//  DirectionDotView.swift
//
//  Created by Eric Vickery on 11/14/18.
//  Copyright © 2018 Eric Vickery. All rights reserved.
//

import UIKit
import GLKit

enum ViewEdge: UInt
{
	case top = 1
	case bottom = 2
	case left = 3
	case right = 4
}

enum Direction: UInt
{
	case stopped = 0
	case forward = 1
	case reverse = 2
}

@IBDesignable class DirectionDotView: UIView
{
	@IBInspectable var entryEdge: UInt = ViewEdge.top.rawValue
	@IBInspectable var exitEdge: UInt = ViewEdge.bottom.rawValue
	
	@IBInspectable var dotRadius: Float = 5.0
	@IBInspectable var gapSize: Float = 5.0
	@IBInspectable var lineWidth: Float = 3.0
	@IBInspectable var dotColor: UIColor = UIColor.black
	@IBInspectable var activeDotColor: UIColor = UIColor.red

	private var flowDirection: Direction = .stopped
	private var numberOfDots = 0
	private var dotArray: [Dot]?
	
	private var flowTimer: Timer?
	private var flowPosition: UInt = 0
	
	private class Dot
	{
		var center: CGPoint
		var radius: Float
		var active: Bool = false
		
		init(center: CGPoint, radius: Float)
		{
			self.center = center
			self.radius = radius
		}
	}
	
	func startFlow(direction: Direction)
	{
		flowDirection = direction
		
		switch direction
		{
			case .stopped:
				flowTimer?.invalidate()
				break
			
			case .forward, .reverse:
				flowTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(flowTick(timer:)), userInfo: nil, repeats: true)
				break
		}
	}

	@objc func flowTick(timer: Timer!)
	{
		moveFlowPosition(flowDirection)
		self.setNeedsDisplay()
	}
	
	func moveFlowPosition(_ direction: Direction)
	{
		var makeNextActive = false
		var firstDot = true
		
		switch direction
		{
			case .stopped:
				// Clear all the active flags
				if let dotArray = dotArray
				{
					for dot in dotArray
					{
						dot.active = false
					}
				}
				break
			
			case .forward:
				if let dotArray = dotArray
				{
					for dot in dotArray
					{
						if firstDot && !dot.active
						{
							dot.active = true
							firstDot = false
							continue
						}
						
						if makeNextActive
						{
							dot.active = true
							makeNextActive = false
							continue
						}
						
						if dot.active
						{
							dot.active = false
							makeNextActive = true
						}
						firstDot = false
					}
				}
				break
			
			case .reverse:
				break
		}
	}

	func calculateNumberOfDots(dotRadius: Float, gapSize: Float, entryLocation: ViewEdge, exitLocation: ViewEdge) -> Int
	{
		let dotDiameter = dotRadius * 2
		
		let width = Float(self.bounds.width)
		let height = Float(self.bounds.height)
		
		var totalDotDistance: Float = 0.0

		if entryLocation == .top
		{
			if exitLocation == .bottom
			{
				totalDotDistance = height
			}
		}
		else if entryLocation == .bottom
		{
			if exitLocation == .top
			{
				totalDotDistance = height
			}
		}
		else if entryLocation == .left
		{
			if exitLocation == .right
			{
				totalDotDistance = width
			}
		}
		else if entryLocation == .right
		{
			if exitLocation == .left
			{
				totalDotDistance = width
			}
		}

		return Int(totalDotDistance / (dotDiameter + gapSize))
	}
	
	private func buildDotArray(numberOfDots: Int, dotRadius: Float, gapSize: Float, entryLocation: ViewEdge, exitLocation: ViewEdge) -> [Dot]
	{
		let dotDiameter = dotRadius * 2
		
		var dotArray: [Dot] = [Dot]()
		
		let width = Float(self.bounds.width)
		let height = Float(self.bounds.height)
		let midWidth = width / 2
		let midHeight = height / 2
		
		if entryLocation == .top
		{
			if exitLocation == .bottom
			{
				let startingHeight = height - ((dotRadius / 2) + gapSize)
				
				for index in (0..<numberOfDots).reversed()
				{
					let dotCenter = CGPoint(x: CGFloat(midWidth), y: CGFloat(startingHeight - ((dotDiameter + gapSize)*Float(index))))
					let dot = Dot(center: dotCenter, radius: dotRadius)
					dotArray.append(dot)
				}
			}
		}
		else if entryLocation == .bottom
		{
			if exitLocation == .top
			{
				let startingHeight = height - ((dotRadius / 2) + gapSize)
				
				for index in 0..<numberOfDots
				{
					let dotCenter = CGPoint(x: CGFloat(midWidth), y: CGFloat(startingHeight - ((dotDiameter + gapSize)*Float(index))))
					let dot = Dot(center: dotCenter, radius: dotRadius)
					dotArray.append(dot)
				}
			}
		}
		else if entryLocation == .left
		{
			if exitLocation == .right
			{
				let startingWidth = width - ((dotRadius / 2) + gapSize)
				
				for index in 0..<numberOfDots
				{
					let dotCenter = CGPoint(x: CGFloat(startingWidth - ((dotDiameter + gapSize)*Float(index))), y: CGFloat(midHeight))
					let dot = Dot(center: dotCenter, radius: dotRadius)
					dotArray.append(dot)
				}
			}
		}
		else if entryLocation == .right
		{
			if exitLocation == .left
			{
				let startingWidth = width - ((dotRadius / 2) + gapSize)
				
				for index in (0..<numberOfDots).reversed()
				{
					let dotCenter = CGPoint(x: CGFloat(startingWidth - ((dotDiameter + gapSize)*Float(index))), y: CGFloat(midHeight))
					let dot = Dot(center: dotCenter, radius: dotRadius)
					dotArray.append(dot)
				}
			}
		}

		return dotArray
	}

	override func draw(_ rect: CGRect)
	{
		guard let context:CGContext = UIGraphicsGetCurrentContext() else { return }

		var lineColor = UIColor.black
		// See if the dot array needs to be rebuilt
		if dotArray == nil
		{
			numberOfDots = calculateNumberOfDots(dotRadius: dotRadius, gapSize: gapSize, entryLocation: ViewEdge(rawValue: entryEdge)!, exitLocation: ViewEdge(rawValue: exitEdge)!)
			dotArray = buildDotArray(numberOfDots: numberOfDots, dotRadius: dotRadius, gapSize: gapSize, entryLocation: ViewEdge(rawValue: entryEdge)!, exitLocation: ViewEdge(rawValue: exitEdge)!)
		}
		
		if let dotArray = dotArray
		{
			for dot in dotArray
			{
				if dot.active
				{
					lineColor = self.activeDotColor
				}
				else
				{
					lineColor = self.dotColor
				}
				
				drawCircle(context: context, centerPoint: dot.center, radius: CGFloat(dot.radius), lineColor: lineColor, lineWidth: CGFloat(lineWidth), filled: true)
			}
		}
	}

func drawCircle (context: CGContext, centerPoint: CGPoint, radius: CGFloat, lineColor: UIColor, lineWidth: CGFloat, filled: Bool)
	{
		let insetRadius = radius - (lineWidth/2)
		let insetDiameter = insetRadius*2
		context.saveGState()
		
		if filled
		{
			context.setFillColor(lineColor.cgColor)
		}
		context.setLineWidth(lineWidth)
		context.setStrokeColor(lineColor.cgColor)

		let rect = CGRect(x: centerPoint.x - insetRadius, y: centerPoint.y - insetRadius, width: insetDiameter, height: insetDiameter)
		context.addEllipse(in: rect)
		context.drawPath(using: .fillStroke)
		
		context.restoreGState()
	}

func drawArc (context: CGContext, centerPoint: CGPoint, radius: CGFloat, lineColor: UIColor, lineWidth: CGFloat, startingAngleInDegrees: Float, endingAngleInDegrees: Float)
	{
		context.saveGState()
		
		context.setLineWidth(lineWidth)
		context.setStrokeColor(lineColor.cgColor)
		
		let startAngle: CGFloat = CGFloat(GLKMathDegreesToRadians(90.0 + startingAngleInDegrees))
		let endAngle: CGFloat = CGFloat(GLKMathDegreesToRadians(90.0 + endingAngleInDegrees))
		context.addArc(center: centerPoint, radius: radius - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: false)
		context.strokePath()
		
		context.restoreGState()
	}
}
