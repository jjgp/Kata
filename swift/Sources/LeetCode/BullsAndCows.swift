/// [299. Bulls and Cows](https://leetcode.com/problems/bulls-and-cows/)
/// Notes:
/// - Array(String) and subsequent iteration is faster than iterating on the string itself
/// via String.Index arithmetic
/// - An alternative to the counts array is using a dictionary as indexed by character
class BullsAndCows {
    func getHint(_ secret: String, _ guess: String) -> String {
        let secret = Array(secret)
        let guess = Array(guess)
        var bulls = 0
        var cows = 0
        var counts = [Int](repeating: 0, count: 10)
        
        for i in 0..<secret.count {
            let guessValue = guess[i].wholeNumberValue!
            let secretValue = secret[i].wholeNumberValue!
            
            if guessValue == secretValue {
                bulls += 1
            } else {
                if counts[secretValue] > 0 {
                    cows += 1
                }
                counts[secretValue] -= 1
                
                if counts[guessValue] < 0 {
                    cows += 1
                }
                counts[guessValue] += 1
            }
            
        }
        return "\(bulls)A\(cows)B"
    }
}
