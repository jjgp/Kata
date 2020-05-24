//
//  LeetCode+Array.m
//  LeetCode
//
//  Created by Jason Prasad on 5/20/20.
//

#import "LeetCode.h"

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

    NSUInteger len = s.length;
    unichar bufferS[len + 1];
    [s getCharacters:bufferS range:NSMakeRange(0, len)];

    unichar bufferT[len + 1];
    [t getCharacters:bufferT range:NSMakeRange(0, len)];

    int counts[26] = {0};
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

// MARK: - 121. Best Time to Buy and Sell Stock

/**
 Say you have an array for which the ith element is the price of a given stock on day i.

 If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.

 Note that you cannot sell a stock before you buy one.

 Example 1:
 Input: [7,1,5,3,6,4]
 Output: 5

 Explanation:
 Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5. Not 7-1 = 6, as selling price needs to be larger than buying price.

 Example 2:
 Input: [7,6,4,3,1]
 Output: 0

 Explanation:
 In this case, no transaction is done, i.e. max profit = 0.
 */
- (NSNumber *)maxProfit:(NSArray<NSNumber *> *)prices {
    NSNumber *min = @(NSIntegerMax);
    NSNumber *profit = @0;
    for (int i = 0; i < prices.count; ++i) {
        NSNumber *price = prices[i];
        if ([price compare:min] == NSOrderedAscending) {
            min = price;
        } else {
            profit = @(MAX(profit.integerValue, price.integerValue - min.integerValue));
        }
    }
    return profit;
}

- (void)testMaxProfit {
    XCTAssertEqualObjects(@5, [self maxProfit:(@[@7, @1, @5, @3, @6, @4])]);
    XCTAssertEqualObjects(@0, [self maxProfit:(@[@7, @6, @4, @3, @1])]);
}

// MARK: - 152. Maximum Product Subarray

/**
 Given an integer array nums, find the contiguous subarray within an array (containing at least one number) which has the largest product.

 Example 1:
 Input: [2,3,-2,4]
 Output: 6

 Explanation:
 [2,3] has the largest product 6.

 Example 2:
 Input: [-2,0,-1]
 Output: 0

 Explanation:
 The result cannot be 2, because [-2,-1] is not a subarray.
 */

- (NSNumber *)maxProduct:(NSArray<NSNumber *> *)nums {
    int globalMax = nums[0].intValue;
    for (int i = 1, localMax = globalMax, localMin = globalMax; i < nums.count; ++i) {
        int num = nums[i].intValue;
        if (num < 0) {
            localMax ^= localMin;
            localMin ^= localMax;
            localMax ^= localMin;
        }

        localMax = MAX(num, localMax * num);
        localMin = MIN(num, localMin * num);
        globalMax = MAX(globalMax, localMax);
    }

    return @(globalMax);
}

- (void)testMaxProduct {
    XCTAssertEqualObjects(@6, [self maxProduct:(@[@2, @3, @(-2), @4])]);
    XCTAssertEqualObjects(@0, [self maxProduct:(@[@(-2), @0, @(-1)])]);
}

// MARK: - 49. Group Anagrams

/**
 Given an array of strings, group anagrams together.

 Example:
 Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
 Output:
 [
   ["ate","eat","tea"],
   ["nat","tan"],
   ["bat"]
 ]

 Note:
 - All inputs will be in lowercase.
 - The order of your output does not matter.
 */
- (NSArray<NSArray<NSString *> *> *)groupAnagrams:(NSArray<NSString *> *)strs {
    NSMutableDictionary<NSString *, NSMutableArray<NSString *> *> *groups = [[NSMutableDictionary alloc] init];
    for (NSString *str in strs) {
        NSString *key = anagramKey(str);
        if (groups[key] == nil) {
            groups[key] = [[NSMutableArray alloc] initWithObjects:str, nil];
        } else {
            [groups[key] addObject:str];
        }
    }
    return groups.allValues; // This is technically returning mutable arrays!
}

