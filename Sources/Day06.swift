import Foundation

struct Day06: AdventDay {
    let grid: [Point: Character]
    let start: Point
    let area: Int
    
    init(data: String) {
        let lines = data.lines
        let points = lines
            .enumerated().flatMap { y, line in
                line.enumerated().map { x, ch in
                    let p = Point(x, y)
                    return (p, ch)
                }
            }
        grid = Dictionary(points, uniquingKeysWith: { _, new in new } )
        start = grid.first { $0.value == "^" }!.key
        area = grid.count { $0.value == "." } + 1
    }
    
    func part1() -> Int {
        findPath(from: start).count
    }
    
    func part2() -> Int {
        var path = findPath(from: start)
        path.removeFirst()
        return countDifferentPosition(path)
    }
}

private extension Day06 {
    func findPath(from start: Point) -> Set<Point> {
        var visited = Set([start])
        var direction = Direction.n
        var current = start
        while true {
            let next = current.moved(to: direction)
            switch grid[next] {
            case nil:
                return visited
            case "#":
                direction = direction.turned(.clockwise)
            case ".", "^":
                visited.insert(next)
                current = next
            default: fatalError()
            }
        }
    }
    
    func countDifferentPosition(_ path: Set<Point>) -> Int {
        var count: Int = 0
        for point in path {
            var grid = self.grid
            grid[point] = "#"
            
            var current = start
            var direction = Direction.n
            var steps = 0
            outerLoop: while true {
                // we've taken more steps than there are available
                // positions, so this must be a loop
                if steps > area {
                    count += 1
                    break
                }
                let next = current.moved(to: direction)
                switch grid[next] {
                case nil:
                    break outerLoop
                case "#":
                    direction = direction.turned(.clockwise)
                case ".", "^":
                    steps += 1
                    current = next
                default:
                    fatalError()
                }
            }
        }
        
        return count
    }
}
