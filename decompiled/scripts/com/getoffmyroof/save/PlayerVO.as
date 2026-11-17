package com.getoffmyroof.save
{
   import flash.utils.Dictionary;
   
   public class PlayerVO implements IValueObject
   {
      
      public var interfaceVolume:Number;
      
      public var totalPoints:int;
      
      public var soundVolume:Number;
      
      public var hasSeenTutorial:Boolean;
      
      public var highKillsLevelID:String;
      
      public var highCombo:int;
      
      public var equipment:Dictionary = new Dictionary();
      
      public var highKills:int;
      
      public var inventory:Array = [];
      
      public var globalVolume:Number;
      
      public var isMuted:Boolean;
      
      public var achievements:Array = [];
      
      public var highPoints:int;
      
      public var musicVolume:Number;
      
      public var levels:Array = [];
      
      public var totalKills:int;
      
      public var highComboLevelID:String;
      
      public var highPointsLevelID:String;
      
      public var killTypes:Dictionary = new Dictionary();
      
      public var globalVolumeBeforeMute:Number;
      
      public function PlayerVO()
      {
         super();
      }
   }
}

