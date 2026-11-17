package com.getoffmyroof.rewards.achievements
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.rewards.LevelRewards;
   import com.getoffmyroof.rewards.PlayerRewards;
   import com.whatthefawk.rewards.achievements.AAchievement;
   import flash.utils.Dictionary;
   
   public class MedalOnLevelsAchievement extends AAchievement
   {
      
      protected var _medalMap:Array;
      
      protected var _medal:int;
      
      protected var _playerController:PlayerController;
      
      protected var _levels:Array;
      
      public function MedalOnLevelsAchievement(param1:String, param2:String, param3:String, param4:int, param5:Array = null)
      {
         super();
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         _id = param1;
         _name = param2;
         _description = param3;
         this._medal = param4;
         this._medalMap = ["","Gold Star Medal","Gold Medal","Silver Medal","Bronze Medal","No Medal"];
         this._levels = param5;
      }
      
      override public function check() : Boolean
      {
         var _loc4_:LevelRewards = null;
         var _loc1_:PlayerRewards = this._playerController.rewards;
         var _loc2_:Dictionary = _loc1_.levelRewards;
         var _loc3_:int = int(this._levels.length);
         while(--_loc3_ > -1)
         {
            _loc4_ = _loc1_.getLevelRewards(this._levels[_loc3_]);
            if(!_loc4_)
            {
               return false;
            }
            if(_loc4_.medal > this._medal)
            {
               return false;
            }
         }
         _isComplete = true;
         return _isComplete;
      }
   }
}

