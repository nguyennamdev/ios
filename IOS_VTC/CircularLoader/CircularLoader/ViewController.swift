//
//  ViewController.swift
//  CircularLoader
//
//  Created by Nguyen Nam on 12/11/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    var shapeLayer = CAShapeLayer()
    var pulsatingLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view 1 did load")
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.backgroudColor
        // let's start by drawing a circle somehow
        
       
        pulsatingLayer = createCircleShapeLayer(strokeColor: UIColor.clear, fillColor: UIColor.pulsatingFillColor)
        view.layer.addSublayer(pulsatingLayer)
        
        animatePulsatingLayer()

        let trackLayer = createCircleShapeLayer(strokeColor: UIColor.trackStrokeColor, fillColor: UIColor.backgroudColor)
        view.layer.addSublayer(trackLayer)

        shapeLayer = createCircleShapeLayer(strokeColor: UIColor.outlineStrokeColor, fillColor: UIColor.clear)
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center

    }
    
    private func createCircleShapeLayer(strokeColor:UIColor, fillColor:UIColor) -> CAShapeLayer{
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.lineWidth = 10
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        layer.position = view.center
        return layer
    }
    
    private func animatePulsatingLayer(){
        let animate = CABasicAnimation(keyPath: "transform.scale")
        animate.toValue = 1.2
        animate.duration = 1
        animate.autoreverses = true
        animate.repeatCount = Float.infinity
        pulsatingLayer.add(animate, forKey: "pulsing")
    }
    
    @objc private func handleTap(){
        print("Tapped")
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        basicAnimation.toValue = 1
//        basicAnimation.duration = 2
//        basicAnimation.fillMode = kCAFillModeForwards
//        basicAnimation.isRemovedOnCompletion = false
//        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        beginDownloadFile()
    }
    
    private func beginDownloadFile(){
        shapeLayer.strokeEnd = 0
        let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue())
        guard let url = URL(string: urlString) else {
            return
        }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Did finish download task ")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.shapeLayer.strokeEnd = CGFloat(percentage)
            self.percentageLabel.text = "\(Int(percentage * 100))%"
        }
    }
    
    let percentageLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
}

extension UIColor {
    static func rgb(r:CGFloat,g:CGFloat, b:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroudColor = rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = rgb(r: 86, g: 30, b: 63)
}



