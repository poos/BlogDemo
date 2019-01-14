//import UIKit
//import Foundation
//import PlaygroundSupport



func add(x: Int, y: Int) -> Int {
    return x + y
}


func add(y: Int) -> (Int) -> Int {
    return { x in
        return x + y
    }
}
//
//
//func add(x: Int, y: Int, z: Int, m: Int) -> Int {
//        return x + y + z + m
//}
//
//func add(_ m: Int) -> (Int) -> (Int) -> (Int) -> Int {
//    return { z in
//        return { y in
//            return { x in
//                return x + y + z + m
//            }
//        }
//    }
//}
//


let add: (Int) -> (Int) -> Int = { y in
    return { x in
        return x + y
    }
}

let sub: (Int) -> (Int) -> Int = { y in
    return { x in
        return x - y
    }
}

func calc(a: Int, b: Int, calc: (Int) -> (Int) -> Int) -> Int {
    return calc(a)(b)
}


let add2 = calc(a: 1, b: 3, calc: add)
let sub2 = calc(a: 1, b: 3, calc: sub)

//print(add2)
//print(sub2)


//
//
//
//
//let add2 = add(2)
//let add23 = add2(3)
//let add234 = add23(4)


class Solution {
    //    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    //        var arr = nums.filter({ $0 < target })
    //        for index in 0 ... arr.count - 1 {
    //            let num1 = arr[index]
    //            if arr.count == 1 {
    //                return []
    //            }
    //
    //            for index2 in 1 ... arr.count - 1 {
    //                let num2 = arr[index2]
    //                if num1 + num2 == target {
    //                    return [index, index2]
    //                }
    //            }
    //            arr.remove(at: 0)
    //        }
    //        return []
    //    }
    
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        var hash: [Int : Int] = [:]
        var resArray : [Int] = [];
        
        for (i, j) in nums.enumerated() {
            if let index = hash[target - j]{
                resArray.append(index)
                resArray.append(i)
                return resArray
            }
            hash[j] = i
            
        }
        return resArray;
    }
}

let result = Solution().twoSum([2, 7, 11, 15], 9)

print(result)


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

extension Solution {
    //    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    //        guard let n1 = l1 else {
    //            return l2
    //        }
    //        guard let n2 = l2 else {
    //            return l1
    //        }
    //
    //        var l1 = n1
    //        var l2 = n2
    //        var result: ListNode = ListNode.init(0)
    //        let temp: ListNode = result
    //        var added = false
    //        var first = true
    //
    //
    //        while l1.next != nil && l2.next != nil {
    //            let num = l1.val + l2.val
    //
    //            var item: ListNode
    //            let value = num + (added ? 1 : 0)
    //            added = false
    //            if value < 10 {
    //                item = ListNode.init(value)
    //            } else {
    //                added = false
    //                item = ListNode.init(value - 10)
    //            }
    //            if !first {
    //                temp.next = item
    //            } else {
    //                result = temp
    //            }
    //            first = false
    //            l1 = l1.next!
    //            l2 = l2.next!
    //        }
    //        if added {
    //            temp.next = ListNode.init(1)
    //        }
    //        return result
    //    }
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let n1 = l1 else {
            return l2
        }
        guard let n2 = l2 else {
            return nil
        }
        var l1 = n1, l2 = n2
        var sum = ListNode(0), first = sum
        while true {
            sum.val = sum.val + l1.val + l2.val
            if sum.val >= 10 {
                sum.val = sum.val - 10
                sum.next = ListNode(1)
            } else {
                if l1.next == nil && l2.next == nil { break }
                sum.next = ListNode(0)
            }
            l1 = l1.next ?? ListNode(0)
            l2 = l2.next ?? ListNode(0)
            sum = sum.next ?? ListNode(0)
        }
        return first
    }
}


let two = ListNode.init(2)
let four = ListNode.init(4)
let three = ListNode.init(3)
two.next = four
four.next = three

let five = ListNode.init(5)
let six = ListNode.init(6)
let four2 = ListNode.init(4)
five.next = six
six.next = four2

let result2 = Solution().addTwoNumbers(two, six)

print("\(result2?.val)->\(result2?.next?.val)->\(result2?.next?.next?.val)")


