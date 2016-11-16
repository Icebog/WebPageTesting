//
//  ViewController.swift
//  HtmlTester
//
//  Created by Icebog,Hsieh on 16/11/2016.
//  Copyright © 2016 Icebog,Hsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let path = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "ref") {
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            let documentsDirectory = paths.object(at: 0) as! NSString
            let filePath = documentsDirectory.appendingPathComponent("index.html")
            
            let fileManager = FileManager.default
            
            //check if file exists
            if(!fileManager.fileExists(atPath: filePath)) {
                // If it doesn't, copy it from the default file in the Bundle
                do {
                    
                    try fileManager.copyItem(atPath: path, toPath: filePath)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }else{
                print("file exist")
            }
            
            do {
                let content = try String(contentsOfFile: filePath)
                
                webView.loadHTMLString(content, baseURL: URL(string: path))
                
            } catch let error {
                print(error.localizedDescription)
            }
           
        }else{
            print("path error")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

