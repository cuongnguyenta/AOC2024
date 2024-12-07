import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    var leftSide: [Int] {
        data.components(separatedBy: .newlines).compactMap { line in
            line.split(separator: " ").first.flatMap { Int($0) }
        }
    }
    
    var rightSide: [Int] {
        data.components(separatedBy: .newlines).compactMap { line in
            line.split(separator: " ").last.flatMap { Int($0) }
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        zip(leftSide.sorted(by: >), rightSide.sorted(by: >))
            .map { abs( $0 - $1) }
            .reduce(0, +)
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var res: Int = 0
        var dict = [Int: Int]()
        for val in rightSide {
            dict[val, default: 0] += 1
        }
        
        for val in leftSide {
            res += val * dict[val, default: 0]
        }
        return res
    }
    
}
