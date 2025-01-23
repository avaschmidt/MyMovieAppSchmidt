
import UIKit

class MovieFinderViewController: UIViewController {
    
    @IBOutlet weak var searchBarOutlet: UITextField!
    var movieName = ""
    var titles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func searchAction(_ sender: UIButton) {
        movieName = searchBarOutlet.text!
        getMovie()
    }
    
    
    
    func getMovie(){
        let session = URLSession.shared
        let movieURL = URL(string: "http://www.omdbapi.com/?s=\(movieName)&apikey=f36e3324")!
        let dataTask = session.dataTask(with: movieURL) { data, response, error in
            if let e = error{
                print("Error! \(e)")
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
