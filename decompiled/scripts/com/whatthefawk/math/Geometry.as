package com.whatthefawk.math
{
   public class Geometry
   {
      
      public function Geometry()
      {
         super();
      }
      
      public static function isLineIntersecting(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Vector2D) : Boolean
      {
         var _loc5_:Number = (param1.y - param3.y) * (param4.x - param3.x) - (param1.x - param3.x) * (param4.y - param3.y);
         var _loc6_:Number = (param1.y - param3.y) * (param2.x - param1.x) - (param1.x - param3.x) * (param2.y - param1.y);
         var _loc7_:Number = (param2.x - param1.x) * (param4.y - param3.y) - (param2.y - param1.y) * (param4.x - param3.x);
         if(_loc7_ == 0)
         {
            return false;
         }
         var _loc8_:Number = 1 / _loc7_;
         var _loc9_:Number = _loc5_ * _loc8_;
         var _loc10_:Number = _loc6_ * _loc8_;
         if(_loc9_ > 0 && _loc9_ < 1 && _loc10_ > 0 && _loc10_ < 1)
         {
            return true;
         }
         return false;
      }
      
      public static function isObjectOverlappingSegment(param1:Vector2D, param2:Vector2D, param3:Array) : Boolean
      {
         var _loc4_:int = 0;
         while(_loc4_ < param3.length)
         {
            if(isLineIntersecting(param1,param2,param3[_loc4_],param3[_loc4_ + 1]))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function circleArea(param1:Number) : Number
      {
         return Math.PI * param1 * param1;
      }
      
      public static function doesRayIntersectCircle(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Number) : Boolean
      {
         var _loc5_:Vector2D = param3.subtractedBy(param1);
         var _loc6_:Number = _loc5_.length;
         var _loc7_:Number = _loc5_.dot(param2);
         var _loc8_:Number = param4 * param4 - (_loc6_ * _loc6_ - _loc7_ * _loc7_);
         return _loc8_ < 0;
      }
      
      public static function isCircleOverlapping(param1:Vector2D, param2:Number, param3:Vector2D, param4:Number) : Boolean
      {
         var _loc5_:Number = param1.distanceSqTo(param3);
         var _loc6_:Number = param2 + param4;
         if(_loc5_ < _loc6_ * _loc6_)
         {
            return true;
         }
         return false;
      }
      
      public static function getLineCircleClosestIntersection(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Number, param5:Vector2D) : Boolean
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc6_:Vector2D = param2.subtractedBy(param1).normalized();
         var _loc7_:Vector2D = Transformations.pointToLocalSpace(param3,_loc6_,_loc6_.perp(),param1);
         var _loc8_:Boolean = false;
         if(_loc7_.x + param4 >= 0 && _loc7_.x - param4 <= param2.distanceSqTo(param1))
         {
            if(Math.abs(_loc7_.y) < param4)
            {
               _loc9_ = _loc7_.x;
               _loc10_ = _loc7_.y;
               _loc11_ = _loc9_ - Math.sqrt(param4 * param4 - _loc10_ * _loc10_);
               if(_loc11_ <= 0)
               {
                  _loc11_ = _loc9_ + Math.sqrt(param4 * param4 - _loc10_ * _loc10_);
               }
               _loc8_ = true;
               param5 = param1.addedTo(_loc6_.multipliedBy(_loc11_));
            }
         }
         return _loc8_;
      }
      
      public static function isPointInCircle(param1:Vector2D, param2:Number, param3:Vector2D) : Boolean
      {
         var _loc4_:Number = param3.subtractedBy(param1).lengthSq;
         if(_loc4_ < param2 * param2)
         {
            return true;
         }
         return false;
      }
      
      public static function getCircleIntersectionArea(param1:Vector2D, param2:Number, param3:Vector2D, param4:Number) : Number
      {
         if(!isCircleOverlapping(param1,param2,param3,param4))
         {
            return 0;
         }
         var _loc5_:Number = Math.sqrt((param1.x - param3.x) * (param1.x - param3.x) + (param1.y - param3.y) * (param1.y - param3.y));
         var _loc6_:Number = 2 * Math.acos((param4 * param4 + _loc5_ * _loc5_ - param2 * param2) / (param4 * _loc5_ * 2));
         var _loc7_:Number = 2 * Math.acos((param2 * param2 + _loc5_ * _loc5_ - param4 * param4) / (param2 * _loc5_ * 2));
         return 0.5 * _loc6_ * param4 * param4 - 0.5 * param4 * param4 * Math.sin(_loc6_) + 0.5 * _loc7_ * param2 * param2 - 0.5 * param2 * param2 * Math.sin(_loc7_);
      }
      
      public static function distToRayPlaneIntersect(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Vector2D) : Number
      {
         var _loc5_:Number = -param4.dot(param3);
         var _loc6_:Number = param4.dot(param1) + _loc5_;
         var _loc7_:Number = param4.dot(param2);
         if(_loc7_ < 0.00001 && _loc7_ > -0.00001)
         {
            return -1;
         }
         return -(_loc6_ / _loc7_);
      }
      
      public static function isObjectOverlapping(param1:Array, param2:Array) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         loop0:
         while(_loc3_ < param1.length)
         {
            _loc4_ = 0;
            while(true)
            {
               if(_loc4_ >= param2.length)
               {
                  _loc3_++;
                  continue loop0;
               }
               if(isLineIntersecting(param2[_loc4_],param2[_loc4_ + 1],param1[_loc3_],param1[_loc3_ + 1]))
               {
                  break;
               }
               _loc4_++;
            }
            return true;
         }
         return false;
      }
      
      public static function getTangentPoints(param1:Vector2D, param2:Number, param3:Vector2D, param4:Vector2D, param5:Vector2D) : Boolean
      {
         var _loc6_:Vector2D = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         _loc6_ = param3.subtractedBy(param1);
         var _loc7_:Number = _loc6_.lengthSq;
         var _loc8_:Number = param2 * param2;
         if(_loc7_ <= _loc8_)
         {
            return false;
         }
         _loc9_ = 1 / _loc7_;
         _loc10_ = Math.sqrt(Math.abs(_loc7_ - _loc8_));
         param4.x = param1.x + param2 * (param2 * _loc6_.x - _loc6_.y * _loc10_) * _loc9_;
         param4.y = param1.y + param2 * (param2 * _loc6_.y - _loc6_.x * _loc10_) * _loc9_;
         param5.x = param1.x + param2 * (param2 * _loc6_.x - _loc6_.y * _loc10_) * _loc9_;
         param5.y = param1.y + param2 * (param2 * _loc6_.y - _loc6_.x * _loc10_) * _loc9_;
         return true;
      }
      
      public static function isCircleOverlappingSegment(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Number) : Boolean
      {
         var _loc5_:Number = distToLineSegmentSq(param1,param2,param3);
         if(_loc5_ < param4 * param4)
         {
            return true;
         }
         return false;
      }
      
      public static function getCircleIntersectionPoints(param1:Vector2D, param2:Number, param3:Vector2D, param4:Number, param5:Vector2D, param6:Vector2D) : Boolean
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(!isCircleOverlapping(param1,param2,param3,param4))
         {
            return false;
         }
         _loc7_ = param1.distanceTo(param3);
         _loc8_ = (param2 - param4 + _loc7_ * _loc7_) / (2 * _loc7_);
         var _loc9_:Number = (param4 - param2 + _loc7_ * _loc7_) / (2 * _loc7_);
         var _loc10_:Vector2D = new Vector2D();
         _loc10_.x = param1.x + _loc8_ * (param3.x - param1.x) / _loc7_;
         _loc10_.y = param1.y + _loc8_ * (param3.y - param1.y) / _loc7_;
         var _loc11_:Number = Math.sqrt(param2 * param2 - _loc8_ * _loc8_);
         param5.x = _loc10_.x - _loc11_ * (param3.y - param1.y) / _loc7_;
         param5.y = _loc10_.y - _loc11_ * (param3.x - param1.x) / _loc7_;
         var _loc12_:Number = Math.sqrt(param4 * param4 - _loc8_ * _loc8_);
         param6.x = _loc10_.x - _loc12_ * (param3.y - param1.y) / _loc7_;
         param6.y = _loc10_.y - _loc12_ * (param3.x - param1.x) / _loc7_;
         return true;
      }
      
      public static function getRayCircleIntersect(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Number) : Number
      {
         var _loc5_:Vector2D = param3.subtractedBy(param1);
         var _loc6_:Number = _loc5_.length;
         var _loc7_:Number = _loc5_.dot(param2);
         var _loc8_:Number = param4 * param4 - (_loc6_ * _loc6_ - _loc7_ * _loc7_);
         if(_loc8_ < 0)
         {
            return -1;
         }
         return _loc7_ - Math.sqrt(_loc8_);
      }
      
      public static function distToLineSegmentSq(param1:Vector2D, param2:Vector2D, param3:Vector2D) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Vector2D = null;
         _loc4_ = (param3.x - param1.x) * (param2.x - param1.x) + (param3.y - param1.y) * (param2.y - param1.y);
         if(_loc4_ <= 0)
         {
            return param1.distanceSqTo(param3);
         }
         _loc5_ = (param3.x - param2.x) * (param1.x - param2.x) + (param3.y - param2.y) * (param1.y - param2.y);
         if(_loc5_ <= 0)
         {
            return param2.distanceSqTo(param3);
         }
         _loc6_ = param2.subtractedBy(param1);
         _loc6_.x *= _loc4_;
         _loc6_.y *= _loc4_;
         _loc6_.x /= _loc4_ + _loc5_;
         _loc6_.y /= _loc4_ + _loc5_;
         _loc6_.x += param1.x;
         _loc6_.y += param1.y;
         return param3.distanceSqTo(_loc6_);
      }
      
      public static function lineIntersection(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Vector2D, param5:Vector2D = null) : Number
      {
         var _loc6_:Number = (param1.y - param3.y) * (param4.x - param3.x) - (param1.x - param3.x) * (param4.y - param3.y);
         var _loc7_:Number = (param1.y - param3.y) * (param2.x - param1.x) - (param1.x - param3.x) * (param2.y - param1.y);
         var _loc8_:Number = (param2.x - param1.x) * (param4.y - param3.y) - (param2.y - param1.y) * (param4.x - param3.x);
         var _loc9_:Number = (param2.x - param1.x) * (param4.y - param3.y) - (param2.y - param1.y) * (param4.x - param3.x);
         if(_loc8_ == 0 || _loc9_ == 0)
         {
            return -1;
         }
         var _loc10_:Number = _loc6_ / _loc8_;
         var _loc11_:Number = _loc7_ / _loc9_;
         if(_loc10_ > 0 && _loc10_ < 1 && _loc11_ > 0 && _loc11_ < 1)
         {
            if(param5)
            {
               param5.x = param1.x + _loc10_ * (param2.x - param1.x);
               param5.y = param1.y + _loc10_ * (param2.y - param1.y);
            }
            return param1.distanceTo(param2) * _loc10_;
         }
         return 0;
      }
      
      public static function distToLineSegment(param1:Vector2D, param2:Vector2D, param3:Vector2D) : Number
      {
         var _loc4_:Number = (param3.x - param1.x) * (param2.x - param1.x) + (param3.y - param1.y) * (param2.y - param1.y);
         if(_loc4_ <= 0)
         {
            return param1.distanceTo(param3);
         }
         var _loc5_:Number = (param3.x - param2.x) * (param1.x - param2.x) + (param3.y - param2.y) * (param1.y - param2.y);
         if(_loc5_ <= 0)
         {
            return param2.distanceTo(param3);
         }
         var _loc6_:Vector2D = param2.subtractedBy(param1);
         _loc6_.times(_loc4_);
         _loc6_.divide(_loc4_ + _loc5_);
         _loc6_.plus(param1);
         return param3.distanceTo(_loc6_);
      }
      
      public static function whereIsPoint(param1:Vector2D, param2:Vector2D, param3:Vector2D) : int
      {
         var _loc4_:Vector2D = param2.subtractedBy(param1);
         var _loc5_:Number = _loc4_.dot(param3);
         if(_loc5_ < -0.00001)
         {
            return 1;
         }
         if(_loc5_ > 0.00001)
         {
            return -1;
         }
         return 0;
      }
   }
}

