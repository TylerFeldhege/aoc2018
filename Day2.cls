Class aoc2018.Day2 Extends aoc2018.Base
{

// https://adventofcode.com/2018/day/2

Parameter InputFile = "Day2Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(inputList,*+1) = line
    }
    

    set twoCount = 0
    set threeCount = 0

    set ptr=0
    while $LISTNEXT(inputList,ptr,value){
        if ..ContainsX(value,"2"){
            set twoCount = twoCount + 1
        }

        if ..ContainsX(value,"3"){
            set threeCount = threeCount + 1
        }
    }

    set result = twoCount*threeCount

    return $$$OK
}

ClassMethod ContainsX(stringToCheck As %String, numToCheck As %String) As %String
{
    for i=1:1:$LENGTH(stringToCheck){
        set currentChar = $E(stringToCheck,i,i)
        if $LENGTH($ZSTRIP(stringToCheck,"*E",,currentChar)) = numToCheck{
            return "1"
        }
    }
    return "0"
}

ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(inputList,*+1) = line
    }
    
    set diff1 = ""
    set diff2 = ""

    set ptr = 0
    while $LISTNEXT(inputList,ptr,currentLine1){
        set ptr2 = 0
        while $LISTNEXT(inputList,ptr2,currentLine2){
            if ..CheckDiffCount(currentLine1,currentLine2) = 1{
                set diff1 = currentLine1
                set diff2 = currentLine2
            }
        }

    }

    set cleanString = ""
    for i=1:1:$LENGTH(diff1){
        if $E(diff1,i,i) = $E(diff2,i,i){
            set cleanString = cleanString_$E(diff1,i,i)
        }
    }

    w "answer: ",cleanString,!

    return $$$OK
}

ClassMethod CheckDiffCount(line1 As %String, line2 As %String) As %String
{
    set diffCount = 0
    for i=1:1:$LENGTH(line1){
        if $E(line1,i,i) '= $E(line2,i,i){
            set diffCount = diffCount + 1
        }
    }

    return diffCount
}

}
