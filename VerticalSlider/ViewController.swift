//
//  ViewController.swift
//  VerticalSlider
//
//  Created by Arthur Roolfs on 7/20/17.
//
//

import UIKit

/// Subclassed UISlider
@IBDesignable
open class VerticalUISlider: UISlider {
	
	override open func draw(_ rect: CGRect) {
		self.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
	}
}


class ViewController: UIViewController {
	
	@IBOutlet weak var slider: UISlider! {
		didSet {
			slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
		}
	}
	@IBOutlet weak var subclassedSlider: VerticalUISlider!
	@IBOutlet weak var verticalSliderCtrl: VerticalSlider!
	
	@IBOutlet weak var sliderOne: UILabel!
	@IBOutlet weak var sliderTwo: UILabel!
	@IBOutlet weak var sliderThree: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// declare ourselves as VerticalSlider delegate
		verticalSliderCtrl.delegate = self
		
		sliderOne.text = String(format: "%.2f", slider.value)
		sliderTwo.text = String(format: "%.2f", subclassedSlider.value)
		sliderThree.text = String(format: "%.2f", verticalSliderCtrl.value)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	// MARK: - Actions
	@IBAction func onSliderOne(_ sender: UISlider) {
		sliderOne.text = String(format: "%.2f", sender.value)
	}
	
	@IBAction func onSliderTwo(_ sender: VerticalUISlider) {
		sliderTwo.text = String(format: "%.2f", sender.value)
	}
	
}

extension ViewController: VerticalSliderDelegate {
	
	func valueDidChange(_ value: Double) {
		sliderThree.text = String(format: "%.2f", value)
	}

}






