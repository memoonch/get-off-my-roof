package com.whatthefawk.ai.steering.path
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class PathManager extends EventDispatcher
   {
      
      protected var _numPaths:int;
      
      protected var _paths:Dictionary;
      
      protected var _pathMap:Array;
      
      public function PathManager()
      {
         super();
         this._paths = new Dictionary();
         this._pathMap = [];
         this._numPaths = 0;
      }
      
      public function getRandomPath() : Path
      {
         if(this._numPaths == 0)
         {
            throw new Error("<PathManager::getRandomPath> Path manager has zero paths to randomly select from.");
         }
         var _loc1_:int = Math.random() * this._numPaths;
         var _loc2_:String = this._pathMap[_loc1_];
         return this._paths[_loc2_];
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this._paths)
         {
            this._paths[_loc1_] = null;
            delete this._paths[_loc1_];
         }
         this._paths = null;
         this._pathMap = null;
      }
      
      public function get numPaths() : int
      {
         return this._numPaths;
      }
      
      public function removePath(param1:String) : void
      {
         this._paths[param1] = null;
         delete this._paths[param1];
         var _loc2_:int = this._pathMap.indexOf(param1);
         this._pathMap.splice(_loc2_,1);
         --this._numPaths;
      }
      
      public function addPath(param1:Path) : void
      {
         this._paths[param1.id] = param1;
         this._pathMap.push(param1.id);
         ++this._numPaths;
      }
      
      public function getPath(param1:String) : Path
      {
         return this._paths[param1];
      }
      
      public function hasPath(param1:String) : Boolean
      {
         return this._paths[param1] ? true : false;
      }
   }
}

