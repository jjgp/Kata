import unittest

from functools import reduce


class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


class TestDataStructures(unittest.TestCase):

    """
    206. Reverse Linked List

    Reverse a singly linked list.

    Example:
    Input: 1->2->3->4->5->NULL
    Output: 5->4->3->2->1->NULL

    Follow up:
    A linked list can be reversed either iteratively or recursively. Could you implement both?
    """

    def reverse_list(self, head: ListNode) -> ListNode:
        return head

    def test_reverse_list(self):
        expected = list(range(1, 6))
        head = reduce(lambda x, y: ListNode(x, y), reversed(expected))
        result = self.reverse_list(head)
        result = [node.val for node in result]
        self.assertEqual(
            expected,
            result
        )
