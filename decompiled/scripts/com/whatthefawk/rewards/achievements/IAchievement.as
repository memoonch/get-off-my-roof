package com.whatthefawk.rewards.achievements
{
   public interface IAchievement
   {
      
      function get id() : String;
      
      function get isComplete() : Boolean;
      
      function forceComplete() : void;
      
      function check() : Boolean;
      
      function get name() : String;
      
      function get description() : String;
   }
}

