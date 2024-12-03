import Algorithms

struct Day00: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let leftSide: [Int] = data.components(separatedBy: .newlines).compactMap { line in
            line.split(separator: " ").first.flatMap { Int($0) }
        }.sorted(by: >)
        
        let rightSide: [Int] = data.components(separatedBy: .newlines).compactMap { line in
            line.split(separator: " ").last.flatMap { Int($0) }
        }.sorted(by: >)
        
        return zip(leftSide, rightSide).map { abs( $0 - $1) }.reduce(0, +)
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        return "Not yet implemented"
    }
    
}
