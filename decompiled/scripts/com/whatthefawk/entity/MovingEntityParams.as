package com.whatthefawk.entity
{
   import com.whatthefawk.math.Vector2D;
   
   public class MovingEntityParams extends EntityParams
   {
      
      public var maxTurnRate:Number = 0;
      
      public var maxSpeed:Number = 2000;
      
      public var bounce:Vector2D = new Vector2D(1,1);
      
      public var mass:Number = 1;
      
      public var isCollidableWithWall:Boolean = true;
      
      public var neighborhoodDistance:Number = 0;
      
      public var faceHeading:Boolean = true;
      
      public var isCollidableWithBounds:Boolean = true;
      
      public var maxForce:Number = 0;
      
      public var boundsBehaviors:Array = [];
      
      public var boundsBehavior:String = MovingEntity.BOUNDS_NONE;
      
      public var smoothHeading:Boolean = false;
      
      public var friction:Vector2D = new Vector2D(1,1);
      
      public function MovingEntityParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

