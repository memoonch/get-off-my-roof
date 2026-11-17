package com.whatthefawk.weapons
{
   import flash.events.EventDispatcher;
   
   public class WeaponSystem extends EventDispatcher
   {
      
      private var m_weaponCount:int;
      
      private var m_weapons:Array;
      
      private var m_currentWeapon:*;
      
      private var m_agent:*;
      
      private var m_isActivated:Boolean;
      
      public function WeaponSystem(param1:*)
      {
         super();
         this.m_agent = param1;
         this.m_weapons = [];
         this.m_weaponCount = 0;
         this.m_currentWeapon = null;
         this.m_isActivated = false;
      }
      
      public function removeWeapon(param1:int) : *
      {
         this.m_weapons[param1].dispose();
         this.m_weapons[param1] = null;
         this.updateWeaponCount();
      }
      
      public function get isActivated() : Boolean
      {
         return this.m_isActivated;
      }
      
      public function activateCurrentWeapon() : void
      {
         this.m_isActivated = true;
         if(this.m_currentWeapon)
         {
            this.m_currentWeapon.activate();
         }
      }
      
      private function updateWeaponCount() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         for each(_loc2_ in this.m_weapons)
         {
            if(_loc2_ != null)
            {
               _loc1_++;
            }
         }
         this.m_weaponCount = _loc1_;
      }
      
      public function update(param1:int) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in this.m_weapons)
         {
            _loc2_.update(param1);
         }
      }
      
      public function getWeapon(param1:*) : *
      {
      }
      
      public function get currentWeaponID() : String
      {
         return this.m_currentWeapon.id;
      }
      
      public function reloadCurrentWeapon() : void
      {
         if(this.m_currentWeapon)
         {
            this.m_currentWeapon.reload();
         }
      }
      
      public function addWeapon(param1:*, param2:int) : *
      {
         this.m_weapons[param2] = param1;
         this.updateWeaponCount();
         if(this.m_weaponCount == 1)
         {
            this.m_currentWeapon = this.m_weapons[param2];
         }
      }
      
      public function dispose() : void
      {
         this.m_agent = null;
         this.m_weapons = null;
         this.m_currentWeapon = null;
      }
      
      public function switchCurrentWeapon(param1:int) : void
      {
         if(!this.m_weapons[param1])
         {
            return;
         }
         this.deactivateCurrentWeapon();
         this.m_currentWeapon = this.m_weapons[param1];
         dispatchEvent(new WeaponSystemEvent(WeaponSystemEvent.SWITCH_WEAPON,{"slot":param1}));
      }
      
      public function getWeaponBySlot(param1:int) : *
      {
         return this.m_weapons[param1];
      }
      
      public function deactivateCurrentWeapon() : void
      {
         this.m_isActivated = false;
         if(this.m_currentWeapon)
         {
            this.m_currentWeapon.deactivate();
         }
      }
      
      public function swapWeaponSlots(param1:int, param2:int) : void
      {
      }
      
      public function canFireCurrentWeapon() : Boolean
      {
         return this.m_currentWeapon.canFire;
      }
      
      public function get numWeapons() : int
      {
         return this.m_weaponCount;
      }
      
      public function getCurrentWeapon() : *
      {
         return this.m_currentWeapon;
      }
   }
}

