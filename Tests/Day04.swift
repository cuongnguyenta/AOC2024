import Testing

@testable import AdventOfCode

struct Day03Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """
    
    @Test func testPart1() async throws {
        let challenge = Day04(data: testData)
        #expect(String(describing: challenge.part1()) == "18")
    }
    
    @Test func testPart2() async throws {
        let challenge = Day04(data: testData)
        #expect(String(describing: challenge.part2()) == "9")
    }
}
