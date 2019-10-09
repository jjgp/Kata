/// [1. Two Sum](https://leetcode.com/problems/two-sum/)
class TwoSum {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var numsDict = [Int: Int]()
        for i in 0..<nums.count {
            let num = nums[i]
            if let found = numsDict[target - num] {
                return [found, i]
            } else {
                numsDict[num] = i
            }
        }
        return []
    }
}
