package com.getoffmyroof.rewards
{
   import flash.utils.Dictionary;
   
   public class LevelRewards
   {
      
      public static const GOLD_STAR_MEDAL:int = 1;
      
      public static const GOLD_MEDAL:int = 2;
      
      public static const SILVER_MEDAL:int = 3;
      
      public static const BRONZE_MEDAL:int = 4;
      
      public static const NO_MEDAL:int = 5;
      
      public static const NORMAL_LEVEL:String = "normal_level";
      
      public static const SURVIVAL_LEVEL:String = "survival_level";
      
      public var killTypes:Dictionary;
      
      public var highCombo:int = 0;
      
      public var time:int = 0;
      
      public var kills:int = 0;
      
      public var playerHealth:int;
      
      public var levelType:String;
      
      public var levelID:String;
      
      public var points:int = 0;
      
      public var numDeaths:int = 0;
      
      public var medal:int;
      
      public var complete:Boolean = false;
      
      public var playerWetnaps:int;
      
      public function LevelRewards()
      {
         super();
         this.levelType = LevelRewards.NORMAL_LEVEL;
         this.killTypes = new Dictionary();
      }
      
      public function debugTrace() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.killTypes)
         {
         }
      }
      
      public function generateMedal() : void
      {
         var _loc1_:int = this.playerHealth + this.playerWetnaps;
         if(!this.complete)
         {
            this.medal = LevelRewards.NO_MEDAL;
         }
         else if(_loc1_ == 8)
         {
            this.medal = LevelRewards.GOLD_STAR_MEDAL;
         }
         else if(_loc1_ == 7 || _loc1_ == 6)
         {
            this.medal = LevelRewards.GOLD_MEDAL;
         }
         else if(_loc1_ == 5 || _loc1_ == 4)
         {
            this.medal = LevelRewards.SILVER_MEDAL;
         }
         else if(_loc1_ < 4 && _loc1_ > 0)
         {
            this.medal = LevelRewards.BRONZE_MEDAL;
         }
         else
         {
            this.medal = LevelRewards.NO_MEDAL;
         }
      }
   }
}

