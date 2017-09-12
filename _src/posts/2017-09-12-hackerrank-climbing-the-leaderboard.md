    Title: hackerrank - Climbing the Leaderboard
    Date: 2017-09-12T00:00:00
    Tags: hackerrank, Dynamic Programming, Memoization, Racket
    Authors: Henry Brooks

While working through the algorithm problem sets available at [hackerrank](www.hackerrank.com) I found another problem that required Dynamic Programming technics to solve completely. [Climbing the Leaderboard](https://www.hackerrank.com/challenges/climbing-the-leaderboard/problem) requires an `O(n)` solution to complete the activity before it times out.

<!-- more -->

Description
---

Alice is playing an arcade game and wants to climb to the top of the leaderboard. Can you help her track her ranking as she beats each level? The game uses [Dense Ranking](https://en.wikipedia.org/wiki/Ranking#Dense_ranking_.28.221223.22_ranking.29), so its leaderboard works like this:

* The player with the highest score is ranked number 1 on the leaderboard.

* Players who have equal scores receive the same ranking number, and the next player(s) receive the immediately following ranking number.

For example, four players have the scores 100, 90, 90, and 80. Those players will have ranks 1, 2, 2, and 3, respectively.

When Alice starts playing, there are already `n` people on the leaderboard. The score of each player `i` is denoted by `s_i`. Alice plays for `m` levels, and we denote her total score after passing each level `j` as `alice_j`. After completing each level, Alice wants to know her current rank.

You are given an array, `scores`, of monotonically decreasing leaderboard scores, and another array, `alice`, of Alice's cumulative scores for each level of the game. You must print `m` integers. The `j^th` integer should indicate the current rank of alice after passing the `j^th` level.

Version 1
---

I began by creating functions that would read the list and determine location where we should place the new score.

```racket
(let* ([n (read)]
       [N (for/list ([i n]) (read))]
       [N* (sort (remove-duplicates N) >)]
       [N** (for/list ([i N*][j (length N*)]) (cons i (add1 j)))]
       [m (read)]
       [M (for/list ([i m]) (read))])
  (define (place i L)
    (cond [(and (< i (caar L))
                (empty? (cdr L)))
           (add1 (cdar L))]
          [(= (caar L) i)
           (cdar L)]
          [(< (caar L) i)
           (cdar L)]
          [else
           (index i (cdr L))]))
  (for ([i M])
    (displayln (place i N**))))
```

Version 2
---

I initially attempted to speed the execution time of the funtion up by cleaning up the place funtion. While I was able to remove a clause from the condition, the function was still taking `O(n^2)` time. I actually recieved a better speed up by realizing that I didn't need to sort the list of scores as they were given in descreasing order.

```racket
(let* ([n (read)]
       [N (for/list ([i n]) (read))]
       [N* (remove-duplicates N)]
       [N** (map (lambda (x y) (cons x (add1 y)))
                 N*
                 (range (length N*)))]
       [m (read)]
       [M (for/list ([i m]) (read))])
  (define (place n l)
    (cond
      [(>= n (caar l)) (cdar l)]
      [(empty? (cdr l)) (add1 (cdar l))]
      [else (place n (cdr l))]))
  (for ([i M])
    (displayln (place i N**))))
```

Version 3
---

```racket
(let* ([n (read)]
       [N (for/list ([i n]) (read))]
       [N* (remove-duplicates N)]
       [len (length N*)]
       [m (read)]
       [M (for/list ([i m]) (read))])
  (define index 0)
  (define (dynamic-place n l i)
    (define (update-call)
      (set! index (add1 index))
      (dynamic-place n l index))
    (cond
      [(= i (length l)) (- len i -1)]
      [(< n (list-ref l i)) (- len i -1)]
      [else (update-call)]))
  (for ([i M])
    (displayln (dynamic-place i (reverse N*) index))))
```

Version 4
---

```python
#!/bin/python3

import sys


n = int(input().strip())
scores = [int(scores_temp) for scores_temp in input().strip().split(' ')]
m = int(input().strip())
alice = [int(alice_temp) for alice_temp in input().strip().split(' ')]
# your code goes here

scores2 = sorted(list(set(scores)))

index = 0

for s in alice:
    while (index < len(scores2) and s >= scores2[index]):
        index = index + 1
    print(n - index - 1)
```

