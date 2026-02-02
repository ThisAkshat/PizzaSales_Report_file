class Solution {
    public long maximumHappinessSum(int[] happiness, int k) {
        Arrays.sort(happiness);
        reverseArray(happiness);

        long result = 0;
        int count = 0;

        for(int i =0 ; i<k; i++){
            result = result + Math.max(happiness[i] - count, 0);
            count++;
        }
        return result;
    }
    private int reverseArray(int[] arr){
        int start = 0;
        int end = arr.length - 1;
        while(start < end){
            int temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++;
            end--;
        }
        return 0;
    }
}

/*
What the problem actually means:-

You will pick k children one by one.
Every time you pick a child:
You get their current happiness
Every other unpicked child loses 1 happiness (but never below 0)
So the longer you wait to pick someone, the more their happiness drops.
So the rule becomes:
If you want maximum total happiness, pick the happiest kids as early as possible.

Why sorting descending is required
Arrays.sort(happiness);
reverseArray(happiness);
This puts happiness in descending order:
biggest → smallest
So you always try to pick the happiest remaining child first.

That’s optimal because:
Everyone else loses 1 happiness after every pick
So delaying a high-value child wastes value
What count means
int count = 0;

After count picks:
Every remaining child has lost count happiness
So the real happiness when you pick the i-th child is:
happiness[i] - count

But it can’t go below 0:
Math.max(happiness[i] - count, 0)
What the loop does
for(int i = 0; i < k; i++){
    result += Math.max(happiness[i] - count, 0);
    count++;
}

This simulates:
Pick the i-th largest child
Subtract how much happiness they lost due to previous picks
Add it
Increase the decay for the next round

*****************************************************************************

Short dry run:-
Example:
happiness = [1,2,3], k = 2

After sort + reverse:
[3,2,1]

Round 1:
count = 0
pick 3 → 3 - 0 = 3
result = 3

Round 2:
count = 1
pick 2 → 2 - 1 = 1
result = 4

Answer = 4

*/
