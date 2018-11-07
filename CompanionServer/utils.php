<?php

function getRequiredXpForLevel($level){
  return ($level - 1) * 50;
}

function getLevelFromXP($xp){
  $level = 1;
  $totalReqXp = getRequiredXpForLevel($level);

  while ($totalReqXp <= $xp){
      $level++;
      $totalReqXp += getRequiredXpForLevel($level);
  }
  return $level - 1;
}

function getTotalRequiredXpForLevel($level){
   $xp = 0;
   for ($i = 1; $i <= $level; $i++){
       $xp += getRequiredXpForLevel($i);
   }
   return $xp;
}

?>
