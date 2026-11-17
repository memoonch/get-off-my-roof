package com.whatthefawk.math
{
   import flash.geom.Point;
   
   public class Average
   {
      
      public static const NUMBER:int = 1;
      
      public static const POINT:int = 2;
      
      public static const VECTOR:int = 3;
      
      private var m_average:*;
      
      private var m_type:int;
      
      private var m_values:Array;
      
      private var m_samples:int;
      
      public function Average(param1:int = 5)
      {
         super();
         this.m_values = [];
         this.m_samples = param1;
      }
      
      public function get values() : Array
      {
         return this.m_values;
      }
      
      public function set values(param1:Array) : void
      {
         var _loc2_:* = undefined;
         for(_loc2_ in param1)
         {
            this.addValue(param1[_loc2_]);
         }
      }
      
      private function calcAvgNumber() : Number
      {
         var _loc2_:* = undefined;
         var _loc1_:Number = 0;
         for(_loc2_ in this.values)
         {
            _loc1_ += this.values[_loc2_];
         }
         return _loc1_ / this.values.length;
      }
      
      public function get samples() : int
      {
         return this.m_samples;
      }
      
      private function calcAverage() : *
      {
         switch(this.type)
         {
            case Average.NUMBER:
               this.m_average = this.calcAvgNumber();
               break;
            case Average.POINT:
               this.m_average = this.calcAvgPoint();
               break;
            case Average.VECTOR:
               this.m_average = this.calcAvgVector2D();
               break;
            default:
               throw new Error("<Average::calcAverage> Unknown Value Type.");
         }
         return this.m_average;
      }
      
      public function addValue(param1:*) : *
      {
         if(this.setType(param1))
         {
            if(this.values.length >= this.samples)
            {
               this.values.shift();
            }
            this.values.push(param1);
         }
         return this.calcAverage();
      }
      
      public function set samples(param1:int) : void
      {
         this.m_samples = param1;
      }
      
      private function calcAvgPoint() : Point
      {
         var _loc2_:* = undefined;
         var _loc1_:Point = new Point();
         for(_loc2_ in this.values)
         {
            _loc1_.add(this.values[_loc2_]);
         }
         _loc1_.x /= this.values.length;
         _loc1_.y /= this.values.length;
         return _loc1_;
      }
      
      private function calcAvgVector2D() : Vector2D
      {
         var _loc2_:* = undefined;
         var _loc1_:Vector2D = new Vector2D();
         for(_loc2_ in this.values)
         {
            _loc1_.plus(this.values[_loc2_]);
         }
         return _loc1_.divide(this.values.length);
      }
      
      public function get type() : int
      {
         return this.m_type;
      }
      
      private function setType(param1:*) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 is Number)
         {
            _loc2_ = Average.NUMBER;
         }
         else if(param1 is Point)
         {
            _loc2_ = Average.POINT;
         }
         else
         {
            if(!(param1 is Vector2D))
            {
               throw new Error("<Average::setType> Value entered is not a valid type: Number, Point, Vector2D.");
            }
            _loc2_ = Average.VECTOR;
         }
         if(this.values.length > 0)
         {
            if(_loc2_ != this.type)
            {
               throw new Error("<Average::setType> Value type can NOT be changed, unless this ValueSmoother is reset.");
            }
         }
         this.m_type = _loc2_;
         return true;
      }
      
      public function get average() : *
      {
         return this.m_average;
      }
      
      public function reset(param1:Number = NaN) : *
      {
         this.m_type = NaN;
         this.m_average = NaN;
         this.m_values = [];
         this.m_samples = isNaN(param1) ? this.m_samples : int(param1);
      }
   }
}

