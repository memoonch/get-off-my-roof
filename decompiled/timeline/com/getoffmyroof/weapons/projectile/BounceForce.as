package com.getoffmyroof.weapons.projectile
{
   import com.whatthefawk.math.Vector2D;
   
   public class BounceForce
   {
      
      public var maxX:int;
      
      public var maxY:int;
      
      public var minX:int;
      
      public var minY:int;
      
      public function BounceForce(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0)
      {
         super();
         this.minX = param1;
         this.maxX = param2;
         this.minY = param3;
         this.maxY = param4;
      }
      
      public function calculate() : Vector2D
      {
         return Vector2D.getRandom(this.minX,this.maxX,this.minY,this.maxY);
      }
   }
}

