package com.getoffmyroof.rewards.achievements
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.rewards.LevelRewards;
   import com.whatthefawk.rewards.achievements.AAchievement;
   
   public class CompleteLevelAchievement extends AAchievement
   {
      
      protected var _levelNum:int;
      
      protected var _levelID:String;
      
      protected var _playerController:PlayerController;
      
      public function CompleteLevelAchievement(param1:String, param2:String, param3:String, param4:int)
      {
         super();
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         _id = param1;
         _name = param2;
         _description = "Complete Day " + param4 + "!";
         this._levelID = param3;
         this._levelNum = param4;
      }
      
      override public function check() : Boolean
      {
         var _loc1_:LevelRewards = this._playerController.rewards.getLevelRewards(this._levelID);
         if(_loc1_)
         {
            if(_loc1_.complete)
            {
               _isComplete = true;
            }
         }
         return _isComplete;
      }
   }
}

