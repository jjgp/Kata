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

    """
    141. Linked List Cycle

    Given a linked list, determine if it has a cycle in it.
    To represent a cycle in the given linked list, we use an integer pos which represents the position (0-indexed) in the linked list where tail connects to. If pos is -1, then there is no cycle in the linked list.

    Example 1:
    Input: head = [3,2,0,-4], pos = 1
    Output: true
    Explanation: There is a cycle in the linked list, where tail connects to the second node.

    Example 2:
    Input: head = [1,2], pos = 0
    Output: true
    Explanation: There is a cycle in the linked list, where tail connects to the first node.

    Example 3:
    Input: head = [1], pos = -1
    Output: false
    Explanation: There is no cycle in the linked list.

    Follow up:
    Can you solve it using O(1) (i.e. constant) memory?
    """

    def has_cycle(self, head: ListNode) -> bool:
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            if fast is slow:
                return True
        return False
    
    def has_cycle_set(self, head: ListNode) -> bool:
        previous = set()
        while head:
            if head in previous:
                return True
            else:
                previous.add(head)
                head = head.next
        return False

    def test_has_cycle(self):
        def create_cycle(values, pos):
            nodes = [ListNode(value, None) for value in values]
            if pos > -1:
                nodes[-1].next = nodes[pos]
            head = nodes[0]
            for i, node in enumerate(nodes):
                if i + 1 < len(nodes):
                    node.next = nodes[i + 1]
            return head

        self.assertTrue(self.has_cycle(create_cycle([3, 2, 0, -4], 1)))
        self.assertTrue(self.has_cycle(create_cycle([1, 2], 0)))
        self.assertFalse(self.has_cycle(create_cycle([1], -1)))

        self.assertTrue(self.has_cycle_set(create_cycle([3, 2, 0, -4], 1)))
        self.assertTrue(self.has_cycle_set(create_cycle([1, 2], 0)))
        self.assertFalse(self.has_cycle_set(create_cycle([1], -1)))
