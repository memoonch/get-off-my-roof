package com.getoffmyroof.save
{
   public interface ISaveLoad
   {
      
      function get id() : String;
      
      function clear() : void;
      
      function save(param1:IValueObject = null) : void;
      
      function load() : IValueObject;
   }
}

