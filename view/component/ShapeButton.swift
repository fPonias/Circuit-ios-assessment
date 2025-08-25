import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct ShapeButton: View {
    var shape: ShapeData
    var onTap: () -> Void = {}
    
    private func shapeView() -> AnyView {
        let ret = switch shape.drawPath {
        case "circle":
            Circle()
        case "square":
            Rectangle() as any Shape
        case "triangle":
            Triangle() as any Shape
        default:
            Circle()
        }
        
        return AnyView(ret)
    }
    
    var body: some View {
        VStack() {
            shapeView().frame(width: 80, height: 80)
        }
        .onTapGesture {
            onTap()
        }
    }
}
