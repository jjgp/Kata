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
        new_head = None
        while head:
            node = head
            head = head.next
            node.next = new_head
            new_head = node
        return new_head
        # return self.reverse_list_recursive(None, head)
    
    def reverse_list_recursive(self, previous: ListNode, current: ListNode) -> ListNode:
        if not current:
            return previous
        next_node = current.next
        current.next = previous
        return self.reverse_list_recursive(current, next_node)

    def test_reverse_list(self):
        expected = list(range(1, 6))
        head = expected[:]
        head.insert(0, None)
        head = reduce(lambda x, y: ListNode(y, x), head)
        head = self.reverse_list(head)

        result = []
        while head:
            result.append(head.val)
            head = head.next

        self.assertEqual(
            expected,
            result
        )