extension Solution {
    
    
    //    func lengthOfLongestSubstring(_ s: String) -> Int {
    //        let string = s.utf8CString
    //
    //        var result = 0
    //
    //        var map = [CChar: Int](minimumCapacity: Int(Int8.max))
    //        var start = 0
    //
    //        for index in 0 ..< string.count-1 {
    //            let c = string[index]
    //            if let last = map[c], last >= start {
    //                start = last + 1
    //            } else if index - start + 1 > result {
    //                result = index - start + 1
    //            }
    //            map[c] = index
    //        }
    //
    //        return result
    //    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var num = 0
        var subString = String()
        s.forEach { (element) in
            if subString.contains(element) {
                num = max(subString.count, num)
                
                if let index = subString.firstIndex(of: element) {
                    subString = String(subString.suffix(from: index))
                    subString.removeFirst()
                }
            }
            subString.append(element)
            
            //            print(subString)
        }
        num = max(subString.count, num)
        return num
    }
}

let result3 = Solution().lengthOfLongestSubstring("pwwkew")

print(result3)


extension Solution {
    //    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    //        var all = nums1 + nums2
    //        all.sort()
    //        print(all)
    //        if all.count % 2 == 0 {
    //            return Double((all[all.count / 2] + all[all.count / 2 - 1])) / 2.0
    //        } else {
    //            return Double(all[all.count / 2])
    //        }
    //    }
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        if nums1.count > nums2.count {
            return findMedianSortedArrays(nums2, nums1)
        }
        let x = nums1.count
        let y = nums2.count
        
        var low = 0
        var high = x
        
        while low <= high {
            let partx = (low + high) / 2
            let party = (x + y + 1) / 2 - partx
            
            let maxLeftX = partx == 0 ? Int.min : nums1[partx - 1]
            let minRightX = partx == x ? Int.max : nums1[partx]
            
            let maxLeftY = party == 0 ? Int.min : nums2[party - 1]
            let minRightY = party == y ? Int.max : nums2[party]
            
            if maxLeftX <= minRightY && maxLeftY <= minRightX {
                if (x + y) % 2 == 0 {
                    return Double(max(maxLeftX, maxLeftY) + min(minRightX, minRightY)) / 2
                } else {
                    return Double(max(maxLeftX, maxLeftY))
                }
            } else if maxLeftX > minRightY {
                high = partx - 1
            } else {
                low = partx + 1
            }
        }
        
        fatalError("not sorted")
    }
}

let result4 = Solution().findMedianSortedArrays([1, 2, 3, 4, 5, 6, 7], [3, 4, 5, 6, 7, 8, 9])

print(result4)



extension Solution {
//    func longestPalindrome(_ s: String) -> String {
//        if(s.count == 0){return ""}
//        if(s.count == 1){return s}
//
//        var start = 0, end = start, stringArray = Array(s), max = 0
//
//        for i in 0 ..< s.count {
//
//            var left = i, right = s.count-1, tempStart = left, tempEnd = right
//
//            while(left<right){
//                /*If values at the Left and Right index are equal then we temporarily store index if greater than max*/
//                if(stringArray[left] == stringArray[right]){
//                    if((right - left) > max){
//                        max = (right - left)
//                        tempStart = left
//                        tempEnd = right
//                    }
//                    left+=1
//                    right-=1
//                }
//                else{//Reset temp variables and the current max
//                    left = i
//                    right = tempEnd - 1
//                    tempStart = left
//                    tempEnd = right
//                    max = 0
//                }
//            }
//            if((tempEnd - tempStart) > (end - start)){//Store temp variables and continue loop
//                end = tempEnd
//                start = tempStart
//            }
//        }
//        return (String(stringArray[start...end]).count > 1) ? String(stringArray[start...end]) : String(s.first!)
//    }
    
