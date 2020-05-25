import unittest

from typing import List


class TestArray(unittest.TestCase):

    """
    56. Merge Intervals

    Given a collection of intervals, merge all overlapping intervals.

    Example 1:
    Input: [[1,3],[2,6],[8,10],[15,18]]
    Output: [[1,6],[8,10],[15,18]]
    Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].

    Example 2:
    Input: [[1,4],[4,5]]
    Output: [[1,5]]
    Explanation: Intervals [1,4] and [4,5] are considered overlapping.
    NOTE: input types have been changed on April 15, 2019. Please reset to default code definition to get new method signature.
    """

    def merge_intervals(self, intervals: List[List[int]]) -> List[List[int]]:
        merged = []
        for interval in sorted(intervals):
            if merged and merged[-1][1] >= interval[0]:
                merged[-1][1] = max(merged[-1][1], interval[1])
            else:
                merged.append(interval)
        return merged

    def test_merge_intervals(self):
        self.assertEqual(
            self.merge_intervals([[1, 3], [2, 6], [8, 10], [15, 18]]),
            [[1, 6], [8, 10], [15, 18]]
        )
        self.assertEqual(
            self.merge_intervals([[1, 4], [4, 5]]),
            [[1, 5]]
        )

    """
    53. Maximum Subarray

    Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

    Example:
    Input: [-2,1,-3,4,-1,2,1,-5,4],
    Output: 6
    Explanation: [4,-1,2,1] has the largest sum = 6.

    Follow up:
    If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
    """

    def max_sub_array(self, nums: List[int]) -> int:
        currSum = maxSum = nums[0]
        for num in nums[1:]:
            currSum = max(currSum + num, num)
            maxSum = max(maxSum, currSum)
        return maxSum

    def test_max_sub_array(self):
        self.assertEqual(
            self.max_sub_array([-2, 1, -3, 4, -1, 2, 1, -5, 4]),
            6
        )


if __name__ == '__main__':
    unittest.main()
