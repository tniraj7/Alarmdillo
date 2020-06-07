import UIKit

class AlarmViewController: UITableViewController {

    var alarm: Alarm!
    
    @IBOutlet weak var name: UIView!
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tapToSelectImage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func datePickerChanged(_ sender: Any) {
        alarm.time = datePicker.date
    }
    
    @IBAction func imageViewTapped(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension AlarmViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        alarm.name = textField.text!
        alarm.caption = caption.text!
        title = alarm.name
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
