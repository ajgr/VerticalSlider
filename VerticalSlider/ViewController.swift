//
//  ViewController.swift
//  VerticalSlider
//
//  Created by ajgr on 7/20/17.
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
	
	@IBAction func onSliderThree(_ sender: VerticalSlider) {
		sliderThree.text = String(format: "%.2f", sender.value)
	}
	
}





