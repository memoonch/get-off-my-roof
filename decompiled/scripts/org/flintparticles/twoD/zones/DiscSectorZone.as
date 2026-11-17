package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class DiscSectorZone implements Zone2D
   {
      
      private static var TWOPI:Number = Math.PI * 2;
      
      private var _minAngle:Number;
      
      private var _innerRadius:Number;
      
      private var _minAllowed:Number;
      
      private var _outerRadius:Number;
      
      private var _center:Point;
      
      private var _maxAngle:Number;
      
      private var _innerSq:Number;
      
      private var _outerSq:Number;
      
      public function DiscSectorZone(param1:Point = null, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0)
      {
         super();
         if(param2 < param3)
         {
            throw new Error("The outerRadius (" + param2 + ") can\'t be smaller than the innerRadius (" + param3 + ") in your DiscSectorZone. N.B. the outerRadius is the second argument in the constructor and the innerRadius is the third argument.");
         }
         this._center = param1 ? param1.clone() : new Point(0,0);
         this._innerRadius = param3;
         this._outerRadius = param2;
         this._innerSq = this._innerRadius * this._innerRadius;
         this._outerSq = this._outerRadius * this._outerRadius;
         this._minAngle = param4;
         this._maxAngle = param5;
         if(this._maxAngle)
         {
            while(this._maxAngle > TWOPI)
            {
               this._maxAngle -= TWOPI;
            }
            while(this._maxAngle < 0)
            {
               this._maxAngle += TWOPI;
            }
            this._minAllowed = this._maxAngle - TWOPI;
            if(this._minAngle)
            {
               if(param4 == param5)
               {
                  this._minAngle = this._maxAngle;
               }
               else
               {
                  this._minAngle = this.clamp(this._minAngle);
               }
            }
         }
      }
      
      public function set minAngle(param1:Number) : void
      {
         this._minAngle = this.clamp(param1);
      }
      
      public function set centerX(param1:Number) : void
      {
         this._center.x = param1;
      }
      
      public function set centerY(param1:Number) : void
      {
         this._center.y = param1;
      }
      
      public function getArea() : Number
      {
         return Math.PI * this._outerSq - Math.PI * this._innerSq;
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
      
      public function get maxAngle() : Number
      {
         return this._maxAngle;
      }
      
      public function set outerRadius(param1:Number) : void
      {
         this._outerRadius = param1;
         this._outerSq = this._outerRadius * this._outerRadius;
      }
      
      public function set maxAngle(param1:Number) : void
      {
         this._maxAngle = param1;
         while(this._maxAngle > TWOPI)
         {
            this._maxAngle -= TWOPI;
         }
         while(this._maxAngle < 0)
         {
            this._maxAngle += TWOPI;
         }
         this._minAllowed = this._maxAngle - TWOPI;
         this._minAngle = this.clamp(this._minAngle);
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         param1 -= this._center.x;
         param2 -= this._center.y;
         var _loc3_:Number = param1 * param1 + param2 * param2;
         if(_loc3_ > this._outerSq || _loc3_ < this._innerSq)
         {
            return false;
         }
         var _loc4_:Number = Math.atan2(param2,param1);
         _loc4_ = this.clamp(_loc4_);
         return _loc4_ >= this._minAngle;
      }
      
      public function get minAngle() : Number
      {
         return this._minAngle;
      }
      
      public function get centerX() : Number
      {
         return this._center.x;
      }
      
      public function get centerY() : Number
      {
         return this._center.y;
      }
      
      public function get center() : Point
      {
         return this._center;
      }
      
      public function getLocation() : Point
      {
         var _loc1_:Number = Math.random();
         var _loc2_:Point = Point.polar(this._innerRadius + (1 - _loc1_ * _loc1_) * (this._outerRadius - this._innerRadius),this._minAngle + Math.random() * (this._maxAngle - this._minAngle));
         _loc2_.x += this._center.x;
         _loc2_.y += this._center.y;
         return _loc2_;
      }
      
      public function set center(param1:Point) : void
      {
         this._center = param1;
      }
      
      private function clamp(param1:Number) : Number
      {
         if(this._maxAngle)
         {
            while(param1 > this._maxAngle)
            {
               param1 -= TWOPI;
            }
            while(param1 < this._minAllowed)
            {
               param1 += TWOPI;
            }
         }
         return param1;
      }
      
      public function get outerRadius() : Number
      {
         return this._outerRadius;
      }
   }
}

