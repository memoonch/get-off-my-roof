package com.whatthefawk.utils
{
   public class StringUtil
   {
      
      public function StringUtil()
      {
         super();
      }
      
      public static function stripHTML(param1:String) : String
      {
         return param1.replace(/<.*?>/g,"");
      }
      
      public static function stripSpaces(param1:String) : String
      {
         return param1.replace(/\s+/g,"");
      }
      
      public static function camelCase(param1:String, param2:String = " ") : String
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc3_:Array = param1.split(param2);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc6_ = String(_loc3_[_loc4_]).toLowerCase();
            _loc7_ = _loc6_.substr(0,1).toUpperCase();
            _loc8_ = _loc6_.substr(1);
            _loc3_[_loc4_] = _loc7_ + _loc8_;
            _loc4_++;
         }
         return _loc3_.join(param2);
      }
   }
}

