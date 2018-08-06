//
//  SQLManager.swift
//  DemoSaveDataWithSQL
//
//  Created by Nguyen Nam on 12/26/17.
//  Copyright © 2017 Nguyen Nam. All rights reserved.
//

import Foundation
import SQLite

class SQliteManager {
    
    private static let instance = SQliteManager()
    public static func getInstance() -> SQliteManager{
        return instance
    }
    
    var database:Connection!
    let foodTable = Table("foods")
    // column of food table
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let image = Expression<String?>("description")
    let rate = Expression<Int>("rate")
    
    private init() {
        do{
            let documentDirectory = try FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("foods").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            createTable()
        }catch {
            print(error)
        }
    }
    
    private func createTable(){
        
       let tableBuilder =  self.foodTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.image)
            table.column(self.rate)
        }
        do{
            try self.database.run(tableBuilder)
            print("created table")
        }catch{
            print(error)
        }
    }
    
    public func insertFood(food:Food){
        let insertFoodQuery = self.foodTable.insert([self.name <- food.name, self.image <- food.image , self.rate <- food.rate])
        do{
            try self.database.run(insertFoodQuery)
            print("inserted food")
        }catch{
            print(error)
        }
    }
    
    public func updateFood(food:Food){
        // fetch food will update 
        let foodFilter = self.foodTable.filter(self.id == food.id)
        let updateFoodQuery = foodFilter.update([self.name <- food.name , self.image <- food.image
            , self.rate <- food.rate])
        do{
            try self.database.run(updateFoodQuery)
            print("updated food")
        }catch{
            print(error)
        }
    }
    
    public func deleteFoodById(_ foodId:Int){
        let foodFilter = self.foodTable.filter(self.id == foodId)
        let deleteFoodQuery = foodFilter.delete()
        do{
            try self.database.run(deleteFoodQuery)
            print("deleted food")
        }catch {
            print(error)
        }
    }
    
    public func fetchFood() -> [Food]{
        var foods:[Food]?
        do{
            foods = [Food]()
            let users = try self.database.prepare(self.foodTable)
            for user in users{
                let food = Food(user[self.name], user[self.image], user[self.rate])
                foods?.append(food)
            }
        }catch {
            print(error)
        }
        return foods!
    }
    
}













