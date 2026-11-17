package com.whatthefawk.collision.bounds
{
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.AABBox;
   
   public class RemoveBoundsBehavior extends ABoundsBehavior
   {
      
      public function RemoveBoundsBehavior(param1:BoundsBehaviorParams)
      {
         super(param1);
      }
      
      override public function checkBounds(param1:MovingEntity, param2:AABBox) : void
      {
         if(checkLeft)
         {
            if(param1.currentPos.x < param2.left)
            {
               param1.onBoundsRemove();
               param1.parent.removeChild(param1.id);
            }
         }
         if(checkRight)
         {
            if(param1.currentPos.x > param2.right)
            {
               param1.onBoundsRemove();
               param1.parent.removeChild(param1.id);
            }
         }
         if(checkTop)
         {
            if(param1.currentPos.y < param2.top)
            {
               param1.onBoundsRemove();
               param1.parent.removeChild(param1.id);
            }
         }
         if(checkBottom)
         {
            if(param1.currentPos.y > param2.bottom)
            {
               param1.onBoundsRemove();
               param1.parent.removeChild(param1.id);
            }
         }
      }
   }
}

