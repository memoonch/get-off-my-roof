package com.whatthefawk.math
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class Vector2D
   {
      
      public static const RAD_TO_DEG:Number = 180 / Math.PI;
      
      public static const DEG_TO_RAD:Number = Math.PI / 180;
      
      private var _oldY:Number;
      
      private var _length:Number = 0;
      
      private var _oldX:Number;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      private var v1:Vector2D;
      
      private var v2:Vector2D;
      
      public function Vector2D(param1:Number = 0, param2:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public static function radiansToVector(param1:Number) : Vector2D
      {
         return new Vector2D(Math.cos(param1),Math.sin(param1));
      }
      
      public static function degreesToVector(param1:Number) : Vector2D
      {
         return Vector2D.radiansToVector(param1 * DEG_TO_RAD);
      }
      
      public static function getRandom(param1:int, param2:int, param3:int, param4:int) : Vector2D
      {
         var _loc5_:int = int(Math.random() * (param2 - param1 + 1)) + param1;
         var _loc6_:int = int(Math.random() * (param4 - param3 + 1)) + param3;
         return new Vector2D(_loc5_,_loc6_);
      }
      
      public static function pointToVector(param1:Point) : Vector2D
      {
         return new Vector2D(param1.x,param1.y);
      }
      
      public function toRadians() : Number
      {
         return Math.atan2(this.y,this.x);
      }
      
      public function divide(... rest) : Vector2D
      {
         var _loc2_:int = int(rest.length);
         if(_loc2_ == 1)
         {
            if(rest[0] is Vector2D)
            {
               if(rest[0].x == 0 || rest[0].y == 0)
               {
                  throw new ArgumentError("<Vector2D::divide> Illegal division by zero.");
               }
               this.x /= rest[0].x;
               this.y /= rest[0].y;
            }
            else if(rest[0] is Number)
            {
               if(rest[0] == 0)
               {
                  throw new ArgumentError("<Vector2D::divide> Illegal division by zero.");
               }
               this.x /= rest[0];
               this.y /= rest[0];
            }
         }
         else if(_loc2_ == 2)
         {
            if(isNaN(rest[0]) || isNaN(rest[1]))
            {
               throw new ArgumentError("<Vector2D::divide> X and Y must be numbers.");
            }
            if(rest[0] == 0 || rest[1] == 0)
            {
               throw new ArgumentError("<Vector2D::divide> Illegal division by zero.");
            }
            this.x /= rest[0];
            this.y /= rest[1];
         }
         return this;
      }
      
      public function isNormalTo(param1:Vector2D) : Boolean
      {
         return this.dot(param1) === 0;
      }
      
      public function normalize() : Vector2D
      {
         if(this.length != 0)
         {
            this.x /= this._length;
            this.y /= this._length;
         }
         return this;
      }
      
      public function projectionOn(param1:Vector2D) : Vector2D
      {
         return this.copy().projectOn(param1);
      }
      
      public function swap(param1:Vector2D) : Vector2D
      {
         var _loc2_:Number = this.x;
         var _loc3_:Number = this.y;
         this.x = param1.x;
         this.y = param1.y;
         param1.x = _loc2_;
         param1.y = _loc3_;
         return this;
      }
      
      public function distanceSqTo(param1:Vector2D) : Number
      {
         var _loc2_:* = param1.x - this.x;
         var _loc3_:* = param1.y - this.y;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
      
      public function plus(param1:Vector2D) : Vector2D
      {
         this.x += param1.x;
         this.y += param1.y;
         return this;
      }
      
      public function addedTo(... rest) : Vector2D
      {
         return this.copy().plus.apply(null,rest);
      }
      
      public function isInRange(param1:Vector2D, param2:Number) : Boolean
      {
         return this.distanceTo(param1) < param2;
      }
      
      public function rightNormal() : Vector2D
      {
         return new Vector2D(-this.y,this.x);
      }
      
      public function displayVector(param1:DisplayObject, param2:Number, param3:Number = 0) : void
      {
      }
      
      public function zero() : Vector2D
      {
         this.x = this.y = 0;
         return this;
      }
      
      public function isParallelTo(param1:Vector2D) : Boolean
      {
         this.v1 = this.copy().normalize();
         this.v2 = param1.copy().normalize();
         return this.v1.x == this.v2.x && this.v1.y == this.v2.y || this.v1.x == -this.v2.x && this.v1.y == -this.v2.y;
      }
      
      public function angleTo(param1:Vector2D) : Number
      {
         return Math.acos(this.dot(param1) / (this.length * param1.length));
      }
      
      public function randomize(param1:Number, param2:Number, param3:Number, param4:Number) : Vector2D
      {
         this.x = int(Math.random() * (param2 - param1 + 1)) + param1;
         this.y = int(Math.random() * (param4 - param3 + 1)) + param3;
         return this;
      }
      
      public function toDegrees() : Number
      {
         return this.toRadians() * RAD_TO_DEG;
      }
      
      public function sign(param1:Vector2D) : int
      {
         return this.y * param1.x > this.x * param1.y ? -1 : 1;
      }
      
      public function cross(param1:Vector2D) : Number
      {
         return this.x * param1.y - this.y * param1.x;
      }
      
      public function dividedBy(... rest) : Vector2D
      {
         return this.copy().divide.apply(null,rest);
      }
      
      public function isInRegion(param1:Vector2D, param2:Vector2D) : Boolean
      {
         return !(this.x < param1.x || this.x > param1.x + param2.x || this.y < param1.y || this.y > param1.y + param2.y);
      }
      
      public function reflect(param1:Vector2D) : Vector2D
      {
         this.plus(param1.copy().reverse().times(2 * this.dot(param1)));
         return this;
      }
      
      public function isEqualTo(param1:Vector2D) : Boolean
      {
         return this.x === param1.x && this.y === param1.y ? true : false;
      }
      
      public function times(... rest) : Vector2D
      {
         var _loc2_:int = int(rest.length);
         if(_loc2_ == 1)
         {
            if(rest[0] is Vector2D)
            {
               this.x *= rest[0].x;
               this.y *= rest[0].y;
            }
            else if(rest[0] is Number)
            {
               this.x *= rest[0];
               this.y *= rest[0];
            }
         }
         else if(_loc2_ == 2)
         {
            if(isNaN(rest[0]) || isNaN(rest[1]))
            {
               throw new ArgumentError("<Vector2D::times> X and Y must be numbers.");
            }
            this.x *= rest[0];
            this.y *= rest[1];
         }
         return this;
      }
      
      public function dot(param1:Vector2D) : Number
      {
         return this.x * param1.x + this.y * param1.y;
      }
      
      public function leftNormal() : Vector2D
      {
         return new Vector2D(this.y,-this.x);
      }
      
      public function angleCosTo(param1:Vector2D) : Number
      {
         return this.dot(param1) / (this.length * param1.length);
      }
      
      public function distanceTo(param1:Vector2D) : Number
      {
         var _loc2_:* = param1.x - this.x;
         var _loc3_:* = param1.y - this.y;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function toPoint() : Point
      {
         return new Point(this.x,this.y);
      }
      
      public function perpDot(param1:Vector2D) : Number
      {
         return this.perp().dot(param1);
      }
      
      public function isXOrYZero() : Boolean
      {
         return this.x == 0 || this.y == 0;
      }
      
      public function projectOn(param1:Vector2D) : Vector2D
      {
         this.set(param1.copy().times(this.dot(param1) / param1.dot(param1)));
         return this;
      }
      
      public function rotate(param1:Number) : Vector2D
      {
         var _loc2_:Number = this.length;
         param1 = (Math.atan2(this.y,this.x) * RAD_TO_DEG + Number(param1)) * DEG_TO_RAD;
         this.x = _loc2_ * Math.cos(param1);
         this.y = _loc2_ * Math.sin(param1);
         return this;
      }
      
      public function isInFOV(param1:Vector2D, param2:Vector2D, param3:Number) : Boolean
      {
         var _loc4_:Vector2D = this.copy();
         _loc4_.minus(param1);
         _loc4_.normalize();
         return param2.dot(_loc4_) > Math.cos(param3 * 0.5);
      }
      
      public function get lengthSq() : Number
      {
         return this.x * this.x + this.y * this.y;
      }
      
      public function get length() : Number
      {
         if(this._oldX != this.x || this._oldY != this.y)
         {
            this._oldX = this.x;
            this._oldY = this.y;
            this._length = Math.sqrt(this.x * this.x + this.y * this.y);
         }
         return this._length;
      }
      
      public function angleSinTo(param1:Vector2D) : Number
      {
         return this.cross(param1) / (this.length * param1.length);
      }
      
      public function set(... rest) : Vector2D
      {
         var _loc2_:int = int(rest.length);
         if(_loc2_ == 1)
         {
            if(rest[0] is Vector2D)
            {
               this.x = rest[0].x;
               this.y = rest[0].y;
            }
         }
         else if(_loc2_ == 2)
         {
            this.x = rest[0];
            this.y = rest[1];
         }
         return this;
      }
      
      public function subtractedBy(... rest) : Vector2D
      {
         return this.copy().minus.apply(null,rest);
      }
      
      public function toString() : String
      {
         return "( " + this.x + ", " + this.y + " )";
      }
      
      public function truncate(param1:Number) : Vector2D
      {
         if(this.lengthSq > param1 * param1)
         {
            this.normalize();
            this.x *= param1;
            this.y *= param1;
         }
         return this;
      }
      
      public function displayPoint(param1:DisplayObject, param2:Number, param3:Number = 0) : void
      {
      }
      
      public function minus(param1:Vector2D) : Vector2D
      {
         this.x -= param1.x;
         this.y -= param1.y;
         return this;
      }
      
      public function multipliedBy(... rest) : Vector2D
      {
         return this.copy().times.apply(null,rest);
      }
      
      public function isZero() : Boolean
      {
         return this.x == 0 && this.y == 0;
      }
      
      public function perp() : Vector2D
      {
         return this.rightNormal();
      }
      
      public function copy() : Vector2D
      {
         var _loc1_:Vector2D = new Vector2D(this.x,this.y);
         _loc1_._length = this._length;
         _loc1_._oldX = this._oldX;
         _loc1_._oldY = this._oldY;
         return _loc1_;
      }
      
      public function reverse() : Vector2D
      {
         this.x *= -1;
         this.y *= -1;
         return this;
      }
      
      public function normalized() : Vector2D
      {
         return this.copy().normalize();
      }
   }
}

