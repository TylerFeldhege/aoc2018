Class aoc2018.DayTemplate Extends aoc2018.Base
{

// <advent of code URL>

Parameter InputFile = "Day1Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(inputList,*+1) = line

        w line,!
    }
    
    return $$$OK
}

}
