\name{lcm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
lcm
}
\description{
R wrapper around Frequent Itemset Mining tool: lcm
}
\usage{
lcm(list(command, [options,] input-filename, [output-filename]))
}
%- maybe also 'usage' for other objects documented here.
\details{
params should be a list containing all input arguments (each space-separated item should be an individual character vector item in the list).

"input-filename" is the filename of the input transaction database.
The 1st letter of input-filename must not be '-'. Otherwise it is 
regarded as an option. The input file format is written below. "support"
is the support, which is for given the threshold of frequency.
"output-filename" is the name of file to write the itemsets the program
finds. You can omit the output file to see only the number of frequent
itemsets in the database. If the output file name is "-", the
solutions will be output to the standard output.

The first parameter [command] is composed of some letters, and given
to the program to indicate the task.

 F: enumerate frequent itemsets,
 C: enumerate closed frequent itemsets
 M: enumerate maximal frequent itemsets

For example, if you want to enumerate maximal frequent itemset, type 
"M" in the first parameter. Additionally, we can give the following
commands, to specify the output style: 

 _: no output to standard output (including messages w.r.t. input data)
 %: show the progress of computation
 +: if the output file exists, append the solutions to the output file
 i: do not output itemset to the output file (only rules are written)
 f: output the frequency on the end of each itemset found,
 Q: output the frequency on the head of each itemset found,
 A: output positive/negative frequency, and (frequency)/(absolute
    frequency); positive/negative frequency is the sum of weights of
    the occurrence which have positive/negative weights, respectively.
    Absolute frequency is the sum of absolute value of the weights of 
    the occurrences.
 s: output confidence and item frequency by absolute values; in default, 
    they are written by ratio, but by this command they are written by 
    #transactions/sum of the transaction weights
 I: output ID's of transactions including each itemset; ID of a
    transaction is given by the number of line in which the transaction
    is written. The ID starts from 0.
 R: output redundant items for rule mining
    usually, one might think that the redundant items whose removals
    do not affect the frequency and the confidence are not necessary
    to be output, thus LCM removes those items (but not all) from the
    itemsets, in the case of rule mining. This command disables this 
    function, thus the itemsets to be output will be the same as the 
    usual itemset mining.
 t: transpose the database so that item i will be transaction i, thus
    if item i is included in j-th transaction, then item j will be
    included in i-th transaction.

The output format is explained below. The following options are to
restrict the itemset to be found. We can type them between the first 
parameter and the second parameter. Of course the option can be nothing.

 -l,-u [num]: enumerate itemsets with size at least/most [num]  
 -U [num]: enumerate itemsets with frequency at most [num]
 -w [filename]: read weights of transactions from the file (ver. 4 and 5)
    the frequency of itemset will be the sum of weights of the transactions
    which include the itemset.
 -c [filename]: read constraints graph between items (ver. 5.2)
 -C [filename]: read un-constraint graph between items (ver. 5.2)

Following options are only for ver. 5.x.

 -# [num]: stop after outputting [num] solutions
 -, [char]: give the separator of the numbers in the output
    the numbers in the output file are separated by the given
    character [char].
 -Q [filename]: replace the output numbers 
    according to the permutation table written in the file of
    [filename], replace the numbers in the output. The numbers in the
    file can be separated by any non-numeric character such as newline
    character. 
 -m,-M [filename]:read/write item ordering from/to file [filename]
 -K [num]: output the frequency of [num]-th largest frequent(closed/maximal)
    itemsets (only for ver.5). Notice that it outputs only the frequency,
    thus no itemset will be output
 -f,-F [ratio]: output itemsets with frequency [ratio] times smaller/larger
    than that in the case of independence; let p be the product of 
    (frequency of i)/(#transactions) for all item i in the itemset.
 -i [num]: find association rule for item [num]; output all rules of the form
    {1,3,5} => [num]. The criteria to output a rule can be given by other
    options.
 -a,-A [ratio]: find association rules of confidence at least [ratio]; an
    association rule of {1,3,5} => 2 will be output if the frequency of
    {1,3,5,2} is no less/no more than the frequency of {1,3,5} times [ratio].
 -r,-R [ratio]: find association rules of relational confidence at least
    [ratio]; an association rule of {1,3,5} => 2 will be output if the
    frequency of {1,3,5,2} is no less/no more than the frequency of {1,3,5}
    times (frequency of {2}/(#transactions in the database)) times [ratio].
 -p,-P [num]: output pattern itemset only if (frequency) / (absolute
    frequency) is no less/no greater than [num]. Absolute frequency is the
    sum of absolute weights of the occurrences of the pattern itemset.
 -n,-N [num]: output pattern itemset only if its negative frequency is
     no less/no greater than [num]. Negative frequency is the sum of
     weights of the occurrences which have negative weights
 -o,-O [num]: output pattern itemset only if its positive frequency is
     no less/no greater than [num]. Positive frequency is the sum of
     weights of the occurrences which have positive weights

-l, -u, and -U specify the upper/lower bound for itemset/frequency.
itemsets exceed the upper/lower bound will be not output.
When we give -S option and a number X, the program will terminate
if it finds X solutions, even if there are more solutions.

If we specify "-w" and filename, then LCM reads the file as a weight 
database of transactions. Each i-th line of the file is regarded as
the weight of i-th transaction. With transaction weights, LCM finds
the itemsets such that the sum of weights of the transaction including
the itemset is no less than the support. The weights can be real numbers.
For version 5, we can give negative weights.

"-c" and "-C" options (only for ver 5): "-c" option is for giving item
constraints. An item constraint is given between two items which can not
be included in frequent itemsets together with. In the other words, if
an item constraint is given for items 1 and 2, then {1,2} can not be
included in any frequent itemset. The set of item constraints forms an
undirected graph. Thus, LCM inputs item constraints by a graph. The
filename following to "-c" is regarded as a graph file. The format of the
graph file is written below. Conversely, "-C" option is for giving
"un-constraint" item pairs. In precise, when we give "-C" option, 
the item constraint between items 1 and 2 means that {1,2} can be included 
in frequent itemsets. That is, if no item constraint is given for 
items 1 and 2, the pair {1,2} can not be included in any frequent itemset.
The un-constraints of "-C" option are also given by graph, of the same
format to "-c" option.

If we specify "-w" and filename, then LCM reads the file as a weight 
database of transactions. Each i-th line of the file is regarded as
the weight of i-th transaction. With transaction weights, LCM finds
the itemsets such that the sum of weights of the transaction including
the itemset is no less than the support. The weights can be real numbers.
For version 5, we can give minus weights.

When we give -K option, LCM computes the frequency of the [num]-th largest
frequent(closed/maximal) itemsets, and output it to the standard output
(print it to the command line). By giving the output frequency to LCM, 
we can enumerate top-[num] frequent itemsets (closed, or maximal).


Examples)

- to find all frequent itemsets in "test.dat" for support 4, sizes of
 no less than 3, output frequencies of each itemsets found, do not
 output to file, show progress, and stop if 1,000,000 solutions will
 be found;

% lcm FfV -l 3 -S 1000000 test.dat 4

- to find closed itemsets in "test.dat" with frequency at least 6, sizes 
 from 5 to 10, output itemsets to "out.dat";

% lcm C -l 5 -u 10 test.dat 6 out.dat

- to find maximal frequent itemsets in "test.dat" with weight file
  "weight.dat" with frequency at least 8, output to "out.dat" with
   transaction IDs, and no output for standard output;
   
% lcm MqI -w weight.dat test.dat 8 out.dat

- to specify item constraint file g.grh, for "test.dat" with frequency
   at least 3, and output out.dat;

% lcm F -c g.grh test.dat 8 out.dat

When -m,-M [filename] options are given, LCM reads/writes item permutation
from/to the file of [filename]. LCM internally permute the items for the 
efficient computation, and this option is to enforce the permutation to
a specified one, or to know the permutation. The file format is just a list
of indices, for example, if 0,1,2,3 will be 2,1,0,3 then the file is 

2
1
0
3
[EOF]

For the items whose permutation is not written in the file, LCM determine
its internal indices.

-f and -F options are for finding itemsets with high relational frequency.
For each item i, let us consider (frequency of {i}) / (#transactions in D)
as the appearance probability that item i is included in a transaction.
If the appearance probability of each item is independent to each other,
the frequency of an itemset S is expected to be the product of these
appearance probabilities of its items times (#transactions in D). We here
define the relational frequency of S by
(frequency of S) / (expected frequency of S).
When we give -f [num] option, LCM outputs frequent itemsets with relational 
frequency no less than [num]. Similarly, frequent itemsets with relational 
frequency no greater than [num] is output when -F [num] option is given.

When -n/-N [num] options are given, LCM outputs only itemsets having
negative frequency at least/most [num]. The negative frequency of itemset
S is the sum of weights of the transactions that include S and have
negative weights. Similarly, the positive weights of S is defined. 
When -o/-O options are given, LCM outputs only itemsets having positive 
weights.

-p/-P [ratio] options are to evaluate the absolute frequency ratio.
The absolute frequency of itemset S is the sum of absolute weight of 
the transactions including S, and the absolute frequency ratio is 
given by the frequency of S divided by the absolute frequency of S.
When -p/-P options are given, LCM outputs only itemset having absolute 
frequency ratio at least/most [ratio].

The above three kinds of options can be used to find emerging itemsets.
For two databases D1 and D2 , the emerging itemsets are itemsets having
quite different frequencies in D1 and D2, i.e., having a large frequency
in one database and a small frequency in the other. There are several
models to define emerging itemsets, such as (a) the difference of the
frequencies between D1 and D2 are at least the given threshold s, 
(b) the frequency in D1 over the frequency in D2 is at least s, and so on.
If we give a positive weight to each transaction of A, and a negative weight
to each transaction of B, emerging itemsets defined as (a) have large
frequencies, and those as (b) have large or small absolute frequency ratio.
-n/-N, -o/-N options can be used to prune the itemset whose frequency in 
either D1 or D2 is too small or too large.

The options -m/-M [filename] is used to control the order of the output
itemsets. Before computing the frequent itemsets, LCM gives an ordering
to items according to the decreasing order of their frequency, and find
the frequent itemsets in their lexicographically order. -M option outputs
this ordering to the file. The format of the file is just a sequence of
items in the order. Instead of using frequency ordering, the -m option
inputs the item ordering from the file. The input file format is the same
to the format of -M option, but it accepts any non-numeric separator.
Using these options, you can control the order of finding the frequent
itemsets, which can be used to compare the set of frequent itemsets in 
different databases.

The remaining options are for the association rule mining. An association
rule is a pair of an itemset S and an item x with the form "S => x".
The confidence of the rule is the ratio of transactions including x,
in the set of transactions including S. If the confidence is high, 
we can say that a transaction including S may include x with high
probability. The remaining options are for enumerating all such association
rules with higher or lower confidence 

-a [ratio] and -A [ratio] options are for specifying the threshold value 
for the confidence. When -a option and [ratio] are given, LCM finds all 
association rules with confidence at least [ratio]. Conversely, association
rules with confidence at most [ratio] are found when we give -A option.

-r [ratio] and -R [ratio] options are also for specifying the threshold, but
the threshold values changes according to the frequency of each item.
Precisely, when we give -R and [ratio], an association rule S => x is
output if its confidence is no greater than
 [ratio] * (frequency of {x}/#transactions),
thus it is output only if the confidence is small compared to the frequency
of x in the database. Conversely, when we give -r and [ratio], an association
rule S => x is output if (1 - its confidence) is no greater than [ratio] *
(1- frequency of {x}).

When -i [num] option is given, LCM finds only the rules of the form
 S => [num] ([num] is an item).


Examples)
- To find all association rule "A => b" such that frequency of A is no less 
than 200, and the confidence is no less than 0.9. The input file is
 "test.dat" and the output file is "out".

% lcm C -a 0.9 test.dat 200 out

- To find all association rule "A => b" such that frequency of A is no less 
than 200, and the confidence is no greater than
 0.1 * (frequency of {x}/#transactions). The item b is specified as item 5.
The input file is "test.dat" and the output file is "out".

% lcm C -R 0.1 -i 5 test.dat 200 out


###############################
####   Input File Format   ####
###############################

Each line (row) of the input file is a transaction. The items included in 
a transaction are listed in a line. The items must be numbers begin from 1.
They can not be minus. The item numbers do not have to be continuous, but
notice that the program takes memory linear in the maximum item number.
The separator of numbers can be any non-numeric letter, such as 
","  " " ":" "a", etc.

Example)  ( "[EOF]" is the end of file )
0 1 2
1
2 3 4
4,1 2 3
2,1
[EOF]

The file format of item constraints (or complement) graphs is as follows.
The ith row (line) of the file corresponds to node i-1. The first line
corresponds to the node 0, and the 10th line corresponds to node 9. The
node larger than i-1 and adjacent to i-1 is listed in the i-th line.
The nodes are written by numbers. Separator to the number can be ",",
but the graph load routine accepts any letter for the separator but
not a number, +, and -. If the edge set is {(0,1),(0,2),(1,1),(1,3),(2,3)},
the file will be 
===========
   1,2
   1 3
   3
   
   [EOF]
=========
where "[EOF]" is a symbol for the end of file.

#############################
####    Output Format    ####
#############################

When the program is executed, the program prints out the #items,
#transactions, and other features of the input database to standard
error. After the termination of the enumeration, it outputs the total
number of itemsets found (frequent/closed/maximal itemsets), and the 
numbers of itemsets of each size. For example, if there are 4 frequent
itemsets of size 1, 2 frequent itemsets of size 3, and 1 frequent itemset
of size 3, then the output to standard output will be,

9   <= total #frequent itemsets
1   <= #frequent itemsets of size 0 (empty set), it is always frequent
4   <= #frequent itemsets of size 1
3   <= #frequent itemsets of size 2
1   <= #frequent itemsets of size 3

If "q" is given in the first parameter, these do not appear in the
standard output.

If output-filename was given, then the itemsets found are written to 
the output file. Each line of the output file is the list of items 
included in an itemset found, separated by " ". By giving "-," option
we can change the separator. If "f" is given in the first parameter,
the frequency follows each itemset, for example,

1 5 10 2 4 (22)

which means itemset {1,2,4,5,10} is included in 22 transactions. When "Q"
option is given, the output will be 

(22) 1 5 10 2 4

The output itemsets are not sorted. If you want to sort it, use the script
"sortout.pl". The usage is just,

% sortout.pl < input-file > output-file

"input-file" is the name of file to which LCM outputs, and the sorted output
will be written in the file of the name "output-file".
The items of each itemset will be sorted in the increasing order of
items, and all the itemsets (lines) will be also sorted, by the
lexicographical order (considered as a string).
(Actually, you can specify separator like sortout.pl ",").

An association rule S => x, for example {1,2,3} => 5 is output in the form 

[xxx yyy] 5 <= 1 2 3

where xxx is the confidence of the rule, and yyy is
 (frequency of y)/#transactions in D.


###########################
####    Performance    #### 
###########################

The performance of LCM is stable, for both computation time and memory use.
The initialization and preprocess time of LCM is linear in the size of 
input database. The computation time for finding frequent itemsets depends
on the number of itemsets found, and the minimum support.
When the minimum support is large and the number of the itemsets found is
small, the computation time for each itemset is relatively large. However, 
computation time per itemset decreases as the increase of the itemsets found,
and roughly speaking when the size of output file is equal to the input
database size, it will be constant, such as 1/1,000,000 sec (by PC with 
CPU of 2GHz.)

Memory usage of LCM is very stable. It is an advantage compared to other 
implementations. The memory usage of LCM is always linear in the size of
the input database. Approximately LCM uses integers at most three times
as much as the database size, which is the sum of the number of items of
each transaction. The memory usage of the other implementations increases 
as the increase of the number of frequent itemsets, but that of LCM does not.

}
\value{
If applicable, returns the optimal value found.
}
\references{
Bart Goethal, "FIMI repository", http://fimi.cs.helsinki.fi/
(various frequent itemset implementation, benchmark databases, computational
experiments comparing all implementations, and papers explaining the
implementations, very useful site)

Takeaki Uno, Masashi Kiyomi, Hiroki Arimura, LCM ver.3: Collaboration of Array, Bitmap and Prefix Tree for   Frequent Itemset Mining, Open Source Data Mining Workshop on Frequent Pattern Mining Implementations 2005, Aug/2005

Takeaki Uno, Masashi Kiyomi, Hiroaki Arimura, "LCM ver.2: Efficient Mining Algorithms for Frequent/Closed/Maximal Itemsets," in Proceedings of IEEE ICDM'04 Workshop FIMI'04, 1/Nov/2004, http://sunsite.informatik.rwth-aachen.de/Publications/CEUR-WS//Vol-126/

Takeaki Uno and Tatsuya Asai, Hiroaki Arimura and Yuzo Uchida, "LCM: An Efficient Algorithm for Enumerating Frequent Closed Item Sets," Workshop on Frequent Itemset Mining Implementations (FIMI'03), http://sunsite.informatik.rwth-aachen.de/Publications/CEUR-WS//Vol-90/

Takeaki Uno,Tatsuya Asai,Yuzo Uchida, Hiroki Arimura, "An Efficient Algorithm for Enumerating Closed Patterns in Transaction Databases," Lecture Notes in Artificial Intelligence 3245 (Proceedings of Discovery Science 2004), 4/Oct/2004 
}
\author{
Takeaki Uno (uno@nii.jp) wrote the original implementation as a standalone command-line tool in C.

David duVerle (dave.duverle@aist.go.jp) re-packaged it for R.
}

\examples{
lcm(list("C", "-l", "3", "-w", "/path/to/a/weight-file", "/path/to/transaction-file", "/path/to/output/file"))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ lcm }
\keyword{ itemset }% __ONLY ONE__ keyword per line
