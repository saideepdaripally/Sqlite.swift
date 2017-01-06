//
//  ActorDb.swift
//  SqliteDemo
//
//  Created by Kvana Dev Ipod on 03/01/17.
//  Copyright © 2017 Kvana DevInc. All rights reserved.
//


import SQLite



class ActorDb {
    
   
    
    let actors = Table("actors")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let spouse = Expression<String>("spouse")
    let country = Expression<String>("country")
    
    
    static let instance = ActorDb()
    private let db: Connection?
    
    
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/ActorDb.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }
    
    func createTable() {
        do {
            try db?.run(actors.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(spouse)
                table.column(country)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addActor(aname: String, aspouse: String, acountry: String) -> Int64? {
        do {
            let insert = actors.insert(name <- aname, spouse <- aspouse, country <- acountry)
            let id = try db!.run(insert)
            return id
        } catch {
            print("Insert failed")
            return  nil
        }
    }
    func getContacts() -> [Actor] {
        var sqlActors = [Actor]()
        
        do {
            for actor in try db!.prepare(actors) {
                sqlActors.append(Actor(
                    id: actor[id],
                    name: actor[name],
                    country: actor[country],
                    spouse: actor[spouse]))
            }
        } catch {
            print("Select failed")
        }
        
        return sqlActors
    }
    
    func deleteActor(aid: Int64) -> Bool {
        do {
            let actor = actors.filter(id == aid)
            try db!.run(actor.delete())
            return true
        } catch {
            print("Delete failed")
        }
        return false
    }
    func updateActor(aid:Int64, newActor: Actor) -> Bool {
        let actor = actors.filter(id == aid)
        do {
            let update = actor.update([
                name <- newActor.name!,
                spouse <- newActor.spouse!,
                country <- newActor.country!
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }

}
