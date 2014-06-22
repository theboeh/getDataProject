Get Data Project
================

This is code for the Coursera course Getting and Cleaning Data.

run_analysis.R
--------------

This script creates a cleaned version of the Human Activity Recognition Using Smartphones Dataset.

The first thing it does is to download the data from the internet if not already present.

From there it reads in the features and activities data into character vectors.

Then, starting with the test data it reads in the X\_test.txt using the features vector as the column name. Then, y\_test.txt is read and converted into a factor vector that is added with the data from X\_test.txt.

This is then repeated for the training data. Once the two data sets are processed they are combined into a single dataset.

From that large data set the columns for the activies, means and standard deviations are selected and written out to a csv file.
