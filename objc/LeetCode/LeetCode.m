//
//  LeetCode.m
//  LeetCode
//
//  Created by Jason Prasad on 5/19/20.
//

#import <XCTest/XCTest.h>

@interface LeetCode : XCTestCase
@end

@implementation LeetCode
@end

@implementation LeetCode (Array)

// MARK: - 1. Two Sum

/**
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 Example:

 Given nums = [2, 7, 11, 15], target = 9,

 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */
- (NSArray<NSNumber *> *)twoSumNumbers:(NSArray<NSNumber *> *)nums andTarget:(NSNumber *)target {
    NSMutableDictionary *numsDict = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < nums.count; ++i) {
        NSNumber *num = nums[i];
        NSNumber *candidate = @(target.integerValue - num.integerValue);
        if ([numsDict.allKeys containsObject:candidate]) {
            return @[numsDict[candidate], @(i)];
        } else {
            numsDict[num] = @(i);
        }
    }

    return @[];
}

- (void)testTwoSumAndTarget {
    XCTAssertEqualObjects((@[@0, @1]), [self twoSumNumbers:(@[@2, @7, @11, @15]) andTarget: @9]);
}

// MARK: - 238. Product of Array Except Self

/**
 Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].

 Example:
 Input:  [1,2,3,4]
 Output: [24,12,8,6]

 Note: Please solve it without division and in O(n).

 Follow up:
 Could you solve it with constant space complexity? (The output array does not count as extra space for the purpose of space complexity analysis.)
 */
- (NSArray<NSNumber *> *)productExceptSelf:(NSArray<NSNumber *> *)nums {
    NSMutableArray<NSNumber *> *result = [nums mutableCopy];
    result[0] = @1;

    // Computes left products i.e. [1, 1, 2, 6]
    for (int i = 1; i < result.count; ++i) {
        result[i] = @([result[i - 1] integerValue] * [nums[i - 1] integerValue]);
    }

    NSInteger rightProduct = 1; // right product would be [24, 12, 4, 1]
    for (unsigned long i = result.count - 1; i != NSUIntegerMax; --i) {
        result[i] = @(result[i].integerValue * rightProduct);
        rightProduct *= nums[i].integerValue;
    }

    return result;
}

- (void)testProductExceptSelf {
    XCTAssertEqualObjects((@[@24, @12, @8, @6]), [self productExceptSelf:(@[@1, @2, @3, @4])]);
}

// MARK: - 20. Valid Parentheses

/**
 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:

 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Note that an empty string is also considered valid.

 Example 1:
 Input: "()"
 Output: true

 Example 2:
 Input: "()[]{}"
 Output: true

 Example 3:
 Input: "(]"
 Output: false

 Example 4:
 Input: "([)]"
 Output: false

 Example 5:
 Input: "{[]}"
 Output: true
 */
- (bool)isValid:(NSString *)s {
    // See https://stackoverflow.com/a/23397279
    NSUInteger len = [s length];
    unichar buffer[len + 1];
    [s getCharacters:buffer range:NSMakeRange(0, len)];

    NSMutableArray *stack = [[NSMutableArray alloc] init];
    for (int i = 0; i < len; ++i) {
        unichar parentheses = buffer[i];
        if (parentheses == '(' || parentheses == '{' || parentheses == '[') {
            [stack addObject:[NSString stringWithFormat:@"%C", parentheses]];
        }
        else if (parentheses == ')' && [stack.lastObject isEqualToString:@"("]) {
            [stack removeLastObject];
        }
        else if (parentheses == '}' && [stack.lastObject isEqualToString:@"{"]) {
            [stack removeLastObject];
        }
        else if (parentheses == ']' && [stack.lastObject isEqualToString:@"["]) {
            [stack removeLastObject];
        }
        else {
            return NO;
        }
    }
    return [stack count] == 0;
}

- (void)testIsValid {
    XCTAssertTrue([self isValid:@"()"]);
    XCTAssertTrue([self isValid:@"()[]{}"]);
    XCTAssertFalse([self isValid:@"(]"]);
    XCTAssertFalse([self isValid:@"([)]"]);
    XCTAssertTrue([self isValid:@"{[]}"]);
}

// MARK: - 242. Valid Anagram

/**
 Given two strings s and t , write a function to determine if t is an anagram of s.

 Example 1:
 Input: s = "anagram", t = "nagaram"
 Output: true

 Example 2:
 Input: s = "rat", t = "car"
 Output: false

 Note:
 You may assume the string contains only lowercase alphabets.

 Follow up:
 What if the inputs contain unicode characters? How would you adapt your solution to such case?
 */
- (BOOL)isAnagramString:(NSString *)s otherString:(NSString *)t {
    if (s.length != t.length) {
        return NO;
    }

    NSUInteger len = [s length];
    unichar bufferS[len + 1];
    [s getCharacters:bufferS range:NSMakeRange(0, len)];

    unichar bufferT[len + 1];
    [t getCharacters:bufferT range:NSMakeRange(0, len)];

    int counts[26];
    for (int i = 0; i < len; ++i) {
        counts[bufferS[i] - 'a']++;
        counts[bufferT[i] - 'a']--;
    }

    for (int i = 0; i < len; ++i) {;
        if (counts[i] != 0) {
            return NO;
        }
    }

    return YES;
}

/*
 Alternatives:
 - Sort the arrays using [anArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
 The solution would be O(nlogn).
 - Use a hash table instead of a fixed size counter. Imagine allocating a large size array to fit the entire range of
 unicode characters, which could go up to more than 1 million. A hash table is a more generic solution and could adapt
 to any range of characters.
 */

- (void)testIsAnagrameStringOtherString {
    XCTAssertTrue([self isAnagramString:@"anagram" otherString:@"nagaram"]);
    XCTAssertFalse([self isAnagramString:@"rat" otherString:@"car"]);
}

// MARK: - 217. Contains Duplicate

/**
 Given an array of integers, find if the array contains any duplicates.

 Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.

 Example 1:
 Input: [1,2,3,1]
 Output: true

 Example 2:
 Input: [1,2,3,4]
 Output: false

 Example 3:
 Input: [1,1,1,3,3,4,3,2,4,2]
 Output: true
 */
- (BOOL)containsDuplicate:(NSArray<NSNumber *> *)nums {
    if (nums.count < 2) {
        return NO;
    }

    NSMutableSet *seen = [[NSMutableSet alloc] init];
    for (NSNumber *num in nums) {
        if ([seen containsObject:num]) {
            return YES;
        } else {
            [seen addObject:num];
        }
    }
    return NO;
}

- (void)testContainsDuplicate {
    XCTAssertTrue([self containsDuplicate:(@[@1, @2, @3, @1])]);
    XCTAssertFalse([self containsDuplicate:(@[@1, @2, @3, @4])]);
    XCTAssertTrue([self containsDuplicate:(@[@1, @1, @1, @3, @3, @4, @3, @2, @4, @2])]);
}

@end
