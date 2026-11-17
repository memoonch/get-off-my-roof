package com.whatthefawk.utils
{
   public class NumberUtil
   {
      
      public function NumberUtil()
      {
         super();
      }
      
      public static function addCommas(param1:String) : String
      {
         return param1.replace(/(\d)(?=(\d\d\d)+$)/g,"$1,");
      }
   }
}

