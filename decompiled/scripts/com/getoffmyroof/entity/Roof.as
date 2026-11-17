package com.getoffmyroof.entity
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.EntityParams;
   import com.whatthefawk.entity.Wall;
   
   public class Roof extends Entity
   {
      
      public var width:int;
      
      public var height:int;
      
      private var m_walls:Array;
      
      public function Roof(param1:EntityParams)
      {
         super(param1);
         this.m_walls = [];
      }
      
      override public function dispose() : void
      {
         this.m_walls = null;
         super.dispose();
      }
      
      public function get walls() : Array
      {
         return this.m_walls;
      }
      
      public function getRandomWall() : *
      {
         var _loc1_:int = Math.floor(Math.random() * this.m_walls.length);
         return this.m_walls[_loc1_];
      }
      
      public function addWall(param1:Wall) : void
      {
         this.m_walls.push(param1);
      }
      
      public function removeWall(param1:String) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.m_walls.length)
         {
            if(this.m_walls[_loc2_].id == param1)
            {
               this.m_walls.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
   }
}

