import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoritesDisplayOutlet: UITextView!
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var savedFaves = defaults.stringArray(forKey: "favorites")!
        for fave in savedFaves{
            AppData.favorites.append(fave)
        }
        //AppData.favorites = savedFaves!
        
        for title in AppData.favorites{
            favoritesDisplayOutlet.text += "\(title)\n"
        }
        
        
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        defaults.set(AppData.favorites, forKey: "favorites")
    }
    
    
  

}
