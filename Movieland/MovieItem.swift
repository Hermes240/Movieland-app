//
//  MovieItem.swift
//  Movieland
//
//  Created by Hermes Obiang on 4/21/20.
//  Copyright © 2020 Hermes Obiang. All rights reserved.
//
import UIKit
import Foundation

class MovieItem{
    
    private var title: String = "movie"
    private var language = ""
    private var ID = ""
    private var rating = 0.0
    private var image : UIImage!
    private var overview = ""
    private var release_date = ""
    private var popularity = 0.0
    private var vote = 0
    private var userRating = 0.0
    private var index = 0
    
    init() {
        self.title = ""
        self.rating = 0.0
        self.language = ""
        self.ID = UUID().uuidString
        self.image = UIImage(named: "default.jpg")
        self.vote = 0
        self.popularity = 0.0
        self.release_date = ""
        self.overview = ""
        self.userRating = 0
        self.index = 0
    }
    
    
    var setImage : UIImage {
        
        get
        {
            return self.image
        }
        set
        {
            self.image = newValue
        }
    }
    
    
    public var setTitle : String {
        
        get
        {
            return self.title
        }
        set
        {
            self.title = newValue
        }
    }
    
    public var setID : String {
        
        get
        {
            return self.ID
        }
        set
        {
            self.ID = newValue
        }
    }
    
    public var setRating : Double {
        
        get
        {
            return self.rating
        }
        set
        {
            self.rating = newValue
        }
    }
    
    var setLanguage : String {
        
        get
        {
            return self.language
        }
        set
        {
            self.language = newValue
        }
    }
    
    
    public var setOverview : String {
        
        get
        {
            return self.overview
        }
        set
        {
            self.overview = newValue
        }
    }
    
    public var setDate : String {
        
        get
        {
            return self.release_date
        }
        set
        {
            self.release_date = newValue
        }
    }
    
    public var setPopularity : Double {
        
        get
        {
            return self.popularity
        }
        set
        {
            self.popularity = newValue
        }
    }
    
    public var setVote : Int {
        
        get
        {
            return self.vote
        }
        set
        {
            self.vote = newValue
        }
    }
    
    public var setUserRating : Double {
        
        get
        {
            return self.userRating
        }
        set
        {
            self.userRating = newValue
        }
    }
    
    public var setIndex : Int {
        
        get
        {
            return self.index
        }
        set
        {
            self.index = newValue
        }
    }


}

