//
//  AirQualityPageViewController.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/29/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit

class AirQualityPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var areaFullName = ""
    var averageRadiationDataBefore = Double()
    var averageRadiationDataCurrent = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = "방사능"
        self.navigationController?.navigationBar.alpha = 0.5
        
        // Do any additional setup after loading the view.
        
        print("area full name: \(areaFullName)-------2")
        
        let radioViewController1 = storyboard?.instantiateViewControllerWithIdentifier("airQualityViewController1") as! AirQualityDetailViewController
        
        setViewControllers([radioViewController1], direction: .Forward, animated: true, completion: nil)
        
        
        
        dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? RadioViewController {
            return storyboard?.instantiateViewControllerWithIdentifier("radioViewContoller1") as! RadioDetailViewController
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? RadioDetailViewController {
            return storyboard?.instantiateViewControllerWithIdentifier("radioViewContoller2") as! RadioViewController
        }
        
        return nil
    }
    

    
    
    
    
}
