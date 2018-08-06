//
//  ViewController.swift
//  DemoAppRealtime
//
//  Created by Nguyen Nam on 9/21/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit
import SocketIO


class ViewController: UIViewController {
    
    let socket = SocketIOClient(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
    
    
    //    let buttonSend:UIButton = {
    //       let button = UIButton(type: UIButtonType.system)
    //        button.setTitle("Send", for: .normal)
    //        button.setTitleColor(UIColor.blue, for: .normal)
    //        button.backgroundColor = UIColor.red
    //        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    //        return button
    //    }()
    let blueView  = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        socket.on(clientEvent: .connect) { (data, ack) in
            print("socket connected")
        }
        socket.connect()
        
        //        let buttonSend = UIButton(type: UIButtonType.system)
        //        view.addSubview(buttonSend)
        //        buttonSend.setTitle("Send", for: .normal)
        //        buttonSend.setTitleColor(UIColor.blue, for: .normal)
        //        buttonSend.backgroundColor = UIColor.red
        //        buttonSend.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        //        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        //        buttonSend.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        buttonSend.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
         view.addSubview(blueView)
        blueView.backgroundColor = UIColor.blue
//        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.isUserInteractionEnabled = true
        blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addContraintWithFormat(format: "H:|[v0(100)]|", views: blueView)
        view.addContraintWithFormat(format: "V:|[v0(100)]|", views: blueView)
        
        blueView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(sendLocation)))
        
        // call back event
        socket.on("give-back-location") { (data, ack) in
            let array = data[0] as! Array<CGFloat>
            self.blueView.layer.transform = CATransform3DTranslate(CATransform3DIdentity, array[0], array[1], 0)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func sendLocation(sender:UIPanGestureRecognizer){
        let point = sender.location(in: view)
        socket.emit("get-location", with: [[point.x, point.y]])
    }
    
    func sendMessage(){
        socket.emit("client-send-message", with: ["Xin chao anh Nam", 97])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension UIView{
    func addContraintWithFormat(format:String,views:UIView...){
        var dictionary = [String:UIView]()
        for (index,item) in views.enumerated() {
            let key = "v\(index)"
            dictionary[key] = item
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))
    }
}
