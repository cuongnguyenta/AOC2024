import Foundation

struct Day04: AdventDay {
    var data: String
    
    var grid: [String] {
        data.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }
    
    func part1() -> Any {
        return findOccurrences(grid: grid, word: "XMAS")
    }
    
    func part2() -> Any {
        return findXMASPatterns(grid: grid)
    }
    
}

private extension Day04 {
    func findOccurrences(grid: [String], word: String) -> Int {
        let numRows = grid.count
        let numCols = grid[0].count
        let wordLength = word.count
        var count = 0

        let directions = [
            (0, 1),    // Horizontal right
            (1, 0),    // Vertical down
            (1, 1),    // Diagonal down-right
            (-1, 1),   // Diagonal up-right
            (0, -1),   // Horizontal left
            (-1, 0),   // Vertical up
            (-1, -1),  // Diagonal up-left
            (1, -1)    // Diagonal down-left
        ]

        func wordExists(row: Int, col: Int, dRow: Int, dCol: Int) -> Bool {
            for i in 0..<wordLength {
                let newRow = row + i * dRow
                let newCol = col + i * dCol
                if !(0..<numRows ~= newRow && 0..<numCols ~= newCol) {
                    return false
                }
                if grid[newRow][String.Index(utf16Offset: newCol, in: grid[newRow])] != word[String.Index(utf16Offset: i, in: word)] {
                    return false
                }
            }
            return true
        }

        for row in 0..<numRows {
            for col in 0..<numCols {
                for (dRow, dCol) in directions {
                    if wordExists(row: row, col: col, dRow: dRow, dCol: dCol) {
                        count += 1
                    }
                }
            }
        }

        return count
    }
    
    func findXMASPatterns(grid: [String]) -> Int {
        let rows = grid.count
        let cols = grid[0].count
        var count = 0
        
        func charAt(_ row: Int, _ col: Int) -> Character? {
            guard row >= 0 && row < rows && col >= 0 && col < cols else { return nil }
            let index = grid[row].index(grid[row].startIndex, offsetBy: col)
            return grid[row][index]
        }
        
        func checkMASPattern(_ row: Int, _ col: Int, _ dRow: Int, _ dCol: Int) -> Bool {
            guard let first = charAt(row, col),
                  let second = charAt(row + dRow, col + dCol),
                  let third = charAt(row + 2 * dRow, col + 2 * dCol) else {
                return false
            }
            
            // Check for MAS or SAM pattern
            return (first == "M" && second == "A" && third == "S") ||
                   (first == "S" && second == "A" && third == "M")
        }
        
        // Check each position in the grid
        for row in 0..<rows {
            for col in 0..<cols {
                // Check each possible X pattern
                if checkMASPattern(row, col, 1, 1) && checkMASPattern(row, col + 2, 1, -1) ||
                   checkMASPattern(row + 2, col, -1, 1) && checkMASPattern(row + 2, col + 2, -1, -1) {
                    count += 1
                }
            }
        }
        
        return count
    }
}
