package com.getoffmyroof.save
{
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   
   public class LocalSaveLoad implements ISaveLoad
   {
      
      protected var _soID:String;
      
      protected var _localPath:String;
      
      protected var _byteArray:ByteArray;
      
      protected var _so:SharedObject;
      
      protected var _minDiskSpace:int;
      
      public function LocalSaveLoad(param1:String, param2:String = "/", param3:int = 0)
      {
         var sharedObjectID:String = param1;
         var localPath:String = param2;
         var minDiskSpace:int = param3;
         super();
         this._soID = sharedObjectID;
         this._localPath = localPath;
         this._minDiskSpace = minDiskSpace;
         try
         {
            this._so = SharedObject.getLocal(this._soID,this._localPath);
         }
         catch(error:Error)
         {
            throw error;
         }
      }
      
      public function load() : IValueObject
      {
         if(this._so.data.save == undefined)
         {
            return null;
         }
         var _loc1_:ByteArray = this._so.data.save;
         _loc1_.uncompress();
         var _loc2_:* = _loc1_.readObject();
         _loc1_.compress();
         return IValueObject(_loc2_);
      }
      
      public function get id() : String
      {
         return "local";
      }
      
      public function clear() : void
      {
         this._so.clear();
      }
      
      public function save(param1:IValueObject = null) : void
      {
         this._byteArray = new ByteArray();
         this._byteArray.writeObject(param1);
         this._byteArray.compress();
         this._byteArray.position = 0;
         this._so.data.save = this._byteArray;
         this._so.flush(this._minDiskSpace);
      }
   }
}

