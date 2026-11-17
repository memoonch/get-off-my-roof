package com.getoffmyroof.popups
{
   import com.whatthefawk.math.Vector2D;
   
   public class PointsPopup extends APopup
   {
      
      public var points:int;
      
      public function PointsPopup(param1:PopupParams = null)
      {
         super(param1);
         applyForce(new Vector2D(0,-50));
      }
   }
}

