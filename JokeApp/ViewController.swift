//
//  ViewController.swift
//  JokeApp
//
//  Created by nikil davis on 11/06/16.
//  Copyright © 2016 nikil davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var joke: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func refreshnav(_ sender: AnyObject) {
        super.viewDidLoad()
        self.downloadingData()
    }
    
    let URLString="http://api.icndb.com/jokes/random"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadingData()
    }
    
    
    func downloadingData(){
        
        //configuration
        
        let config=URLSessionConfiguration.default
        
        //url
        let url=URL(string:URLString)
        
        //request
        
        let request=URLRequest(url: url!)
        //seasion
        
        let session=URLSession(configuration: config)
        //task
        let task=session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            print(data)
            //
            if(data != nil)
            {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String:AnyObject]
                    print(json)
                    self.parseJsonData(json!)
                    
                    
                    
                }
                catch{
                    print(error)
                }}
            else{
                print(error)
            }
            
        })
        task.resume()
    }
    func parseJsonData(_ json: [String:AnyObject]){
        //        let dict = json["value"]
        //        let jokee = dict?["joke"]
        let dict = json["value"]
        let jokee = dict!["joke"]
        if let randjoke = jokee{
            print(randjoke!)
            
            DispatchQueue.main.async {
                self.joke.text=String(describing: randjoke!)
                self.activityIndicator.stopAnimating()
            }
            
        }
        
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

