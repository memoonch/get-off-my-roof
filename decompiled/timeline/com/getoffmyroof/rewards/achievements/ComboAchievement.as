package com.getoffmyroof.rewards.achievements
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.whatthefawk.rewards.achievements.AAchievement;
   
   public class ComboAchievement extends AAchievement
   {
      
      protected var _numCombo:int;
      
      protected var _playerController:PlayerController;
      
      protected var _rewardSystem:RewardSystem;
      
      public function ComboAchievement(param1:String, param2:String, param3:int)
      {
         super();
         this._rewardSystem = GameComponents.instance.getComponent("RewardSystem");
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         _id = param1;
         _name = param2;
         _description = "Get a " + param3 + " hit combo!";
         this._numCombo = param3;
      }
      
      override public function check() : Boolean
      {
         var _loc1_:int = this._playerController.rewards.highCombo;
         var _loc2_:int = this._rewardSystem.currentCombo;
         if(_loc1_ >= this._numCombo)
         {
            _isComplete = true;
         }
         if(_loc2_ >= this._numCombo)
         {
            _isComplete = true;
         }
         return _isComplete;
      }
   }
}

