Getting & Cleaning Data: Course Project Codebook
========================================================
DATA DICTIONARY - KLLONTOP RUN_ANALYSIS.R CODE
----------------------------------------------

Subject
        A volunteer who wore a Samsung device from which data was measured.
        1       7       13      19      25
        2       8       14      20      26
        3       9       15      21      27
        4       10      16      22      28
        5       11      17      23      29
        6       12      18      24      30
        
Activity_ID
        An ID corresponding to an activity (included for ease in subsetting)
        1 .Walking
        2 .Walking Up Stairs
        3 .Walking Down Stairs
        4 .Sitting
        5 .Standing
        6 .Laying
        
Activity
        An activity performed by the volunteer subject
        1 .Walking
        2 .Walking Up Stairs
        3 .Walking Down Stairs
        4 .Sitting
        5 .Standing
        6 .Laying

Domain 
        The domain that each measurement was taken with respect to
        1 .Time
        2 .Frequency
        
Acceleration Type
        The type of acceleration measured
        1 .Body
        2 .Gravity
        
Signal
        The sensor signal received
        1 .Acc
        2 .Gyro

Jerk
        Whether or not a Jerk Signal was received
        1 .Yes
        2 .No
        
Mag
        Whether the measurement is the magnitude of a 3D-signal
        1 .Mag
        2 .No
        
Function
        Whether the measurement is a mean or standard deviation (Note: Measurements such as meanFreq() which include the word "mean" are excluded because they are not relevant to measurements taken from a subject's motion and only relate to the frequency of the signals received)
        1 .Mean
        2 .Std

Direction
        The axial-directional components of the subject's motion; Value is 4 .None if neither X, Y, nor Z were specified
        1 .X
        2 .Y
        3 .Z 
        4 .None 
        
Measurement
        The value of the measurement recorded
