$DoubleIPAPairing = New-Object -TypeName psobject -Property @{

'իւ'='ʏ';
'էօ'='œ';
'ու'='u';

}


$SingularIPAMap = New-Object -TypeName psobject -Property @{

'ի' ='i';
'իւ'='ʏ';
'է'='ɛ';
'ե'='ɛ'
'էօ'='œ';
'ը'='ə';
'ա'='ɑ';
'ու'='u';
'ո'='o';
'օ'='o';

}



[char[]]$String = ('իիւուէեէօըոօա')

$count1 =0
$count2 =1

Clear-Variable array
$Array = 
foreach($character in $String){
$letter =  $String[$count1] + $String[$count2]

if($DoubleIPAPairing -notmatch $letter){
$Map = ($SingularIPAMap | Select-Object -ExpandProperty $character)
$letter = $character
}else{
$Map = ($DoubleIPAPairing | Select-Object -ExpandProperty $letter)
}

$StrungLetter = $letter | out-string
$StrungLetter.replace("$letter","$Map")

$count1++
$count2++


}

$IPAWord = $array.Split('',[System.StringSplitOptions]::RemoveEmptyEntries) -join ""
$IPAWord 