static inline NSString * anagramKey(NSString *str) {
    NSUInteger len = str.length;
    unichar buffer[len + 1];
    [str getCharacters:buffer range:NSMakeRange(0, len)];

    int counts[26] = {0};
    for (int i = 0; i < len; ++i) {
        counts[buffer[i] - 'a']++;
    }

    NSMutableString *key = [[NSMutableString alloc] init];
    for (int i = 0; i < 26; ++i) {
        int count = counts[i];
        [key appendString:[NSString stringWithFormat:@"%d", count]];
    }

    return [key copy];
}

- (void)testGroupAnagrams {
    NSArray *input = @[@"eat", @"tea", @"tan", @"ate", @"nat", @"bat"];
    NSArray *output = @[
        @[@"ate", @"eat", @"tea"],
        @[@"nat", @"tan"],
        @[@"bat"]
    ];
    
    NSArray *result = [self groupAnagrams:input];
    XCTAssertEqualObjects(output, (@[
        [result[0] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)],
        [result[1] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)],
        result[2]
                                   ]));
}

// MARK: - 33. Search in Rotated Sorted Array

/**
 Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

 (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

 You are given a target value to search. If found in the array return its index, otherwise return -1.

 You may assume no duplicate exists in the array.

 Your algorithm's runtime complexity must be in the order of O(log n).

 Example 1:
 Input: nums = [4,5,6,7,0,1,2], target = 0
 Output: 4

 Example 2:
 Input: nums = [4,5,6,7,0,1,2], target = 3
 Output: -1
 */
- (int)searchNums:(NSArray<NSNumber *> *)nums forTarget:(int)target {
    return [self searchNums:nums
                  forTarget:target
                   withLeft:0
                   andRight:(int)nums.count - 1];
}

- (int)searchNums:(NSArray<NSNumber *> *)nums
        forTarget:(NSInteger)target
         withLeft:(int)left
         andRight:(int)right {
    if (right < left) {
        return -1;
    }

    int mid = left + (right - left) / 2;
    if (nums[mid].intValue == target) {
        return mid;
    }

    if (nums[left] <= nums[mid]) {
        if (target >= nums[left].intValue && target < mid) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    } else {
        if (target <= nums[right].intValue && target > mid) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return [self searchNums:nums
                  forTarget:target
                   withLeft:left
                   andRight:right];
}

- (void)testSearchNumsForTarget {
    XCTAssertEqual(4, [self searchNums:(@[@4, @5, @6, @7, @0, @1, @2]) forTarget:0]);
    XCTAssertEqual(-1, [self searchNums:(@[@4, @5, @6, @7, @0, @1, @2]) forTarget:3]);
}

// MARK: - 15. 3Sum

/**
 Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

 Note:

 The solution set must not contain duplicate triplets.

 Example:

 Given array nums = [-1, 0, 1, 2, -1, -4],

 A solution set is:
 [
   [-1, 0, 1],
   [-1, -1, 2]
 ]
 */
- (NSArray<NSArray<NSNumber *> *> *)threeSum:(NSArray<NSNumber *> *)nums {
    if (nums.count < 3) { return @[]; }
    nums = [nums sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *threeSum = [[NSMutableArray alloc] init];

    for (int i = 0; i < nums.count - 2; ++i) {
        int a = nums[i].intValue;
        if (a > 0) { break; }
        if (i != 0 && a == nums[i - 1].intValue) { continue; }

        int j = i + 1, k = (int)nums.count - 1;
        while (j < k) {
            int b = nums[j].intValue;
            int c = nums[k].intValue;
            int bc = b + c;
            if (a + bc == 0) {
                [threeSum insertObject:@[@(a), @(b), @(c)] atIndex:0];
                do {
                    ++j;
                } while (b == nums[j].intValue);
                do {
                    --k;
                } while (c == nums[k].intValue);
            } else if (-a > bc) {
                ++j;
            } else {
                --k;
            }
        }
    }

    return [threeSum copy];
}

- (void)testThreeSum {
    NSArray *expected = @[
        @[@(-1), @0, @1],
        @[@(-1), @(-1), @2]
    ];
    XCTAssertEqualObjects(expected, [self threeSum:(@[@(-1), @0, @1, @2, @(-1), @(-4)])]);
}

@end

