package com.whatthefawk.ai.steering.path
{
   import com.whatthefawk.math.Vector2D;
   import flash.events.EventDispatcher;
   
   public class Path extends EventDispatcher
   {
      
      public static const OPEN:String = "open";
      
      public static const CLOSED:String = "closed";
      
      public static const PATROL:String = "patrol";
      
      private var _id:String;
      
      protected var _waypoints:Array;
      
      protected var _index:int;
      
      protected var _type:String;
      
      public function Path(param1:PathParams)
      {
         super();
         this._id = param1.id;
         this._type = param1.type;
         this._index = param1.index;
         this._waypoints = param1.waypoints;
      }
      
      public function get isOnLastWaypoint() : Boolean
      {
         return this._index == this._waypoints.length - 1 ? true : false;
      }
      
      public function set type(param1:String) : void
      {
         var _loc2_:Array = [Path.OPEN,Path.CLOSED,Path.PATROL];
         if(_loc2_.indexOf(param1) == -1)
         {
            throw new Error("<Path::set() type> Invalid path type " + param1 + " entered, path must be \'open\', \'closed\', or \'patrol.\'");
         }
         this._type = param1;
      }
      
      public function set index(param1:int) : void
      {
         if(param1 < 0 || param1 > this._waypoints.length - 1)
         {
            throw new Error("<Path::set() index> Invalid index value " + param1 + " entered, index must be between 0 and " + int(this._waypoints.length - 1) + ".");
         }
         this._index = param1;
      }
      
      public function clearWaypoints() : void
      {
         this._index = 0;
         this._waypoints = [];
      }
      
      public function get currentWaypoint() : Vector2D
      {
         return this._waypoints[this._index];
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function isOnWaypoint(param1:int) : Boolean
      {
         return this._index == param1 ? true : false;
      }
      
      public function reverseWaypoints() : Path
      {
         this._waypoints.reverse();
         return this;
      }
      
      public function addWaypoint(... rest) : void
      {
         if(rest.length == 1)
         {
            if(rest[0] is Vector2D)
            {
               this._waypoints.push(rest[0]);
            }
         }
         else if(rest.length == 2)
         {
            this._waypoints.push(new Vector2D(rest[0],rest[1]));
         }
      }
      
      public function copy() : Path
      {
         var _loc2_:Vector2D = null;
         var _loc1_:Path = new Path(new PathParams());
         _loc1_.type = this._type;
         for each(_loc2_ in this.waypoints)
         {
            _loc1_.addWaypoint(_loc2_);
         }
         _loc1_.index = this._index;
         return _loc1_;
      }
      
      public function setNextWaypoint() : Vector2D
      {
         var _loc1_:int = int(this._waypoints.length);
         if(_loc1_ > 1)
         {
            if(this._index == _loc1_ - 1)
            {
               if(this._type != Path.OPEN)
               {
                  if(this._type == Path.PATROL)
                  {
                     this._waypoints.reverse();
                     this._index = 1;
                  }
                  else
                  {
                     this._index = 0;
                  }
               }
            }
            else
            {
               ++this._index;
            }
            return this.currentWaypoint;
         }
         throw new Error("<Path::setNextWaypoint> Can NOT set next waypoint because this path only has one waypoint.");
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get isFinished() : Boolean
      {
         return this.isOnLastWaypoint && this._type == Path.OPEN ? true : false;
      }
      
      public function get waypoints() : Array
      {
         return this._waypoints;
      }
   }
}

