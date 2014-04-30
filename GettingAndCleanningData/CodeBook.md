# CodeBook

## Principal Fields

- Subjects: Subjects/Participants with an ID.
- Activities: Activity performed by the subject.

## Merging training and test sets to create one data set

### X_data

It is the result of merge `train/X_train.txt` with `est/X_test.txt`. Containing the 541 columns of raw data.

### Y_data

It is the result of merge `train/Y_train.txt` with `test/Y_test.txt`. Containing the id of the activity.

### subject_data

It is the result of merge `train/subject_train.txt` with `test/subject_test.txt`. Containing the id of the subject.
