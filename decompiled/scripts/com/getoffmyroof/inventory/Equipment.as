package com.getoffmyroof.inventory
{
   import flash.utils.Dictionary;
   
   public class Equipment
   {
      
      protected var _slotGroup:Dictionary;
      
      protected var _slots:Dictionary;
      
      public function Equipment()
      {
         super();
         this._slots = new Dictionary();
         this._slotGroup = new Dictionary();
      }
      
      public function addSlotGroup(param1:String) : void
      {
         this._slotGroup[param1] = [];
      }
      
      public function isEquipped(param1:String) : Boolean
      {
         var _loc2_:String = null;
         for each(_loc2_ in this._slots)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function unequipItem(param1:String) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this._slots)
         {
            if(this._slots[_loc2_] == param1)
            {
               this._slots[_loc2_] = null;
            }
         }
      }
      
      public function getSlotGroup(param1:String) : Array
      {
         if(!this._slotGroup[param1])
         {
            throw new Error("No Slot Group with the ID " + param1 + " exists.");
         }
         return this._slotGroup[param1];
      }
      
      public function equip(param1:String, param2:String) : void
      {
         if(!this._slots[param2] && this._slots[param2] !== null)
         {
            throw new Error("No slot with the ID " + param2 + " exists.");
         }
         this._slots[param2] = param1;
      }
      
      public function getSlot(param1:String) : String
      {
         if(!this._slots[param1] && this._slots[param1] !== null)
         {
            throw new Error("No Slot with the ID " + param1 + " exists.");
         }
         return this._slots[param1];
      }
      
      public function get slots() : Dictionary
      {
         return this._slots;
      }
      
      public function unequip(param1:String) : void
      {
         if(!this._slots[param1] && this._slots[param1] !== null)
         {
            throw new Error("No slot with the ID " + param1 + " exists.");
         }
         this._slots[param1] = null;
      }
      
      public function addSlot(param1:String, param2:String = null) : void
      {
         if(Boolean(param2) && !this._slotGroup[param2])
         {
            throw new Error("No Slot Group with the ID " + param2 + " exists.");
         }
         this._slots[param1] = null;
         if(param2)
         {
            this._slotGroup[param2].push(param1);
         }
      }
   }
}

