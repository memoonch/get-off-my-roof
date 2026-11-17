package com.whatthefawk.entity
{
   import flash.events.IEventDispatcher;
   
   public interface IGameObject extends IEventDispatcher
   {
      
      function update(param1:int) : void;
      
      function dispose() : void;
   }
}

