package com.getoffmyroof.rewards
{
   import com.getoffmyroof.engine.GameComponents;
   import flash.utils.Dictionary;
   import fog.as3.FogDevAPI;
   
   public class PlayerRewards
   {
      
      public var levelRewards:Dictionary;
      
      public var highComboLevelID:String;
      
      public var totalPoints:int = 0;
      
      public var highKillsLevelID:String;
      
      public var highKills:int = 0;
      
      public var highCombo:int = 0;
      
      public var highPoints:int = 0;
      
      public var totalKills:int = 0;
      
      public var lastLevelRewards:LevelRewards;
      
      public var highPointsLevelID:String;
      
      public var killTypes:Dictionary;
      
      public function PlayerRewards()
      {
         super();
         this.killTypes = new Dictionary();
         this.levelRewards = new Dictionary();
      }
      
      public function getLevelRewards(param1:String) : LevelRewards
      {
         if(this.levelRewards[param1] == null)
         {
            return null;
         }
         return this.levelRewards[param1];
      }
      
      public function usePoints(param1:int) : void
      {
         this.totalPoints -= param1;
      }
      
      public function hasPoints(param1:int) : Boolean
      {
         return this.totalPoints >= param1 ? true : false;
      }
      
      public function updateLevelRewards(param1:LevelRewards) : void
      {
         var _loc2_:LevelRewards = null;
         this.lastLevelRewards = param1;
         if(this.levelRewards[param1.levelID] == null)
         {
            if(!param1.complete)
            {
               ++param1.numDeaths;
            }
            this.levelRewards[param1.levelID] = param1;
         }
         else
         {
            _loc2_ = this.levelRewards[param1.levelID];
            if(param1.levelType == LevelRewards.NORMAL_LEVEL)
            {
               _loc2_.time = Math.min(_loc2_.time,param1.time);
            }
            _loc2_.kills = Math.max(_loc2_.kills,param1.kills);
            _loc2_.points = Math.max(_loc2_.points,param1.points);
            _loc2_.highCombo = Math.max(_loc2_.highCombo,param1.highCombo);
            _loc2_.medal = Math.min(_loc2_.medal,param1.medal);
            _loc2_.complete = _loc2_.complete ? true : param1.complete;
            if(!_loc2_.complete)
            {
               ++_loc2_.numDeaths;
            }
         }
      }
      
      public function updateRewards(param1:LevelRewards) : void
      {
         var _loc2_:FogDevAPI = null;
         param1.debugTrace();
         this.totalKills += param1.kills;
         this.totalPoints += param1.points;
         if(param1.kills > this.highKills)
         {
            this.highKills = param1.kills;
            this.highKillsLevelID = param1.levelID;
         }
         if(param1.highCombo > this.highCombo)
         {
            this.highCombo = param1.highCombo;
            this.highComboLevelID = param1.levelID;
         }
         if(param1.points > this.highPoints)
         {
            this.highPoints = param1.points;
            this.highPointsLevelID = param1.levelID;
            _loc2_ = GameComponents.instance.getComponent("FogAPI");
            _loc2_.Tracking.LibraryCall("ScoresUpdate",{"score":this.highPoints});
         }
         this.updateKillTypes(param1.killTypes);
         this.updateLevelRewards(param1);
         this.debugTrace();
      }
      
      private function updateKillTypes(param1:Dictionary) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in param1)
         {
            if(this.killTypes[_loc2_] == null)
            {
               this.killTypes[_loc2_] = param1[_loc2_];
            }
            else
            {
               this.killTypes[_loc2_] += param1[_loc2_];
            }
         }
      }
      
      public function debugTrace() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.killTypes)
         {
         }
      }
   }
}

