//
//  CustomNavigationControllerViewController.swift
//  Songs App
//
//  Created by Aditya Gautam on 18/05/21.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    static let shared : CustomNavigationController = CustomNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
    
    func setupNavigationBar(){
        let gradient = CAGradientLayer()
        let sizeLength = UIScreen.main.bounds.size.height * 2
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: 100)
        gradient.frame = defaultNavigationBarFrame
        let colorTop = UIColor(red: 255 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1.0)
        let colorBottom = UIColor(red: 0 / 255, green: 0 / 255, blue: 255 / 255, alpha: 1.0)
        gradient.colors = [colorBottom.cgColor, colorTop.cgColor]
        UINavigationBar.appearance().setBackgroundImage(self.image(fromLayer: gradient), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.barStyle = UIBarStyle.black
        self.navigationBar.tintColor = UIColor.white
    }
}
