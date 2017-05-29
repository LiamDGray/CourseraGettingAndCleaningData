# CodeBook.md:

a code book that describes the variables, the data, and any transformations or work that performed to clean up the data

The final data set is in “ops,” a data frame.
It has 81 columns, whose labels are descriptive:
- 79 columns of means and standard deviations from the original data set
- activity (character data)
- subject (numbers 30 and below)

There is one row per unique combination of (activity, subject).
That row is the mean of the other variables for that combination.

Transformations performed to clean up the data are fully specified in
comments in run_analysis.R, but to comment in a little more detail:

The tables from test and training are concatenated using bind.

The 79 variables with -mean or -std in their names are selected using grepl.

The activity is looked up using apply to index into the names.

The activity and subject columns are bound with the other 79 variables with cbind.
