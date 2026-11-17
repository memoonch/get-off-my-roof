package com.whatthefawk.utils
{
   public class TimeUtil
   {
      
      public function TimeUtil()
      {
         super();
      }
      
      public static function formatTime(param1:Number) : String
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = param1 / (60 * 60);
         _loc2_ = _loc3_ - int(_loc3_);
         _loc3_ = int(_loc3_);
         var _loc4_:* = _loc2_ * 60;
         _loc2_ = _loc4_ - int(_loc4_);
         _loc4_ = int(_loc4_);
         var _loc5_:* = _loc2_ * 60;
         _loc5_ = Math.round(_loc5_);
         var _loc6_:String = _loc3_ < 10 ? "0" + _loc3_ : "" + _loc3_;
         var _loc7_:String = _loc4_ < 10 ? "0" + _loc4_ : "" + _loc4_;
         var _loc8_:String = _loc5_ < 10 ? "0" + _loc5_ : "" + _loc5_;
         if(param1 < 0 || isNaN(param1))
         {
            return "00:00";
         }
         if(_loc3_ > 0)
         {
            return _loc6_ + ":" + _loc7_ + ":" + _loc8_;
         }
         return _loc7_ + ":" + _loc8_;
      }
   }
}

