package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class PointZone implements Zone2D
   {
      
      private var _point:Point;
      
      public function PointZone(param1:Point = null)
      {
         super();
         if(param1 == null)
         {
            this._point = new Point(0,0);
         }
         else
         {
            this._point = param1;
         }
      }
      
      public function set point(param1:Point) : void
      {
         this._point = param1;
      }
      
      public function getArea() : Number
      {
         return 1;
      }
      
      public function getLocation() : Point
      {
         return this._point.clone();
      }
      
      public function get point() : Point
      {
         return this._point;
      }
      
      public function set y(param1:Number) : void
      {
         this._point.y = param1;
      }
      
      public function set x(param1:Number) : void
      {
         this._point.x = param1;
      }
      
      public function get x() : Number
      {
         return this._point.x;
      }
      
      public function get y() : Number
      {
         return this._point.y;
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         return this._point.x == param1 && this._point.y == param2;
      }
   }
}

