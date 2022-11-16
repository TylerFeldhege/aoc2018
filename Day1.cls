Class aoc2018.Day1 Extends aoc2018.Base
{

// https://adventofcode.com/2018/day/1

Parameter InputFile = "Day1Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(inputList,*+1) = line
        //w line,!
    }

    set frequency = 0

    set ptr=0
    while $LISTNEXT(inputList,ptr,value){
        set operator = $E(value,1,1)
        set number = $E(value,2,*)
        if operator = "+"{
            set frequency = frequency + number
        }
        if operator = "-"{
            set frequency = frequency - number
        }
    }



    w frequency,!

    return $$$OK
}

ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(inputList,*+1) = line
        //w line,!
    }

    set frequency = 0
    set $LIST(freqList,*+1) = 0
    set doublefreq = ""

    while doublefreq = ""{
        set ptr=0
        while (($LISTNEXT(inputList,ptr,value)) && (doublefreq = "")){
            set operator = $E(value,1,1)
            set number = $E(value,2,*)
            if operator = "+"{
                set frequency = frequency + number
            }
            if operator = "-"{
                set frequency = frequency - number
            }

            if $LISTFIND(freqList,frequency) '= 0{
                set doublefreq = frequency
            }
            
            set $LIST(freqList,*+1) = frequency
            
        }
    }


    w doublefreq,!

    return $$$OK
}

}
