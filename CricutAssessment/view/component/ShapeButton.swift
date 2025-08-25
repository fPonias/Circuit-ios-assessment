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
        
    let fill = Color.blue
    var body: some View {
        VStack() {
            Group {
                switch shape.name {
                case "Circle":
                    Circle().fill(fill)
                case "Square":
                    Rectangle().fill(fill)
                case "Triangle":
                    Triangle().fill(fill)
                default:
                    Circle().fill(fill)
                }
            }
            .frame(width: 80, height: 80)
        }
        .onTapGesture {
            onTap()
        }
    }
}
