import unittest

from typing import List


class TestArrays(unittest.TestCase):

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
        return []

    def test_merge_intervals(self):
        self.assertEqual(
            self.merge_intervals([[1, 3], [2, 6], [8, 10], [15, 18]]),
            [[1, 6], [8, 10], [15, 18]]
        )
        self.assertEqual(
            self.merge_intervals([[1, 4], [4, 5]]),
            [[1, 5]]
        )


if __name__ == '__main__':
    unittest.main()
