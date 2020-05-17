//
//  TableViewController.swift
//  Movieland
//
//  Created by Hermes Obiang on 4/21/20.
//  Copyright © 2020 Hermes Obiang. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UISearchResultsUpdating {
    
    
    // MARK: - Variables declarations
   
    var index = 0 /// Keeps track of the index of each movie in the unsorted movies array
    let pages = 40 // Number of pages to perform the online movie search
    
    //variables related to movie
    var movieSelected = MovieItem() // This movie will be sent to Movie Details View
    var movies = [MovieItem]()      //This array will contain unsorted loaded movies
    var sortedMovies : [MovieItem] = [] //This array will contain sorted loaded movies
    var searchResults = [MovieItem]() // This array will store results from searchBar
    
    // url for getting movie images
    var imageURL = "https://image.tmdb.org/t/p/w128_and_h128_bestv2"
    
    //searching variables
    var searchBar: UISearchController!
    var searching = false
    // MARK: - End of Variables declarations
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        initializeSearchBar()
        tableView.tableHeaderView = searchBar.searchBar
        movieManager()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           processMovies()
       }
    
    // MARK: - searchBar related function
    func updateSearchResults(for searchController: UISearchController) {
        // filter movies based on user input and store results in an array
        searchResults = sortedMovies.filter({$0.setTitle.lowercased().prefix(searchBar.searchBar.text?.count ?? 0) == searchBar.searchBar.text!.lowercased()})
           
        searching = true
        processMovies()
    }
    // MARK: - End of searchBar related function

    
     // MARK: - Movie Process Helper functions
    // This function loads movies into tableview
    func movieManager()
    {
        // load movies into tableview
        constructSearchPages()
        //wait for 3 seconds to finish the loading process
        run(after: 3)
        {
            //process the data based on user sorting choice
            self.processMovies()
        }
    }
    
    
    // This method accesses UserDefaults and sorts movies
    // based on user's choice
    func processMovies()
    {
        if(UserDefaults.standard.bool(forKey: "sortByTitle"))
        {
            sortedMovies = movies.sorted(by: {$0.setTitle < $1.setTitle})
        }
        
        else if (UserDefaults.standard.bool(forKey: "sortByRating"))
        {
            sortedMovies = movies.sorted(by: {$0.setRating > $1.setRating})
        }
        
        else
        {
            sortedMovies = movies
        }
        
        print("Number of movies: \(sortedMovies.count)")
        
        tableView.reloadData()
    }
     // MARK: - End of Movie Process Helper functions
    
    
    // MARK: - Additional functions
    //This function initialzes a searchBar programatically
    func initializeSearchBar()
    {
        searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.searchBarStyle = .prominent
    }
    
    // This function pause for a given amount of seconds.
    // It takes int seconds as arguments and waits for x seconds
    // to continue the execution of the code inside it
    func run(after seconds: Int, completion: @escaping () ->Void)
    {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline)
        {
            completion()
        }
    }
    // MARK: - End of Additional functions
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchBar.isActive{
            return searchResults.count
        }
            
        else{
            return sortedMovies.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
       
        //display search results if the user is typing
        if searchBar.isActive{
            cell.movieImage.image = searchResults[indexPath.row].setImage
            cell.movieName.text = searchResults[indexPath.row].setTitle
            cell.movieRating.text = "\(searchResults[indexPath.row].setRating)"
        }
        
        // display all movies
        else{
            cell.movieImage.image = sortedMovies[indexPath.row].setImage
            cell.movieName.text = sortedMovies[indexPath.row].setTitle
            cell.movieRating.text = "\(sortedMovies[indexPath.row].setRating)"
        }
       
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Tells the delegate that the specified row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searching == true{
            movieSelected = searchResults[indexPath.row]
        }
        
        else{
            movieSelected = sortedMovies[indexPath.row]
        }
        
        searching = false
    }
   // MARK: - End of Table view data source
    
    
    // MARK: - Movie Process functions
    //This functon bulids urls and calls getMovies() on each url built
    func constructSearchPages()
    {
        for i in 1...pages
        {
            var dataURL = "https://api.themoviedb.org/3/movie/now_playing?page="
            dataURL+="\(i)"
            dataURL+="&language=en-US&api_key=e55b542c9c8ad8f6615ac8cb4117210d"
            
            getMovies(dataURL) // get all movies of a given url
        }
    }
    
   
    
    /*
     * This function gets movies from the database.
     * It takes a URL string as input
     */
    func getMovies(_ dataURL: String) {
        
        let url = URL(string: dataURL)
        if url == nil
        {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: handleResponse)
        dataTask.resume()
    }
    
    
    // handle response examine the correctness of the data. The data
    //will go over multiple checks before parsing it
    func handleResponse (data: Data?, response: URLResponse?, error: Error?) {
        if let err = error {
            print("error: \(err.localizedDescription)")
            return
        }
        // 2.Check for improperly-formatted response
        guard let httpResponse = response as? HTTPURLResponse else { print("error: improperly-formatted response")
            return
        }
        let statusCode = httpResponse.statusCode
        // 3.Check for HTTP error
        guard statusCode == 200 else {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
            return
        }
        // 4.Check for no data
        guard let somedata = data else {
            print("error: no data")
            return
        }
        
        guard String(data: somedata, encoding: .utf8) != nil
            else {
            print("error: improperly-formatted data")
            return
        }
        
        
        guard let jsonObj = try? JSONSerialization.jsonObject(with: somedata)
            else
        {
            print("error: invalid JSON data")
            return
        }
        
        guard let jsonDict = jsonObj as? [String:Any]
        else
        {
            print("error: invalid JSON data")
            return
        }
        
        guard let resultArray = jsonDict["results"] as? [Any],
            resultArray.count>0
        else
        {
            print("error: invalid JSON data")
            return
        }
        
        // grab each movie, parse the data and store it into temporary variables
        for record in resultArray{
           
            guard let temp = record as? [String:Any],
            let title = temp["title"] as? String,
            let rate = temp["vote_average"] as? Double,
            let image = temp["poster_path"] as? String,
            let popularity = temp["popularity"] as? Double,
            let overview = temp["overview"] as? String,
            let date = temp["release_date"] as? String,
            let language = temp["original_language"] as? String,
            let vote = temp["vote_count"] as? Int
                
                else {
                    print("Invalid data format")
                    return
            }
            
            let movie = MovieItem()
            // set attribuites of movie
            movie.setTitle = title
            movie.setRating = rate
            movie.setPopularity = popularity
            movie.setOverview = overview
            movie.setDate = date
            movie.setLanguage = language
            movie.setVote = vote
            
            self.movies.append(movie) // add movie to the novie list
            
            loadImage(imageURL+image,index) // get the image of the movie
            
            index = index + 1
        }
    }
    
    
    // Searches an image of a given movie and set it
    func loadImage(_ urlString: String, _ Index: Int)
    {
        if let urlStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let url = URL(string: urlStr){
                let dataTask = URLSession.shared.dataTask(with: url, completionHandler:{(data,response,error)->Void in
                    if let imageData = data{
                        let image = UIImage(data:imageData)
                        
                        if image != nil{
                            self.movies[Index].setImage = image!
                        }
                    }
                })
                dataTask.resume()
            }
        }
    }
    
     // MARK: - End of Movie Process functions
    
    
     // MARK: - Segues and unwindSegues
    // Pass back data then pop the view from the stack
    @IBAction func unwindFromMovieDetails(sender: UIStoryboardSegue)
    {
       // No data to get from MovieDetailsViewController
    }
    
    
    @IBAction func unwindSort(sender: UIStoryboardSegue)
       {
           // No data to get from SortMoviesViewController
       }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotodetails" {
            let movieDetailsVC = segue.destination as! MovieDetailsViewController
           
            run(after: 0){
            var movieExist = false
            //get UserDefaults dictionary
            var dict2 = UserDefaults.standard.dictionary(forKey: "userRating")
                  
            //Check if the selected movie already exist in the Userdefaults dictionary
            //If the movie exist, set movieExist to true
            for (key,_) in dict2 ?? [:]{
                
                if key == self.movieSelected.setTitle
                    {
                        movieExist = true
                    }
                }
                
            // If the selected movie does not exist in the dictionary,
            // Add it
            if movieExist == false{
                
                // update dictionary if needed
                dict2?.updateValue(self.movieSelected.setUserRating, forKey: self.movieSelected.setTitle)
                UserDefaults.standard.removeObject(forKey: "userRating")
                UserDefaults.standard.set(dict2, forKey: "userRating")
            }
                
                // send movie to Movie details view
                movieDetailsVC.movie = self.movieSelected
            }
            
        }
        
            
        else if segue.identifier == "gotosort"
        {
            // nothing to do for now
        }
    }
    
    // MARK: - End of Segues and unwindSegues functions
    
}
