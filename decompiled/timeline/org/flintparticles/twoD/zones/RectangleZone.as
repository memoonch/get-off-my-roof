package org.flintparticles.twoD.zones
{
   import flash.geom.Point;
   
   public class RectangleZone implements Zone2D
   {
      
      private var _height:Number;
      
      private var _width:Number;
      
      private var _bottom:Number;
      
      private var _right:Number;
      
      private var _top:Number;
      
      private var _left:Number;
      
      public function RectangleZone(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         super();
         this._left = param1;
         this._top = param2;
         this._right = param3;
         this._bottom = param4;
         this._width = param3 - param1;
         this._height = param4 - param2;
      }
      
      public function getArea() : Number
      {
         return this._width * this._height;
      }
      
      public function get top() : Number
      {
         return this._top;
      }
      
      public function set bottom(param1:Number) : void
      {
         this._bottom = param1;
         if(!isNaN(this._top) && !isNaN(this._bottom))
         {
            this._height = this.bottom - this.top;
         }
      }
      
      public function get right() : Number
      {
         return this._right;
      }
      
      public function set left(param1:Number) : void
      {
         this._left = param1;
         if(!isNaN(this._right) && !isNaN(this._left))
         {
            this._width = this.right - this.left;
         }
      }
      
      public function get left() : Number
      {
         return this._left;
      }
      
      public function set top(param1:Number) : void
      {
         this._top = param1;
         if(!isNaN(this._top) && !isNaN(this._bottom))
         {
            this._height = this.bottom - this.top;
         }
      }
      
      public function contains(param1:Number, param2:Number) : Boolean
      {
         return param1 >= this._left && param1 <= this._right && param2 >= this._top && param2 <= this._bottom;
      }
      
      public function get bottom() : Number
      {
         return this._bottom;
      }
      
      public function set right(param1:Number) : void
      {
         this._right = param1;
         if(!isNaN(this._right) && !isNaN(this._left))
         {
            this._width = this.right - this.left;
         }
      }
      
      public function getLocation() : Point
      {
         return new Point(this._left + Math.random() * this._width,this._top + Math.random() * this._height);
      }
   }
}

