import UIKit

class Group: NSObject, NSCoding {
    
    var id        : String
    var name      : String
    var playSound : Bool
    var enabled   : Bool
    var alarms    : [Alarm]
    
    required init?(coder: NSCoder) {
        self.id        = coder.decodeObject(forKey: "id") as! String
        self.name      = coder.decodeObject(forKey: "name") as! String
        self.playSound = coder.decodeObject(forKey: "playSound") as! Bool
        self.enabled   = coder.decodeObject(forKey: "enabled") as! Bool
        self.alarms    = coder.decodeObject(forKey: "alarms") as! [Alarm]
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.playSound, forKey: "playSound")
        coder.encode(self.enabled, forKey: "enabled")
        coder.encode(self.alarms, forKey: "alarms")
    }
    
    init(name: String, playSound : Bool, enable: Bool, alarms: [Alarm]) {
        self.id        = UUID().uuidString
        self.name      = name
        self.playSound = playSound
        self.enabled   = enable
        self.alarms    = alarms
    }
}
