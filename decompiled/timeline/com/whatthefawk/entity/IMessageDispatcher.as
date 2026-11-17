package com.whatthefawk.entity
{
   public interface IMessageDispatcher
   {
      
      function dispatchMessage(param1:int, param2:String, param3:String, param4:String, param5:Object = null) : void;
      
      function setGameWorld(param1:GameWorld) : void;
   }
}

