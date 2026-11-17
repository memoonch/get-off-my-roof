package com.getoffmyroof.rewards.achievements
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.whatthefawk.rewards.achievements.AAchievement;
   
   public class EliminatePigeonAchievement extends AAchievement
   {
      
      protected var _playerController:PlayerController;
      
      protected var _numPigeons:int;
      
      protected var _rewardSystem:RewardSystem;
      
      public function EliminatePigeonAchievement(param1:String, param2:String, param3:int)
      {
         super();
         this._rewardSystem = GameComponents.instance.getComponent("RewardSystem");
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         _id = param1;
         _name = param2;
         _description = "Eliminate " + param3 + " pigeons!";
         this._numPigeons = param3;
      }
      
      override public function check() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = this._playerController.rewards.totalKills;
         if(!this._rewardSystem.isLocked)
         {
            _loc2_ = this._rewardSystem.kills;
            _loc1_ += _loc2_;
         }
         if(_loc1_ > this._numPigeons)
         {
            _isComplete = true;
         }
         return _isComplete;
      }
   }
}

