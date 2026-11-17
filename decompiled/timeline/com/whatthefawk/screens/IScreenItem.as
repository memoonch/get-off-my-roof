package com.whatthefawk.screens
{
   import flash.events.IEventDispatcher;
   
   public interface IScreenItem extends IEventDispatcher
   {
      
      function getChildScreen(param1:String) : IScreenItem;
      
      function removeChildScreen(param1:String) : void;
      
      function get currentScreen() : IScreenItem;
      
      function get parentScreen() : IScreenItem;
      
      function addChildScreen(param1:String, param2:Class) : void;
      
      function update(param1:int) : void;
      
      function setScreen(param1:Class) : void;
      
      function dispose() : void;
   }
}

