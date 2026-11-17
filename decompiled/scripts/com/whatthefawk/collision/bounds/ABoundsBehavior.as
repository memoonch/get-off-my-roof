package com.whatthefawk.collision.bounds
{
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.AABBox;
   import flash.events.EventDispatcher;
   
   public class ABoundsBehavior extends EventDispatcher
   {
      
      public var checkBottom:Boolean;
      
      public var checkRight:Boolean;
      
      public var checkTop:Boolean;
      
      public var checkLeft:Boolean;
      
      public function ABoundsBehavior(param1:BoundsBehaviorParams)
      {
         super();
         this.checkTop = param1.checkTop;
         this.checkLeft = param1.checkLeft;
         this.checkRight = param1.checkRight;
         this.checkBottom = param1.checkBottom;
      }
      
      public function checkBounds(param1:MovingEntity, param2:AABBox) : void
      {
         throw new Error("<ABoundsBehavior::checkBounds> <ABSTRACT> method must be extended in subclass.");
      }
   }
}

