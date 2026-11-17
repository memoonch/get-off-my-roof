package com.getoffmyroof.rewards.achievements
{
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.inventory.Inventory;
   import com.getoffmyroof.inventory.Item;
   import com.whatthefawk.rewards.achievements.AAchievement;
   
   public class UnlockAllWeaponsAchievement extends AAchievement
   {
      
      protected var _globalInventory:Inventory;
      
      protected var _playerController:PlayerController;
      
      public function UnlockAllWeaponsAchievement(param1:String, param2:String)
      {
         super();
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         this._globalInventory = GameComponents.instance.getComponent("GlobalInventory");
         _id = param1;
         _name = param2;
         _description = "Unlock all weapons!";
      }
      
      override public function check() : Boolean
      {
         var _loc3_:Item = null;
         var _loc1_:Array = this._globalInventory.items;
         var _loc2_:Inventory = this._playerController.inventory;
         for each(_loc3_ in _loc1_)
         {
            if(!(_loc3_.type != "projectile" && _loc3_.type != "melee"))
            {
               if(!_loc2_.hasItem(_loc3_.id))
               {
                  return false;
               }
            }
         }
         _isComplete = true;
         return _isComplete;
      }
   }
}

