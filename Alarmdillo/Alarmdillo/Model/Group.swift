import UIKit

class Group: NSObject {

    var id        : String
    var name      : String
    var playSound : Bool
    var enabled    : Bool
    var alarms    : [Alarm]
    
    init(name: String, playSound : Bool, enable: Bool, alarms: [Alarm]) {
        self.id        = UUID().uuidString
        self.name      = name
        self.playSound = playSound
        self.enabled    = enable
        self.alarms    = alarms
    }
}
