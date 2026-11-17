package com.whatthefawk.utils
{
   public class Params
   {
      
      public static var THROW_ERROR:Boolean = false;
      
      public function Params(param1:Object = null)
      {
         super();
         this.applyParams(param1);
      }
      
      public function applyParams(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Error = null;
         if(!param1)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            if(_loc2_ in this)
            {
               this[_loc2_] = param1[_loc2_];
            }
            else
            {
               _loc3_ = new Error("Property \"" + _loc2_ + "\" does not exist in " + this);
               if(THROW_ERROR)
               {
                  throw _loc3_;
               }
            }
         }
      }
   }
}

