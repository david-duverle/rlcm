\name{rlcm-package}
\alias{lcm-package}
\alias{rlcm}
\docType{package}
\title{
Frequent itemset mining tool.
}
\description{
Let I be a set of items. An itemset is a subset of I. Let D be a transaction 
database such that each record (called transaction) is an itemset. Frequency
of an itemset is the number of transactions including the itemset. For a
given number t (called support), an itemset is said to be frequent
if its frequency is no less than t. A frequent itemset is called maximal
if it is included in no other frequent itemset, and called closed if it
is included in no other itemset of the same frequency. The task of
this program, LCM, is to enumerate (output, or count) all frequent
itemsets, all maximal frequent itemsets, or all frequent closed itemsets
in a given transaction database for given a support.
}
\details{
\tabular{ll}{
Package: \tab rlcm\cr
Type: \tab Package\cr
Version: \tab 0.1\cr
Date: \tab 2014-03-20\cr
License: \tab GPL\cr
}
See documentation for the package's single function: lcm.

Check original project's homepage for details: http://research.nii.ac.jp/~uno/index.html
}
\author{
Takeaki Uno (uno@nii.jp) wrote the original implementation as a standalone command-line tool in C.

David duVerle (dave.duverle@aist.go.jp) re-packaged it for R.

###############################
####    Acknowledgments    #### 
###############################

We thank Ken Satoh of the National Institute of Informatics Japan,
Hiroki Arimura of Hokkaido University for their contribution to the
research, to Tatsuya Asai, Yuzo Uchida, Masashi Kiyomi for their
contribution for computational experiments and coding. We would also like
to present our sincere thanks to Bart Goethal, one of the organizers of
FIMI (Frequent Itemset Mining Implementation) for his organizing the 
workshop to which the first version of LCM was submitted, which was the
start of our research.

A part of the research of LCM is supported by joint-research fund of
National Institute of Informatics Japan, and Grant-in-aid from the
Ministry of Education, Science, Sport and Culture of Japan
(Monbu-Kagaku-Sho).

We also thank to Ilpo Lyytinen of University of Helsinki, Sancho,
R. Arun Kumar, Sethu Institue of Technology, Pulloor, Tamilnadu, Koji Tsuda
of Advanced Industrial Science and Technology, JAPAN, Yukinobu Hamuro of
Kwansei gakuin University, JAPAN, Hiroyuki Morita of Osaka Prefecture
University, JAPAN, Yasuyuki Shirai of Mitsubishi Research Institute,
Nicolas Pasquier of Universite' de Nice Sophia-Antipolis, Giuseppe Rizzo,
Payas Gupta, and Chen Haifen for their bug reports.

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
\keyword{ lcm, itemset }
