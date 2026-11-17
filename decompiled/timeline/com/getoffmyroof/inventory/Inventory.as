package com.getoffmyroof.inventory
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class Inventory extends EventDispatcher
   {
      
      protected var _key:Dictionary;
      
      protected var _items:Array;
      
      public function Inventory()
      {
         super();
         this._items = [];
         this._key = new Dictionary();
      }
      
      public function addItem(param1:Item) : void
      {
         this._key[param1.id] = this._items.length;
         this._items.push(param1);
      }
      
      public function get itemIDs() : Array
      {
         var _loc2_:Item = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._items)
         {
            _loc1_.push(_loc2_.id);
         }
         return _loc1_;
      }
      
      public function get items() : Array
      {
         return this._items;
      }
      
      public function getItem(param1:String) : Item
      {
         var _loc2_:int = int(this._key[param1]);
         return this._items[_loc2_];
      }
      
      public function hasItem(param1:String) : Boolean
      {
         return this._key[param1] != null;
      }
   }
}