    func longestPalindrome(_ s: String) -> String{
        guard s.count > 0 else{
            return ""
        }
        guard s.count > 1 else{
            return s
        }
        var str_arr: [Character] = ["#"]
        s.forEach { (char) in
            str_arr.append(char)
            str_arr.append("#")
        }
        
        var result_arr = [Int](repeating: 0, count: str_arr.count)
        var center = 0, boundary = 0, maxLen = 0, result_center = 0
        
        for i in 1 ..< str_arr.count - 1 {
            // calc mirror i = center-(i-center)
            let iMirror = 2 * center - i
            result_arr[i] = boundary > i ? min(boundary-i, result_arr[iMirror]) : 0
            // Attempt to expand palindrome centered at i
            while i-1-result_arr[i] >= 0 , i + 1 + result_arr[i] <= str_arr.count - 1, str_arr[i+1+result_arr[i]] == str_arr[i-1-result_arr[i]]{
                result_arr[i]+=1
            }
            // update center and boundary
            // 用来记录的
            if i + result_arr[i] > boundary{
                center = i
                boundary = i+result_arr[i]
            }
            // update result
            if result_arr[i] > maxLen{
                maxLen = result_arr[i]
                result_center = i
            }
        }
//          let rawStr = String(str_arr[(result_center-maxLen)...(result_center+maxLen)])
//          print("rawStr: \(rawStr)")
        //  中心 + 边界， 算出左边， 算出右边
        //  这里还有一个转换的运算
        let ans = String(s[
            s.index(s.startIndex, offsetBy: (result_center-maxLen)/2)
                ..<
                s.index(s.startIndex, offsetBy: (result_center+maxLen)/2)])
    
        // print("ans: \(ans)\n")
        return ans
    }
}


let strAAA = "letminRi####ghtX=partx=6=x?Int.max:naaaums1[partx]"
print(strAAA.count)
let result5 = Solution().longestPalindrome(strAAA)

print(result5)


extension Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        if s.count <= 1  { return s }
        if numRows < 2 { return s }
        
        var zRows = [String](repeating: String(), count: min(s.count, numRows)) // 所有行
        var cursorRow = 0 // 光标的位置索引
        var nextLine = false // 是否换行
        
        for ch in s {
            zRows[cursorRow] += String(ch) // 光标位置字符
            if cursorRow == 0 || cursorRow == numRows - 1 { // 当为起始行时, 换行; 当为最后一行时, 不换行
                nextLine.toggle()
            }
            cursorRow += nextLine ? 1 : -1 // 移动光标
        }
        return zRows.joined()
    }
}

let result6 = Solution().convert(strAAA, 7)
print(result6)


/**
 
  _____   _   _   _____   _          __  __   _              _____   _   _____
 /  ___/ | | | | /  _  \ | |        / / |  \ | |            |  _  \ | | | ____|
 | |___  | |_| | | | | | | |  __   / /  |   \| |    _____   | |_| | | | | |__
 \___  \ |  _  | | | | | | | /  | / /   | |\   |   |_____|  |  _  { | | |  __|
  ___| | | | | | | |_| | | |/   |/ /    | | \  |            | |_| | | | | |___
 /_____/ |_| |_| \_____/ |___/|___/     |_|  \_|            |_____/ |_| |_____|
 
  _____   _   _   _____   _          __  __   _
 /  ___/ | | | | /  _  \ | |        / / |  \ | |
 | |___  | |_| | | | | | | |  __   / /  |   \| |
 \___  \ |  _  | | | | | | | /  | / /   | |\   |
  ___| | | | | | | |_| | | |/   |/ /    | | \  |
 /_____/ |_| |_| \_____/ |___/|___/     |_|  \_|
 
 
  _____   _   _____      _____   _   _   _     __    __  _   _       ___   __   _
 |  _  \ | | | ____|    /  ___/ | | | | | |    \ \  / / | | | |     /   | |  \ | |
 | |_| | | | | |__      | |___  | |_| | | |     \ \/ /  | | | |    / /| | |   \| |
 |  _  { | | |  __|     \___  \ |  _  | | |      }  {   | | | |   / /_| | | |\   |
 | |_| | | | | |___      ___| | | | | | | |     / /\ \  | |_| |  / /  | | | | \  |
 |_____/ |_| |_____|    /_____/ |_| |_| |_|    /_/  \_\ \_____/ /_/   |_| |_|  \_|
 

  ______      ___  ___   _          __  _____           _____  __    __
 |___  /     /   |/   | | |        / / |  _  \         /  ___/ \ \  / /
    / /     / /|   /| | | |  __   / /  | | | |  _____  | |___   \ \/ /
   / /     / / |__/ | | | | /  | / /   | | | | |_____| \___  \   }  {
  / /__   / /       | | | |/   |/ /    | |_| |          ___| |  / /\ \
 /_____| /_/        |_| |___/|___/     |_____/         /_____/ /_/  \_\
 */






















