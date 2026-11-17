package com.getoffmyroof.save
{
   public class LevelVO implements IValueObject
   {
      
      public var isComplete:Boolean;
      
      public var highPoints:int;
      
      public var highCombo:int;
      
      public var bestTime:int;
      
      public var highKills:int;
      
      public var numDeaths:int;
      
      public var medal:int;
      
      public var levelID:String;
      
      public function LevelVO()
      {
         super();
      }
   }
}

