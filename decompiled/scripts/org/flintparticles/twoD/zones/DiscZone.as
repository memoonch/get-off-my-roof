package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class DiscZone implements Zone2D
   {
      
      private static const TWOPI:Number = Math.PI * 2;
      
      private var _innerRadius:Number;
      
      private var _innerSq:Number;
      
      private var _outerRadius:Number;
      
      private var _center:Point;
      
      private var _outerSq:Number;
      
      public function DiscZone(param1:Point = null, param2:Number = 0, param3:Number = 0)
      {
         super();
         if(param2 < param3)
         {
            throw new Error("The outerRadius (" + param2 + ") can\'t be smaller than the innerRadius (" + param3 + ") in your DiscZone. N.B. the outerRadius is the second argument in the constructor and the innerRadius is the third argument.");
         }
         if(param1 == null)
         {
            this._center = new Point(0,0);
         }
         else
         {
            this._center = param1;
         }
         this._innerRadius = param3;
         this._outerRadius = param2;
         this._innerSq = this._innerRadius * this._innerRadius;
         this._outerSq = this._outerRadius * this._outerRadius;
      }
      
      public function getArea() : Number
      {
         return Math.PI * (this._outerSq - this._innerSq);
      }
      
      public function set centerX(param1:Number) : void
      {
         this._center.x = param1;
      }
      
      public function set centerY(param1:Number) : void
      {
         this._center.y = param1;
      }
      
      public function get innerRadius() : Number
      {
         return this._innerRadius;
      }
      
      public function set innerRadius(param1:Number) : void
      {
         this._innerRadius = param1;
         this._innerSq = this._innerRadius * this._innerRadius;
      }
      
      public function get center() : Point
      {
         return this._center;
      }
      
      public function set outerRadius(param1:Number) : void
      {
         this._outerRadius = param1;
         this._outerSq = this._outerRadius * this._outerRadius;
      }
      
      public function get centerX() : Number
      {
         return this._center.x;
      }
      
      public function get centerY() : Number
      {
         return this._center.y;
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         param1 -= this._center.x;
         param2 -= this._center.y;
         var _loc3_:Number = param1 * param1 + param2 * param2;
         return _loc3_ <= this._outerSq && _loc3_ >= this._innerSq;
      }
      
      public function getLocation() : Point
      {
         var _loc1_:Number = Math.random();
         var _loc2_:Point = Point.polar(this._innerRadius + (1 - _loc1_ * _loc1_) * (this._outerRadius - this._innerRadius),Math.random() * TWOPI);
         _loc2_.x += this._center.x;
         _loc2_.y += this._center.y;
         return _loc2_;
      }
      
      public function get outerRadius() : Number
      {
         return this._outerRadius;
      }
      
      public function set center(param1:Point) : void
      {
         this._center = param1;
      }
   }
}

