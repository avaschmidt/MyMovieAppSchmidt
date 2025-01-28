import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoritesDisplayOutlet: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for title in AppData.favorites{
            favoritesDisplayOutlet.text = "\(title)\n"
        }
        
    }
    

    
  

}
