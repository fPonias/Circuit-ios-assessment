import Foundation

class Settings {
    let settings:NSDictionary
    
    init() {
        let settingsUrl = Bundle.main.url(forResource: "Settings", withExtension: "bundle")!.appendingPathComponent("Root.plist")
        settings = NSDictionary(contentsOf:settingsUrl)!
    }
    
    var apiUrl:String {
        get {
            let ret = settings["apiUrl"] ?? ""
            return ret as! String
        }
    }
    
    var shapeEndpoint:String {
        get {
            let ret = settings["shapeEndpoint"] ?? ""
            return ret as! String
        }
    }
}
