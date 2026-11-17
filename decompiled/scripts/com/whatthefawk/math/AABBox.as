package com.whatthefawk.math
{
   public class AABBox
   {
      
      public var width:Number;
      
      public var left:Number;
      
      public var topRight:Vector2D;
      
      public var bottomLeft:Vector2D;
      
      public var halfWidth:Number;
      
      public var top:Number;
      
      public var right:Number;
      
      public var height:Number;
      
      public var bottom:Number;
      
      public var center:Vector2D;
      
      public var bottomRight:Vector2D;
      
      public var halfHeight:Number;
      
      public var topLeft:Vector2D;
      
      public function AABBox(param1:Vector2D, param2:Number, param3:Number)
      {
         super();
         this.center = new Vector2D(param1.x,param1.y);
         this.width = param2;
         this.height = param3;
         this.halfWidth = param2 * 0.5;
         this.halfHeight = param3 * 0.5;
         this.left = param1.x - this.halfWidth;
         this.right = param1.x + this.halfWidth;
         this.top = param1.y - this.halfHeight;
         this.bottom = param1.y + this.halfHeight;
         this.topLeft = new Vector2D(this.left,this.top);
         this.topRight = new Vector2D(this.right,this.top);
         this.bottomRight = new Vector2D(this.right,this.bottom);
         this.bottomLeft = new Vector2D(this.left,this.bottom);
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this.width = param1;
         this.height = param2;
         this.halfWidth = param1 * 0.5;
         this.halfHeight = param2 * 0.5;
         this.left = this.center.x - this.halfWidth;
         this.right = this.center.x + this.halfWidth;
         this.top = this.center.y - this.halfHeight;
         this.bottom = this.center.y + this.halfHeight;
         this.topLeft.x = this.left;
         this.topLeft.y = this.top;
         this.topRight.x = this.right;
         this.topRight.y = this.top;
         this.bottomRight.x = this.right;
         this.bottomRight.y = this.bottom;
         this.bottomLeft.x = this.left;
         this.bottomLeft.y = this.bottom;
      }
      
      public function set(param1:Vector2D, param2:Number, param3:Number) : void
      {
         this.center.x = param1.x;
         this.center.y = param1.y;
         this.width = param2;
         this.height = param3;
         this.halfWidth = param2 * 0.5;
         this.halfHeight = param3 * 0.5;
         this.left = param1.x - this.halfWidth;
         this.right = param1.x + this.halfWidth;
         this.top = param1.y - this.halfHeight;
         this.bottom = param1.y + this.halfHeight;
         this.topLeft.x = this.left;
         this.topLeft.y = this.top;
         this.topRight.x = this.right;
         this.topRight.y = this.top;
         this.bottomRight.x = this.right;
         this.bottomRight.y = this.bottom;
         this.bottomLeft.x = this.left;
         this.bottomLeft.y = this.bottom;
      }
      
      public function moveTo(param1:Vector2D) : void
      {
         this.center.x = param1.x;
         this.center.y = param1.y;
         this.left = this.center.x - this.halfWidth;
         this.right = this.center.x + this.halfWidth;
         this.top = this.center.y - this.halfHeight;
         this.bottom = this.center.y + this.halfHeight;
         this.topLeft.x = this.left;
         this.topLeft.y = this.top;
         this.topRight.x = this.right;
         this.topRight.y = this.top;
         this.bottomRight.x = this.right;
         this.bottomRight.y = this.bottom;
         this.bottomLeft.x = this.left;
         this.bottomLeft.y = this.bottom;
      }
      
      public function isOverlapping(param1:AABBox) : Boolean
      {
         return !(param1.top > this.bottom || param1.bottom < this.top || param1.left > this.right || param1.right < this.left);
      }
   }
}

