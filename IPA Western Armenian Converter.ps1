  Function Start-IPAConversion {
  param(
    [String]$word
  )


  $TripleIPAPairing = New-Object -TypeName psobject -Property @{
    'յու'= 'ju'

  }


  $DoubleIPAPairing = New-Object -TypeName psobject -Property @{

    'իւ' ='ʏ';
    'էօ' ='œ';
    'ու' ='u';
    'եա'='jɑ'
    'եօ' = 'jo'
    'յի'='ji'
    'այ'='aj'
    'էյ'='ej'
    'իյ'='iə'
    'ոյ'='ej'

  }


  $SingularIPAMap = New-Object -TypeName psobject -Property @{

    'ի' ='i';
    'է'='ɛ';
    'ե'='ɛ'
    'ը'='ə';
    'ա'='ɑ';
    'ո'='o';
    'օ'='o';
    'հ'='h'
    'մ'='m'
    'բ'='pʰ'
    'փ'='pʰ'
    'պ'='b'
    'ֆ'='f'
    'վ'='v'
    'ւ'='v'
    'ն'='n'
    'յ'='j'
    'լ'='l'
    'ր'='ɾ'
    'կ'='ɡ'
    'թ'='tʰ'
    'ս'='s'
    'ք'='kʰ'
    'դ'='tʰ'
    'շ'='ʃ'
    'տ'='d'
    'ծ'='dz'
    'ձ'='tsʰ'
    'գ'='kʰ'
    'ժ'='ʒ'
    'չ'='tʃʰ'
    'ջ'='tʃʰ'
    'զ'='z'
    'ց'='tsʰ'
    'ճ'='dʒ'
    'խ'='χ'
    'ղ'='ʁ'
    'ռ'='ɾ'
  }
  $SpecialCharRegex = '(\/|,|-|\\|\.|։)'
  [char[]]$String = $Word

  $count1 =0
  $count2 =1
  $count3 =2
  $CharacterCount = 0

  if($Array -ne $null){
    Clear-Variable array
  }

  $Array = 
  foreach($character in $String){

    if($String[$count1] -match $SpecialCharRegex){
      $String[$count1] | Out-String
    }elseif($String[$CharacterCount] -eq " "){
      '/'
    }
    else{
      $letter =  $String[$count1] + $String[$count2]
      $threeletters = $String[$count1] + $String[$count2] + $String[$count3]
      if($TripleIPAPairing.PsObject.Properties.Name -contains $threeletters){
        $Map = ($TripleIPAPairing | Select-Object -ExpandProperty $threeletters)
        $letter = $threeletters
        $CharacterCount++
        $count1++
        $count2++
      }
      elseif($DoubleIPAPairing.PsObject.Properties.Name -notcontains $letter){
        $Map = ($SingularIPAMap | Select-Object -ExpandProperty $String[$CharacterCount])
        $letter = $String[$CharacterCount]
      }
      else
      {
        $Map = ($DoubleIPAPairing | Select-Object -ExpandProperty $letter)
        $CharacterCount++
      }
      if($letter -ne $null -AND($map -ne $null)){
        $StrungLetter = $letter | out-string
        $StrungLetter.replace("$letter","$Map")
      }
    }
    $count1++
    $count2++
    $count3++
    $CharacterCount++

  }

  $IPAWord = $array.Split('',[System.StringSplitOptions]::RemoveEmptyEntries) -join ""
  $IPAWord 
}
