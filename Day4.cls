Class aoc2018.Day4 Extends aoc2018.Base
{

// <advent of code URL>

Parameter InputFile = "Day4Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    //set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        #; set $LIST(inputList,*+1) = line
        #; w line,!
        set inputList(line)=""
    }
    // Sort Input
    set myKey = ""
    set key = $ORDER(inputList(""))
    while (key '= ""){
        set myKey = myKey_key_"$"
        set key = $ORDER(inputList(key))
    }
    set sortedInputList = $LISTFROMSTRING(myKey,"$")

    set currentGuard = ""
    set startTime = ""
    set sleepCount = ""
    set ptr=0
    while $LISTNEXT(sortedInputList,ptr,currentLine){
        set currentText = $P(currentLine," ",3,*)
        if $P(currentLine," ",3,3) = "Guard"{
            set currentGuard = $P(currentLine," ",4,4)
        }
        if $P(currentLine," ",3,3) = "falls"{
            set startTime = $E(currentLine,16,17)
        }
        if $P(currentLine," ",3,3) = "wakes"{
            set endTime = $E(currentLine,16,17)
            set sleepTime = endTime - startTime
            if $DATA(sleepCount(currentGuard)){
                set sleepCount(currentGuard) = sleepCount(currentGuard) + sleepTime
            }else{
                set sleepCount(currentGuard) = sleepTime
            }
        }
    }

    set highestSleepCount = 0
    set sleepiestGuard = ""

    set key = $ORDER(sleepCount(""))
    while (key '= ""){
        if sleepCount(key) > highestSleepCount{
            set highestSleepCount = sleepCount(key)
            set sleepiestGuard = key
        }
        set key = $ORDER(sleepCount(key))
    }

    set minuteTracker = ""
    set currentGuard = ""
    set startTime = ""
    set ptr=0
    while $LISTNEXT(sortedInputList,ptr,currentLine){
        set currentText = $P(currentLine," ",3,*)
        if $P(currentLine," ",3,3) = "Guard"{
            set currentGuard = $P(currentLine," ",4,4)
        }
        if $P(currentLine," ",3,3) = "falls"{
            set startTime = $E(currentLine,16,17)
        }
        if $P(currentLine," ",3,3) = "wakes"{
            set endTime = $E(currentLine,16,17)

            if currentGuard = sleepiestGuard{
                for i=startTime:1:endTime-1{
                    if $DATA(minuteTracker(i)){
                        set minuteTracker(i) = minuteTracker(i) + 1
                    }else{
                        set minuteTracker(i) = 1
                    }
                }
            }
        }
    }


    set sleepiestMinCount = "0"
    set sleepiestMin = ""
    set key = $ORDER(minuteTracker(""))
    while (key '= ""){
        if sleepiestMinCount < minuteTracker(key){
            set sleepiestMinCount = minuteTracker(key)
            set sleepiestMin = key
        }
        set key = $ORDER(minuteTracker(key))

    }

    w "Sleepiest Min: ",sleepiestMin,!
    w "Sleepiest Guard: ",sleepiestGuard,!

    set answer = sleepiestMin * $E(sleepiestGuard,2,*)
    w "Answer: ",answer

    return $$$OK
}

ClassMethod Run2(verbose = 0) As %Integer
{

   set stream=..GetInput(..#InputFile)

    //set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        #; set $LIST(inputList,*+1) = line
        #; w line,!
        set inputList(line)=""
    }
    // Sort Input
    set myKey = ""
    set key = $ORDER(inputList(""))
    while (key '= ""){
        set myKey = myKey_key_"$"
        set key = $ORDER(inputList(key))
    }
    set sortedInputList = $LISTFROMSTRING(myKey,"$")

    set guardList = ""

    set ptr=0
    while $LISTNEXT(sortedInputList,ptr,currentLine){
        w "HIT",!
        set currentText = $P(currentLine," ",3,*)
        if $P(currentLine," ",3,3) = "Guard"{
            set currentGuard = $P(currentLine," ",4,4)
            if $LISTFIND(guardList,currentGuard)=0{
                set $LIST(guardList,*+1) = currentGuard
            }
        }
    }

    w "Guards: ",$LISTTOSTRING(guardList),!

    set sleepiestGuard = ""
    set sleepiestMinute = ""
    set sleepiestMinuteCount = 0

    set ptr = 0
    while $LISTNEXT(guardList,ptr,currentListGuard){
        set minuteTracker = ""
        
        set ptr2 = 0
        while $LISTNEXT(sortedInputList,ptr2,currentLine){
            set currentText = $P(currentLine," ",3,*)
            if $P(currentLine," ",3,3) = "Guard"{
                set currentGuard = $P(currentLine," ",4,4)
            }

            if currentGuard = currentListGuard{
                if $P(currentLine," ",3,3) = "falls"{
                    set startTime = $E(currentLine,16,17)
                }
                if $P(currentLine," ",3,3) = "wakes"{
                    set endTime = $E(currentLine,16,17)
                    for i=startTime:1:endTime-1{
                        if $DATA(minuteTracker(i)){
                            set minuteTracker(i) = minuteTracker(i) + 1
                        }else{
                            set minuteTracker(i) = 1
                        }
                    }
                }
            }

            set key = $ORDER(minuteTracker(""))
            while (key '= ""){
                if sleepiestMinuteCount < minuteTracker(key){
                    set sleepiestMinuteCount = minuteTracker(key)
                    set sleepiestMinute = key
                    set sleepiestGuard = currentListGuard

                }
                set key = $ORDER(minuteTracker(key))
            }
        }
    }

    w "sleepiest Minute: ",sleepiestMinute,!
    w "sleepiest Minute Count: ",sleepiestMinuteCount,!
    w "sleepiest Guard: ",sleepiestGuard,!

    set answer = sleepiestMinute * $E(sleepiestGuard,2,*)
    w "Answer: ",answer,!

    //w $LISTFROMSTRING(sortedInputList)
}

}
