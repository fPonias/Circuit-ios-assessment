
import Foundation

class ShapeData: Decodable, Identifiable, Hashable {
    let id:UUID
    
    let name: String
    let drawPath: String
    
    init(name: String, drawPath: String) {
        self.id = UUID()
        
        self.name = name
        self.drawPath = drawPath
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.drawPath = try container.decodeIfPresent(String.self, forKey: .drawPath) ?? ""
    }
    
    func clone() -> Any {
        return ShapeData(name: self.name, drawPath: self.drawPath)
    }
    
    static func == (lhs: ShapeData, rhs: ShapeData) -> Bool {
        return lhs.name == rhs.name && lhs.drawPath == rhs.drawPath
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
