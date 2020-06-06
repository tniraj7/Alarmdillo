import UIKit

class GroupViewController: UITableViewController {

    var group: Group!
    
    let playSoundTag = 1001
    let enabledTag = 1002
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))
        title = group.name
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        
        if group.alarms.count > 0 {
            return "Alarms"
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return group.alarms.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return createGroupCell(for: indexPath, in: tableView)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightDetail", for: indexPath)
            let alarm = group.alarms[indexPath.row]
            cell.textLabel?.text = alarm.name
            cell.detailTextLabel?.text = DateFormatter.localizedString(from: alarm.time, dateStyle: .none, timeStyle: .short)
            return cell
        }
    }
    
    private func createGroupCell(for indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        
        switch(indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditableText", for: indexPath)
            
            if let cellTextField = cell.viewWithTag(1) as? UITextField {
                cellTextField.text = group.name
            }
            return cell
            
        case 1:
             let cell = tableView.dequeueReusableCell(withIdentifier: "Switch", for: indexPath)
            
             if let cellLabel = cell.viewWithTag(1) as? UILabel, let cellSwitch = cell.viewWithTag(2) as? UISwitch {
                cellLabel.text = "Play Sound"
                cellSwitch.isOn = group.playSound
                cellSwitch.tag = playSoundTag
            }
             return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Switch", for: indexPath)
            
            if let cellLabel = cell.viewWithTag(1) as? UILabel, let cellSwitch = cell.viewWithTag(2) as? UISwitch {
                cellLabel.text = "Enabled"
                cellSwitch.isOn = group.enabled
                cellSwitch.tag = enabledTag
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        group.alarms.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic )
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.contentView.preservesSuperviewLayoutMargins = false
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        
        if sender.tag == playSoundTag {
            group.playSound = sender.isOn
        } else {
            group.enabled = sender.isOn
        }
    }
    
    @objc private func addAlarm() {
        let newAlarm = Alarm(name: "Name this Alarm", caption: "This is description", time: Date(), image: "")
        group.alarms.append(newAlarm)
        performSegue(withIdentifier: "EditAlarm", sender: newAlarm)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let alarmToEdit: Alarm
        
        if sender is Alarm {
            alarmToEdit = sender as! Alarm
        } else {
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            alarmToEdit = group.alarms[selectedIndexPath.row]
        }
        
        if let alarmViewController = segue.destination as? AlarmViewController {
            alarmViewController.alarm = alarmToEdit
        }
    }
}

extension GroupViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        group.name = textField.text!
        title = group.name
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
