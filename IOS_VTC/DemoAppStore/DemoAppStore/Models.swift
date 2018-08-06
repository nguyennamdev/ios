//
//  Models.swift
//  DemoAppStore
//
//  Created by Nguyen Nam on 9/12/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import UIKit

class AppCategory : NSObject{
    var name:String?
    var apps:[App]?
    
    static func fetchFeatureApps(completionHander: @escaping ([AppCategory]) -> ()){
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: urlString)!)) { (data, response, error) in
            if error != nil{
                return
            }
            do{
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                var appCategories = [AppCategory]()
                
                
                if let dictionaries = json as? [String:Any]{
                    let categories = dictionaries["categories"] as? [[String:Any]]
                    for category in categories!{
                        let cate = AppCategory()
                        cate.name = category["name"] as? String
                        
                        // load apps in categories
                        var listApp = [App]()
                        let apps = category["apps"] as? [[String:Any]]
                        for ap in apps!{
                            let app = App()
                            app.name = ap["Name"] as? String
                            app.category = ap["Category"] as? String
                            app.imageName = ap["ImageName"] as? String
                            app.price = ap["Price"] as? NSNumber
                            listApp.append(app)
                        }
                        
                        cate.apps = listApp
                        appCategories.append(cate)
                    }
                }
                DispatchQueue.main.async(execute: {
                    completionHander(appCategories)
                })
                
                
            }catch {
                
            }
            }.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory]{
        let bestNewApps = AppCategory()
        bestNewApps.name = "Best New Apps"
        
        var apps:[App] = [App]()
        let frozenApp = App()
        frozenApp.id = 01
        frozenApp.name = "Disney builder"
        frozenApp.imageName = "frozen"
        frozenApp.price = 3.99
        frozenApp.category = "Entertiment"
        
        
        let bestNewGames = AppCategory()
        bestNewGames.name = "Best New Games"
        
        var games:[App] = [App]()
        let telepaintApp = App()
        telepaintApp.id = 02
        telepaintApp.name = "Telepaint"
        telepaintApp.category = "Games"
        telepaintApp.price = 3.99
        telepaintApp.imageName = "frozen"
        
        
        apps.append(frozenApp)
        
        games.append(telepaintApp)
        
        bestNewApps.apps = apps
        
        bestNewGames.apps = games
        return [bestNewApps, bestNewGames]
    }
}

class App:NSObject{
    var id:NSNumber?
    var name:String?
    var category:String?
    var imageName:String?
    var price:NSNumber?
    
    var screenShots:[String]?
    var des:String?
    var appInfor:Any?
    
    
}
