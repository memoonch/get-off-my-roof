package com.getoffmyroof.rewards.achievements
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.whatthefawk.rewards.achievements.AAchievement;
   import flash.utils.Dictionary;
   
   public class EliminatePigeonTypesAchievement extends AAchievement
   {
      
      protected var _num:int;
      
      protected var _types:Array;
      
      protected var _playerController:PlayerController;
      
      protected var _rewardSystem:RewardSystem;
      
      public function EliminatePigeonTypesAchievement(param1:String, param2:String, param3:Array, param4:int)
      {
         super();
         this._rewardSystem = GameComponents.instance.getComponent("RewardSystem");
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         _id = param1;
         _name = param2;
         _description = "Eliminate " + param4 + " of each regular pigeon!";
         this._types = param3;
         this._num = param4;
      }
      
      override public function check() : Boolean
      {
         var _loc1_:Dictionary = null;
         var _loc2_:Dictionary = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _loc1_ = this._playerController.rewards.killTypes;
         _loc2_ = this._rewardSystem.killTypes;
         for each(_loc3_ in this._types)
         {
            _loc4_ = int(_loc1_[_loc3_]);
            if(!this._rewardSystem.isLocked)
            {
               _loc4_ += int(_loc2_[_loc3_]);
            }
            if(_loc4_ < 100)
            {
               return false;
            }
         }
         _isComplete = true;
         return _isComplete;
      }
   }
}

