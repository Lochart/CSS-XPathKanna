//
//  ViewController.swift
//  ParserKanna
//
//  Created by Nikolay on 28.02.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

import UIKit
import Kanna

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    displayURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func displayURL(){
    
        let myURLAdress = "http://swiftbook.ru"
        let myURL = NSURL(string: myURLAdress)
        
        let URLTask = NSURLSession.sharedSession().dataTaskWithURL(myURL!){
            myData,response,error in
        
            guard error == nil else { return }

            let myHTMLString = String(data: myData!,
                encoding: NSUTF8StringEncoding)
            
            self.myWebView.loadHTMLString(myHTMLString!, baseURL: nil)
            
            print(myHTMLString)
            
            
            if let doc = Kanna.HTML(html: myHTMLString!, encoding: NSUTF8StringEncoding) {
                print(doc.title)
                
//                // Search for nodes by CSS
//                for link in doc.css("a, link") {
//                    print(link.text)
//                    print(link["href"])
//                }
                
                // Search for nodes by XPath
                for link in doc.xpath("//a | //link") {
//                    print(link.text)
                    print(link["href"])
                }
            }
        }
            URLTask.resume()
    }
}

