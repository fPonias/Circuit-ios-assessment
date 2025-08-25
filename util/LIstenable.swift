class MyObj {
    var status: Status = Status(errCode: 0, msg: "Init") {
        didSet {
            didChange?(status)
        }
    }
    
    // closure to call when status changed
    var didChange: ((Status) -> Void)? = nil
    
    struct Status {
        var errCode:Int
        var msg:String
        
        mutating func set(err:Int, txt:String){
            errCode = err
            msg = txt
        }
    }
}
