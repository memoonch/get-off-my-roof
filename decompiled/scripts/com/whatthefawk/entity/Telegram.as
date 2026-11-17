package com.whatthefawk.entity
{
   public class Telegram
   {
      
      public var senderID:String;
      
      public var msg:String;
      
      public var recieverID:String;
      
      public var dispatchTime:int;
      
      public var extraInfo:Object;
      
      public function Telegram(param1:int, param2:String, param3:String, param4:String, param5:Object)
      {
         super();
         this.senderID = param2;
         this.recieverID = param3;
         this.msg = param4;
         this.extraInfo = param5;
         this.dispatchTime = param1;
      }
   }
}

