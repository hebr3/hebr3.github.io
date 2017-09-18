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

For example, four players have the scores `100`, `90`, `90`, and `80`. Those players will have ranks `1`, `2`, `2`, and `3`, respectively.

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
           (place i (cdr L))]))
  (for ([i M])
    (displayln (place i N**))))

> cpu time: 10740 real time: 10756 gc time: 12
> cpu time: 11304 real time: 11100 gc time: 16
> cpu time: 10700 real time: 10701 gc time: 4
```

Version 2
---

My initial attempt at increasing the speed of the funtion was to cleaning up the `place` funtion, specifically the conditional statement with it's 4 branches. While I was able to remove a clause from the condition and increased the execution speed by a factor of 2, the `place` function was still taking `O(n^2)` time.

I also recieved a small improvement in the speed of the program by rereading the discription and realizing that I didn't need to sort the list of scores as they are given in descreasing order. However this improvement wasn't significant and my testing showed that it only increased the performance by approximately `3%`.

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

> cpu time: 5588 real time: 5589 gc time: 0
> cpu time: 5676 real time: 5673 gc time: 8
> cpu time: 5808 real time: 5815 gc time: 12
```

Version 3
---

After reading some of the comments on the problem I decided to refactor the `place` function to take advantage of [dynamic programming](https://en.wikipedia.org/wiki/Dynamic_programming) concepts. Specifically, to cache intermediate results so that the program would run in `O(n)` time.

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

