import Testing

@testable import AdventOfCode

struct Day08Tests {
    private let testData =
      """
      ............
      ........0...
      .....0......
      .......0....
      ....0.......
      ......A.....
      ............
      ............
      ........A...
      .........A..
      ............
      ............
      """
    
    @Test func testPart1() async throws {
        let challenge = Day08(data: testData)
        #expect(String(describing: challenge.part1()) == "14")
    }
    
    @Test func testPart2() async throws {
        let challenge = Day08(data: testData)
        #expect(String(describing: challenge.part2()) == "34")
    }
}
