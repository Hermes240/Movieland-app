//
//  SortMoviesViewController.swift
//  Movieland
//
//  Created by Hermes Obiang on 4/22/20.
//  Copyright © 2020 Hermes Obiang. All rights reserved.
//

import UIKit

class SortMoviesViewController: UIViewController {
    

    @IBOutlet weak var SortByRatingSwitch: UISwitch!
    @IBOutlet weak var SortByTitleSwitch: UISwitch!
    
  
    
    // This is an IBAction for Sort by Rating switch
    @IBAction func ratingAction(_ sender: UISwitch)
    {
        SortByTitleSwitch.isOn = false
        
        UserDefaults.standard.set(sender.isOn, forKey: "sortByRating")
        UserDefaults.standard.set(SortByTitleSwitch.isOn, forKey: "sortByTitle")
    }
    
    
    // This is an IBAction for Sort by Title switch
    @IBAction func TitleAction(_ sender: UISwitch)
    {
        SortByRatingSwitch.isOn = false
        UserDefaults.standard.set(sender.isOn, forKey: "sortByTitle")
        UserDefaults.standard.set(SortByRatingSwitch.isOn, forKey: "sortByRating")
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SortByRatingSwitch.isOn = false
        SortByTitleSwitch.isOn = false
        
        SortByRatingSwitch.isOn = UserDefaults.standard.bool(forKey: "sortByRating")
        SortByTitleSwitch.isOn = UserDefaults.standard.bool(forKey: "sortByTitle")

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
