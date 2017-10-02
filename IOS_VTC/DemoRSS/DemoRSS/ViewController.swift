//
//  ViewController.swift
//  DemoRSS
//
//  Created by Nguyen Nam on 8/30/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    public var feedURl:String?
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    let artistLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    var image:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds =  true
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        view.addSubview(titleLabel)
        view.addSubview(artistLabel)
        view.addSubview(image)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10).isActive = true
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: feedURl!)!), completionHandler: {(data,reponse,error) in
            DispatchQueue.main.async {
                if let jsonData = data,
                    let feed = (try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)) as? NSDictionary,
                    let title = feed.value(forKeyPath: "feed.entry.im:name.label") as? String,
                    let artist = feed.value(forKeyPath: "feed.entry.im:artist.label") as? String,
                    let imageURL = feed.value(forKeyPath: "feed.entry.im:image") as? [NSDictionary]{
                    if let imageUrl = imageURL.last{
                        let imageURlString = imageUrl.value(forKeyPath: "label") as? String
//                        self.loadImageFromURL(url: imageURlString!)
                        var data:Data
                        do{
                            data = try Data(contentsOf: URL(string: imageURlString!)!)
                            let image = UIImage(data: data)
                            self.image.image = image
                        }catch{
                            
                        }
                    }
                    self.titleLabel.text = title
                    self.artistLabel.text = artist
                }
            }
        }).resume()
        
    }
    /*
    func loadImageFromURL(url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {(data,reponse,error) in
            DispatchQueue.main.async(execute: {() -> Void
                in
                let image = UIImage(data: data!)
                self.image.image = image
            })
        }).resume()
    }*/
}


class TabbarViewController :UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let topSongViewController = TopViewController()
        topSongViewController.feedURl = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topsongs/limit=1/json"
        let songNavigation = UINavigationController(rootViewController: topSongViewController)
        songNavigation.title = "Top Song"
        songNavigation.tabBarItem.image = #imageLiteral(resourceName: "Top Song Icon")
        
        let topMovieViewController = TopViewController()
        topMovieViewController.feedURl = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/limit=1/json"
        let movieNavigation = UINavigationController(rootViewController: topMovieViewController)
        movieNavigation.title = "Top Movie"
        movieNavigation.tabBarItem.image = #imageLiteral(resourceName: "Top Movie Icon")
        
        
        let topAlbumViewController = TopViewController()
        topAlbumViewController.feedURl = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topalbums/limit=1/json"
        let albumNavigation = UINavigationController(rootViewController: topAlbumViewController)
        albumNavigation.title = "Top Album"
        albumNavigation.tabBarItem.image = #imageLiteral(resourceName: "Top Album Icon")
        
        let topAppViewController = TopViewController()
        topAppViewController.feedURl = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=1/json"
        let appNavigation = UINavigationController(rootViewController: topAppViewController)
        appNavigation.title = "Top App"
        appNavigation.tabBarItem.image = #imageLiteral(resourceName: "Top App Icon")
        
        viewControllers = [songNavigation,albumNavigation,appNavigation,movieNavigation]
    }
}

