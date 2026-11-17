package com.whatthefawk.entity
{
   import com.whatthefawk.math.AABBox;
   import com.whatthefawk.math.Vector2D;
   
   public class Wall extends Entity
   {
      
      public static const SLANT_LEFT:int = -1;
      
      public static const SLANT_RIGHT:int = 1;
      
      public static const NORMAL_DRAW_LEN:int = 10;
      
      public var isNormalDrawn:Boolean;
      
      private var m_angle:Vector2D;
      
      private var m_toPoint:Vector2D;
      
      public var wallColor:uint;
      
      private var m_fromPoint:Vector2D;
      
      private var m_normal:Vector2D;
      
      private var m_width:Number;
      
      public var isWallDrawn:Boolean;
      
      private var m_height:Number;
      
      private var m_midPoint:Vector2D;
      
      public var normalColor:uint;
      
      private var m_length:Vector2D;
      
      public function Wall(param1:*)
      {
         super(param1);
         this.m_fromPoint = new Vector2D();
         this.m_midPoint = new Vector2D();
         this.m_toPoint = new Vector2D();
         this.m_normal = new Vector2D();
         this.m_angle = new Vector2D();
         bounds = new AABBox(currentPos,radius,radius);
      }
      
      public function setFromPoint(param1:Vector2D) : void
      {
         this.m_fromPoint.set(param1);
         this.setCorners(this.m_fromPoint,this.m_toPoint);
      }
      
      public function getRandomPointOffWall(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : Vector2D
      {
         var _loc6_:Vector2D = this.length.normalized().times(param3).plus(this.fromPoint);
         var _loc7_:Vector2D = this.length.normalized().times(this.length.length - param4).plus(this.fromPoint);
         var _loc8_:Vector2D = _loc7_.subtractedBy(_loc6_);
         var _loc9_:Vector2D = _loc8_.normalized();
         var _loc10_:Vector2D = _loc9_.times(Math.random() * _loc8_.length).plus(_loc6_);
         var _loc11_:Vector2D = this.normal.multipliedBy(Math.random() * param2 + param1);
         return _loc10_.addedTo(_loc11_);
      }
      
      public function setCorners(param1:Vector2D, param2:Vector2D) : void
      {
         this.m_fromPoint = param1;
         this.m_toPoint = param2;
         this.m_midPoint = this.fromPoint.addedTo(this.toPoint).divide(2);
         this.calculateLength();
         this.calculateNormal();
         this.calculateAngle();
         var _loc3_:Vector2D = this.m_fromPoint.subtractedBy(this.m_midPoint);
         var _loc4_:Vector2D = this.m_toPoint.subtractedBy(this.m_midPoint);
         this.m_width = Math.abs(_loc3_.x - _loc4_.x);
         this.m_height = Math.abs(_loc3_.y - _loc4_.y);
      }
      
      public function get fromPoint() : Vector2D
      {
         return this.m_fromPoint;
      }
      
      private function calculateLength() : void
      {
         this.m_length = this.toPoint.subtractedBy(this.fromPoint);
      }
      
      public function isSlanted() : int
      {
         return this.m_angle.toDegrees() > 0 ? Wall.SLANT_RIGHT : Wall.SLANT_LEFT;
      }
      
      public function get angle() : Vector2D
      {
         return this.m_angle;
      }
      
      public function get toPoint() : Vector2D
      {
         return this.m_toPoint;
      }
      
      override public function dispose() : void
      {
         this.m_fromPoint = null;
         this.m_midPoint = null;
         this.m_toPoint = null;
         this.m_normal = null;
         super.dispose();
      }
      
      public function setToPoint(param1:Vector2D) : void
      {
         this.m_toPoint.set(param1);
         this.setCorners(this.m_fromPoint,this.m_toPoint);
      }
      
      private function calculateAngle() : void
      {
         this.m_angle = this.normal.perp();
      }
      
      public function get width() : Number
      {
         return this.m_width;
      }
      
      public function get length() : Vector2D
      {
         return this.m_length;
      }
      
      public function get normal() : Vector2D
      {
         return this.m_normal;
      }
      
      private function calculateNormal() : void
      {
         this.normal.set(this.m_length.normalized().rightNormal());
      }
      
      public function get height() : Number
      {
         return this.m_height;
      }
      
      override protected function setInitialValues(param1:int) : void
      {
         _stepSize = param1 * 0.001;
         currentPos.x = newPos.x;
         currentPos.y = newPos.y;
         bounds.set(this.m_midPoint,this.width,this.height);
      }
      
      public function get midPoint() : Vector2D
      {
         return this.m_midPoint;
      }
   }
}

