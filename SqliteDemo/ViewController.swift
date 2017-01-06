//
//  ViewController.swift
//  SqliteDemo
//
//  Created by Kvana Dev Ipod on 03/01/17.
//  Copyright © 2017 Kvana DevInc. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
  private  var actors = [Actor] ()
  private  var selectedActor:Int?

    @IBOutlet weak var actorTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          actorTable.delegate = self
          actorTable.dataSource = self
          getCall()
        actors = ActorDb.instance.getContacts()
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func getCall(){
       
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        let actorArray = json["actors"] as? [[String:Any]]
                        for item in actorArray!{
                            let name = item["name"] as? String
                            let spouse = item["spouse"] as? String
                            let country = item["country"] as? String
                            
        if let id = ActorDb.instance.addActor(aname: name!, aspouse: spouse!, acountry: country!){
                                let actor = Actor(id: id, name: name!,country: country!,spouse: spouse!)
                                self.actors.append(actor)
//            actorTable.insertRows(at: [IndexPath(row: contacts.count-1, section: 0)], with: .fade)
                            }
                        }
                        
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ActorTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ActorTableViewCell") as! ActorTableViewCell
        let userObj = actors[indexPath.row]
        cell.nameLbl.text = userObj.name
        cell.spouseLbl.text = userObj.spouse
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
//        ActorDb.instance.updateActor(id, newActor: Actor)
//        ActorDb.instance.deleteActor(actors[selectedActor].id!)
        
        
        
        
    }
}

