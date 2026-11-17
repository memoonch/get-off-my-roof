package com.getoffmyroof.save
{
   import flash.utils.Dictionary;
   
   public class SaveLoadManager
   {
      
      protected var _saveLoadMap:Dictionary;
      
      public function SaveLoadManager()
      {
         super();
         this._saveLoadMap = new Dictionary();
         ClassAliasRegistrar.register();
      }
      
      public function clear(param1:String = null) : void
      {
         if(!this._saveLoadMap[param1])
         {
            throw new Error("No SaveLoad exists with the id",param1);
         }
         return ISaveLoad(this._saveLoadMap[param1]).clear();
      }
      
      public function load(param1:String = null) : IValueObject
      {
         if(!this._saveLoadMap[param1])
         {
            throw new Error("No SaveLoad exists with the id",param1);
         }
         return ISaveLoad(this._saveLoadMap[param1]).load();
      }
      
      public function addSaveLoad(param1:ISaveLoad) : void
      {
         this._saveLoadMap[param1.id] = param1;
      }
      
      public function save(param1:String, param2:IValueObject) : void
      {
         if(!this._saveLoadMap[param1])
         {
            throw new Error("No SaveLoad exists with the id",param1);
         }
         ISaveLoad(this._saveLoadMap[param1]).save(param2);
      }
      
      public function hasSaveLoad(param1:String) : Boolean
      {
         return this._saveLoadMap[param1] != null;
      }
   }
}

