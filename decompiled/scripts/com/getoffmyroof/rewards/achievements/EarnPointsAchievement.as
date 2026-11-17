package com.getoffmyroof.rewards.achievements
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.whatthefawk.rewards.achievements.AAchievement;
   
   public class EarnPointsAchievement extends AAchievement
   {
      
      protected var _numPoints:int;
      
      protected var _playerController:PlayerController;
      
      protected var _rewardSystem:RewardSystem;
      
      public function EarnPointsAchievement(param1:String, param2:String, param3:int)
      {
         super();
         this._rewardSystem = GameComponents.instance.getComponent("RewardSystem");
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         _id = param1;
         _name = param2;
         _description = "Earn " + param3 + " total points!";
         this._numPoints = param3;
      }
      
      override public function check() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = this._playerController.rewards.totalPoints;
         if(!this._rewardSystem.isLocked)
         {
            _loc2_ = this._rewardSystem.points;
            _loc1_ += _loc2_;
         }
         if(_loc1_ >= this._numPoints)
         {
            _isComplete = true;
         }
         return _isComplete;
      }
   }
}

