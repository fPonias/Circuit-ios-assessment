import Foundation

class MainViewVM: ShapesModel.ShapesModelDelegate, ObservableObject {
    @Published var shapes: [ShapeData] = []
    @Published var types: [String: ShapeData] = [:]
    
    var currentFilter: ShapeData? = nil
    @Published var filteredShapes: [ShapeData] = []
    
    init() {
        CricutAssessmentApp.instance?.context.shapesModel.listeners.append(self)
    }
    
    deinit {
        CricutAssessmentApp.instance?.context.shapesModel.listeners.removeAll { return $0 as? MainViewVM === self }
    }
    
    func onShapesUpdated(shapes: [ShapeData]) {
        DispatchQueue.main.async {
            self.shapes = shapes
            self.updateFiltered()
        }
    }
    
    func onTypesUpdated(types: [String : ShapeData]) {
        DispatchQueue.main.async {
            self.types = types
        }
    }
    
    func onShapeClicked(shape: ShapeData) {
        addShape(shape: shape)
    }
    
    func updateFiltered() {
        if (currentFilter == nil) {
            self.filteredShapes = self.shapes
        } else {
            self.filteredShapes = self.shapes.filter { $0.name == currentFilter?.name }
        }
    }
    
    func onShapeFilterClicked(shape: ShapeData) {
        DispatchQueue.main.async {
            self.currentFilter = shape
            self.updateFiltered()
        }
    }
    
    func deleteAll() {
        CricutAssessmentApp.instance?.context.shapesModel.removeAll()
    }
    
    func deleteAllFiltered() {
        guard let filter = currentFilter else { return }
        CricutAssessmentApp.instance?.context.shapesModel.removeAll(shape: filter)
    }
    
    func addSingleFiltered() {
        guard let filter = currentFilter else { return }
        addShape(shape: filter)
    }
    
    func addShape(shape: ShapeData) {
        CricutAssessmentApp.instance?.context.shapesModel.appendShape(shape: shape)
    }
    
    func deleteSingleFiltered() {
        guard let filter = currentFilter else { return }
        CricutAssessmentApp.instance?.context.shapesModel.removeShape(shape: filter)
    }
}
