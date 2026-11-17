package com.getoffmyroof.save
{
   public interface ISaveable
   {
      
      function loadValueObject(param1:IValueObject) : void;
      
      function getValueObject() : IValueObject;
   }
}

