//
//  ShapesModel.swift
//  CricutAssessment
//
//  Created by Cody Munger on 8/24/25.
//

import Foundation


struct ShapeResponse:Decodable {
    var buttons: [ShapeData]
}

class ShapesModel {
    var shapes: [ShapeData] = []
    var types:[String: ShapeData] = [:]
    
    public protocol ShapesModelDelegate {
        func onShapesUpdated(shapes: [ShapeData])
        func onTypesUpdated(types: [String: ShapeData])
    }
    
    var listeners: [ShapesModelDelegate] = []
    
    func remoteUpdate() async {
        guard let settings = await CricutAssessmentApp.instance?.context.settings else { return }
        let url = settings.apiUrl + settings.shapeEndpoint
        
        do {
            let req = URLRequest(url: URL(string: url)!)
            let (data, _) = try await URLSession.shared.data(for: req)
            
            let newShapes = try JSONDecoder().decode(ShapeResponse.self, from: data)
            self.shapes = newShapes.buttons
            
            for shape in shapes {
                if (types[shape.name] == nil) {
                    types[shape.name] = shape.clone() as? ShapeData
                }
            }
            
            listeners.forEach { listener in listener.onShapesUpdated(shapes: shapes) }
            listeners.forEach { listener in listener.onTypesUpdated(types: types) }
        } catch {
            print("Error fetching url \(url) with \(String(describing: error)) ")
            return
        }
    }
    
    func appendShape(shape: ShapeData) {
        self.shapes.append(shape.clone() as! ShapeData)
        listeners.forEach { listener in listener.onShapesUpdated(shapes: shapes) }
    }
    
    func removeShape(shape: ShapeData) {
        let idx = self.shapes.firstIndex { $0.name == shape.name }
        guard let idx else { return }
        self.shapes.remove(at: idx)
        
        listeners.forEach { listener in listener.onShapesUpdated(shapes: shapes) }
    }
    
    func removeAll(shape: ShapeData? = nil) {
        if (shape != nil) {
            self.shapes.removeAll { $0.name == shape?.name }
        } else {
            self.shapes.removeAll()
        }
        
        listeners.forEach { listener in listener.onShapesUpdated(shapes: shapes) }
    }
}
