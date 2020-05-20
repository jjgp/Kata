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

/// Given an array of integers, return indices of the two numbers such that they add up to a specific target.
/// You may assume that each input would have exactly one solution, and you may not use the same element twice.
///
/// Given nums = [2, 7, 11, 15], target = 9,
///
/// Because nums[0] + nums[1] = 2 + 7 = 9,
/// return [0, 1].
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

/// Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product
/// of all the elements of nums except nums[i].
///
/// Input:  [1,2,3,4]
/// Output: [24,12,8,6]
///
/// Constraint: It's guaranteed that the product of the elements of any prefix or suffix of the array (including the
/// whole array) fits in a 32 bit integer.
///
/// Note: Please solve it without division and in O(n).
///
/// Follow up:
/// Could you solve it with constant space complexity? (The output array does not count as extra space for the purpose
/// of space complexity analysis.)
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

/// Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
/// An input string is valid if:
///   1. Open brackets must be closed by the same type of brackets.
///   2. Open brackets must be closed in the correct order.
/// Note that an empty string is also considered valid.
///
/// Example 1:
///   Input: "()"
///   Output: true
///
/// Example 2:
///   Input: "()[]{}"
///   Output: true
///
/// Example 3:
///   Input: "(]"
///   Output: false
///
/// Example 4:
///   Input: "([)]"
///   Output: false
///
/// Example 5:
///   Input: "{[]}"
///   Output: true
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

@end
