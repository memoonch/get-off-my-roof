package com.getoffmyroof.shop
{
   import flash.events.Event;
   
   public class ShopEvent extends Event
   {
      
      public static const BUY:String = "buy";
      
      public var data:Object;
      
      public function ShopEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
   }
}

