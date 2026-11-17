package com.whatthefawk.math
{
   public class MathUtils
   {
      
      public static const RAD_TO_DEG:Number = 180 / Math.PI;
      
      public static const DEG_TO_RAD:Number = Math.PI / 180;
      
      public function MathUtils()
      {
         super();
      }
      
      public static function randomRange(param1:int, param2:int) : int
      {
         return param1 + int(Math.random() * (param2 - param1 + 1));
      }
   }
}

