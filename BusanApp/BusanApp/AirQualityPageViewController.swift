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
    
    var smallDustValue = Double()
    var coValue = Double()
    var noValue = Double()
    var so2Value = Double()
    var ozValue = Double()
    var dustValue = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = "대기질"
        self.navigationController?.navigationBar.alpha = 0.5
        
        // Do any additional setup after loading the view.
        
        print("area full name: \(areaFullName)-------2")
        
        let radioViewController1 = storyboard?.instantiateViewControllerWithIdentifier("airQualityViewController1") as! AirQualityDetailViewController
        radioViewController1.smallDustValue = smallDustValue
        radioViewController1.coValue = coValue
        radioViewController1.noValue = noValue
        radioViewController1.so2Value = so2Value
        radioViewController1.ozValue = ozValue
        radioViewController1.dustValue = dustValue
        
        setViewControllers([radioViewController1], direction: .Forward, animated: true, completion: nil)
        
        dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? AirQualityViewController {
            return storyboard?.instantiateViewControllerWithIdentifier("airQualityViewController1") as! AirQualityDetailViewController
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let _ = viewController as? AirQualityDetailViewController {
            return storyboard?.instantiateViewControllerWithIdentifier("airQualityViewController2") as! AirQualityViewController
        }
        
        return nil
    }
    

    
    
    
    
}
