package com.whatthefawk.collision.bounds
{
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.AABBox;
   
   public class StopBoundsBehavior extends ABoundsBehavior
   {
      
      public function StopBoundsBehavior(param1:BoundsBehaviorParams)
      {
         super(param1);
      }
      
      override public function checkBounds(param1:MovingEntity, param2:AABBox) : void
      {
         if(checkLeft)
         {
            if(param1.currentPos.x < param2.left + param1.radius)
            {
               param1.velocity.x = 0;
               param1.currentPos.x = param2.left + param1.radius;
            }
         }
         if(checkRight)
         {
            if(param1.currentPos.x > param2.right - param1.radius)
            {
               param1.velocity.x = 0;
               param1.currentPos.x = param2.right - param1.radius;
            }
         }
         if(checkTop)
         {
            if(param1.currentPos.y < param2.top + param1.radius)
            {
               param1.velocity.y = 0;
               param1.currentPos.y = param2.top + param1.radius;
            }
         }
         if(checkBottom)
         {
            if(param1.currentPos.y > param2.bottom - param1.radius)
            {
               param1.velocity.y = 0;
               param1.currentPos.y = param2.bottom - param1.radius;
            }
         }
      }
   }
}

