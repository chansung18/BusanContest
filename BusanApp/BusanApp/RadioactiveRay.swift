//
//  RadioactiveRay.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/17/15.
//  Copyright (c) 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit

class RadioactiveRay: UIViewController, NSXMLParserDelegate {
    
    @IBOutlet weak var tbData: UITableView!
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    var category = String()
    

    
    override func viewDidLoad(){
        
        
        println("ViewDidLoda")
        beginParsing()
    }
    
    func beginParsing()
    {
        
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=4825054000")))!
        parser.delegate = self
        

        parser.parse()
        
        tbData!.reloadData()
        println("bingParsin1g")
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject])
    {
        element = elementName
        println("parse1")
        
        if (elementName as NSString).isEqualToString("category")
        {
            println("categorystart")
            elements = NSMutableDictionary.alloc()
            
        }
        
        
        /*if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary.alloc()
            
            
            elements = [:]
            title1 = NSMutableString.alloc()
            title1 = ""
            date = NSMutableString.alloc()
            date = ""
        }*/
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        println("parse2")
        
        if (elementName as NSString).isEqualToString("category")
        {
            
            if !title1.isEqual(nil) {
                
                println("categorytitleend")
                //elements.setObject(title1, forKey: "category")
            }
            
            posts.addObject(elements)
            
            
        }
      
        
        /*if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date")
            }
            
            posts.addObject(elements)
        }*/
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?)
    {
        
        println("parse3")
        
        if element.isEqualToString("category") {
            
            
            title1.appendString(string!)
            println(title1)
            
        }
        
        
  
        /*if element.isEqualToString("title") {
            title1.appendString(string!)
        } else if element.isEqualToString("pubDate") {
            date.appendString(string!)
        }*/
    }
    
    //Tableview Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
        }
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("date") as! NSString as String
        
        return cell as UITableViewCell
    }
}

