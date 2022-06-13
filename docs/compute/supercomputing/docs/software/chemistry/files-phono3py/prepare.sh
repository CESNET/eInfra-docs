#!/bin/bash
P=`pwd`

# number of displacements
poc=9

        for i in `seq 1 $poc `;
        do
        cd $P
        mkdir disp-0000"$i"
        cd disp-0000"$i"   
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-0000"$i" POSCAR
                echo $i
        done 

poc=99

        for i in `seq 10 $poc `;
        do
        cd $P
        mkdir disp-000"$i"
        cd disp-000"$i"
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-000"$i" POSCAR
                echo $i
        done
poc=111

        for i in `seq 100 $poc `;
        do
        cd $P
        mkdir disp-00"$i"
        cd disp-00"$i"
        cp ../KPOINTS .
        cp ../INCAR .
        cp ../POTCAR .
        cp ../POSCAR-00"$i" POSCAR
                echo $i
        done
