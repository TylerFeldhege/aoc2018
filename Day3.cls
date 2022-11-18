Class aoc2018.Day3 Extends aoc2018.Base
{

// https://adventofcode.com/2018/day/3

Parameter InputFile = "Day3Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(inputList,*+1) = line

    }

    for i=1:1:1000{
        for j=1:1:1000{
            set grid(i,j)=0
        }
    }

    set ptr=0
    while $LISTNEXT(inputList,ptr,currentLine){
        set points = ..getPointsUsed(currentLine)

        set ptr2=0
        while $LISTNEXT(points,ptr2,currentPoint){
            set x = $P(currentPoint,",",1,1)
            set y = $P(currentPoint,",",2,2)
            
            set grid(x,y) = grid(x,y) + 1
        }
    }

    set count = 0

    for i=1:1:1000{
        for j=1:1:1000{
            if grid(i,j)>1{
                set count = count + 1
            }
        }
    }

    w "Result: ",count,!

    return $$$OK
}

ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set inputList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(inputList,*+1) = line

    }

    for i=1:1:1000{
        for j=1:1:1000{
            set grid(i,j)=0
        }
    }

    set ptr=0
    while $LISTNEXT(inputList,ptr,currentLine){
        set points = ..getPointsUsed(currentLine)

        set ptr2=0
        while $LISTNEXT(points,ptr2,currentPoint){
            set x = $P(currentPoint,",",1,1)
            set y = $P(currentPoint,",",2,2)
            
            set grid(x,y) = grid(x,y) + 1
        }
    }

    while $LISTNEXT(inputList,ptr,currentLine){
        set points = ..getPointsUsed(currentLine)

        set clean = 1

        set ptr2=0
        while $LISTNEXT(points,ptr2,currentPoint){
            set x = $P(currentPoint,",",1,1)
            set y = $P(currentPoint,",",2,2)
            if grid(x,y) '= 1{
                set clean = 0
            }
        }
        if clean=1{
            set result = $P(currentLine," ",1,1)
        }            

    }

    w "Result: ",result,!

    return $$$OK
}

ClassMethod getPointsUsed(input As %String) As %String
{

    set coord = $P(input,"@",2,2)
    set coord = $P(coord,":",1,1)
    set coord = $ZSTRIP(coord,"*W")
    set lengths = $ZSTRIP($P(input,":",2),"*W")


    set x = $P(coord,",",1,1)
    set y = $P(coord,",",2,2)
    set xlength = $PIECE(lengths,"x",1,1)
    set ylength = $PIECE(lengths,"x",2,2)

    set pointList = ""
    set xStart = x
    set xEnd = x+xlength-1
    set yStart = y
    set yEnd = y+ylength-1

    set currentX = xStart
    while currentX <= xEnd{
        set currentX = currentX + 1
        set currentY = yStart
        while currentY <= yEnd{
            set currentY = currentY+1
            set $LIST(pointList,*+1)=currentX_","_currentY
        }
    }

    return pointList
}

}
