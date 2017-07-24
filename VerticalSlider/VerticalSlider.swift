//
//  VerticalSlider.swift
//  VerticalSlider
//
//  Created by Arthur Roolfs on 7/20/17.
//
//

import UIKit

protocol VerticalSliderDelegate: class {
	func valueDidChange(_ value: Double)
}


@IBDesignable
class VerticalSlider: UIControl {
	
	/// These values can be set in our storyboard
	@IBInspectable public var minValue: CGFloat = 0.0
	@IBInspectable public var minColor: UIColor = .blue

	@IBInspectable public var maxValue: CGFloat = 1.0
	@IBInspectable public var maxColor: UIColor = .lightGray

	@IBInspectable public var thumbCorner: CGFloat = 10.0
	@IBInspectable public var thumbColor: UIColor = .green
	
	@IBInspectable public var trackWidth: CGFloat = 5.0

	@IBInspectable public var value: CGFloat = 0.2 {
		didSet {
			
			if value > maxValue {
				value = maxValue
			}
			if value < minValue {
				value = minValue
			}
			delegate?.valueDidChange(Double(value))
			updateThumbRect()
		}
	}
	
	/// Standard thumb size for UISlider
	let thumbSize = CGSize(width: 42, height: 31)

	lazy var trackLength: CGFloat = {
		return self.bounds.height - (self.thumbOffset * 2)
	}()
	
	lazy var thumbOffset: CGFloat = {
		return self.thumbSize.height / 2
	}()
	
	var thumbRect: CGRect!
	var isMoving = false

	weak var delegate: VerticalSliderDelegate?
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentMode = .redraw
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		self.isUserInteractionEnabled = true
		contentMode = .redraw
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		updateThumbRect()
	}
	
	class override var requiresConstraintBasedLayout: Bool {
		return true
	}

	override func draw(_ rect: CGRect) {
		
		let context = UIGraphicsGetCurrentContext()
		
		/// draw the max track
		let x = bounds.width / 2 - trackWidth / 2
		let maxTrackRect = CGRect(x: x, y: 0, width: trackWidth, height: yFromValue(value))
		let maxTrack = UIBezierPath(roundedRect: maxTrackRect, cornerRadius: 6)
		maxColor.setFill()
		maxTrack.fill()
		
		/// draw the min track
		let h = bounds.height
		let minTrackRect = CGRect(x: x, y: yFromValue(value), width: trackWidth, height: h - yFromValue(value))
		let minTrack = UIBezierPath(roundedRect: minTrackRect, cornerRadius: 6)
		minColor.setFill()
		minTrack.fill()

		/// draw the thumb
		let thumbFrame = CGRect(origin: thumbRect.origin, size: thumbRect.size)
		let thumb = UIBezierPath(roundedRect: thumbFrame, cornerRadius: thumbCorner)
		thumbColor.setFill()
		thumb.fill()
		
		context?.saveGState()
		context?.restoreGState()
	}
	
// MARK: - Standard Control Overrides
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		
		if thumbRect.contains(touch.location(in: self)) {
			isMoving = true
		}
		return true
	}
	
	override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		
		let location = touch.location(in: self)
		if isMoving {
			
			let value = valueFromY(location.y)
			
				if value != minValue && value != maxValue {
					self.value = value
					setNeedsDisplay()
				}
		}
		return true
	}
	
	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		isMoving = false
	}
	
	// MARK: - Utility
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		updateThumbRect()
	}
	
	func valueFromY(_ y: CGFloat) -> CGFloat {
		let yOffset = bounds.height - thumbOffset - y
		return (yOffset * maxValue) / trackLength
	}
	
	func yFromValue(_ value: CGFloat) -> CGFloat {
		let y = (value * trackLength) / maxValue
		return bounds.height - thumbOffset - y
	}
	
	func updateThumbRect() {
		thumbRect = CGRect(origin: CGPoint(x: 0, y: yFromValue(value) - (thumbSize.height / 2)), size: thumbSize)
	}
	
}






















