
import UIKit
class AppData{
   static var favorites = [String]()
    static var selected = ""
}
class MovieFinderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var searchBarOutlet: UITextField!
    var movieName = ""
    var titles = [String]()
  //  var favorites = [String]()
    var selected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        tableViewOutlet.reloadData()
        
    }
    

    @IBAction func addFavoriteAction(_ sender: UIButton) {
        if AppData.selected == ""{
            print("Error: Not Selected")
            
        }
        else{
            AppData.favorites.append(AppData.selected)
        }
    }
    
    // This part works
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppData.selected = titles[indexPath.row]
        print("Selection Made")
       print(AppData.selected)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = "\(titles[indexPath.row])"
        return cell!
    }
    override func viewDidAppear(_ animated: Bool) {
        tableViewOutlet.reloadData()
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        movieName = searchBarOutlet.text!
        getMovie()
        tableViewOutlet.reloadData()
    }
    
    
    
    func getMovie(){
        let session = URLSession.shared
        let movieURL = URL(string: "http://www.omdbapi.com/?s=\(movieName)&apikey=f36e3324")!
        let dataTask = session.dataTask(with: movieURL) { data, response, error in
            if let e = error{
                print("Error! \(e)")
                let alert = UIAlertController(title: "Error!", message: "\(e)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                if let d = data{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary{
                        // print(jsonObj)
                        
                        var theSearch = jsonObj["Search"] as! [NSDictionary]
                        //print(theSearch)
                        
                        
                        /*var title = theSearch[0]["Title"]!
                         print(title)
                         
                         } */
                        
                        var i = 0
                        
                        for result in theSearch{
                            var title = theSearch[i]["Title"]!
                            self.titles.append(title as! String)
                            i+=1
                        }
                        //print(self.titles[3])
                        
                        
                        
                    }
                    else{
                        print("Could't get data")
                    }
                }
            }
            
        }
        dataTask.resume()
        
    }
}
