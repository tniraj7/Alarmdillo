import UIKit

class AlarmViewController: UITableViewController {

    @IBOutlet weak var name: UIView!
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tapToSelectImage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func datePickerChanged(_ sender: Any) {
    }
    
    @IBAction func imageViewTapped(_ sender: Any) {
    }
}
