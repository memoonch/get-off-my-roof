package com.whatthefawk.ai.steering.behaviors
{
   import com.whatthefawk.entity.Boid;
   import com.whatthefawk.math.Vector2D;
   
   public class ASteeringBehavior
   {
      
      public var entity:Boid;
      
      public var priority:int;
      
      public var probability:Number;
      
      public var weight:Number;
      
      public function ASteeringBehavior(param1:Number = 1, param2:int = 1, param3:Number = 1)
      {
         super();
         this.weight = param1;
         this.priority = param2;
         this.probability = param3;
      }
      
      public function force() : Vector2D
      {
         throw new Error("ABehavior::force()  Error: Abstract methods must be overriden!");
      }
   }
}

