#!/bin/bash
P=`pwd`

# number of displacements
poc=9

        for i in `seq 1 $poc `;
        do
        cd $P
        cd disp-0000"$i"   
        cp ../run.sh .
        qsub run.sh
                echo $i
        done 

poc=99

        for i in `seq 10 $poc `;
        do
        cd $P
        cd disp-000"$i"
        cp ../run.sh .
        qsub run.sh
                echo $i
        done
poc=111

        for i in `seq 100 $poc `;
        do
        cd $P
        cd disp-00"$i"
        cp ../run.sh .
        qsub run.sh
                echo $i
        done
