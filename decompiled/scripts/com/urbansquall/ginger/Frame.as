package com.urbansquall.ginger
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   internal class Frame
   {
      
      public var offsetX:Array;
      
      public var width:Array;
      
      public var height:Array;
      
      public var frameID:String;
      
      public var offsetY:Array;
      
      public var numFrames:int;
      
      public var bitmapData:Array;
      
      private var m_debugID:Number;
      
      public function Frame(param1:int, param2:BitmapData, param3:int, param4:String, param5:Number = 0, param6:Number = 0)
      {
         super();
         this.m_debugID = Math.random();
         this.numFrames = param1;
         this.frameID = param4;
         this.bitmapData = [];
         this.width = [];
         this.height = [];
         this.offsetX = [];
         this.offsetY = [];
         if(param3 == 1)
         {
            this.createFrameWithNoRotation(param2,param5,param6);
         }
         else
         {
            this.createRotatedFrame(param2,param3,param5,param6);
         }
      }
      
      private function createRotatedFrame(param1:BitmapData, param2:int, param3:Number = 0, param4:Number = 0) : void
      {
         var _loc5_:int = Math.max(Math.abs(param3),param3 + param1.width);
         var _loc6_:int = Math.max(Math.abs(param4),param4 + param1.height);
         var _loc7_:Number = _loc5_ * Math.SQRT2;
         var _loc8_:Number = _loc6_ * Math.SQRT2;
         var _loc9_:Number = Math.max(_loc7_,_loc8_);
         var _loc10_:Number = Math.ceil(Math.max(_loc5_ * 2,_loc6_ * 2) * Math.SQRT2);
         var _loc11_:Matrix = new Matrix(1,0,0,1,_loc9_,_loc9_);
         var _loc12_:BitmapData = new BitmapData(_loc10_,_loc10_,true,0);
         var _loc13_:Sprite = new Sprite();
         var _loc14_:Sprite = new Sprite();
         var _loc15_:BitmapData = new BitmapData(_loc5_,_loc6_,true,0);
         var _loc16_:Bitmap = new Bitmap(param1,PixelSnapping.ALWAYS,true);
         _loc16_.x = param3;
         _loc16_.y = param4;
         _loc14_.addChild(_loc16_);
         _loc13_.addChild(_loc14_);
         var _loc17_:int = 0;
         while(_loc17_ < param2)
         {
            _loc12_.fillRect(_loc12_.rect,0);
            _loc12_.draw(_loc13_,_loc11_);
            this.bitmapData[_loc17_] = _loc12_.clone();
            this.width[_loc17_] = _loc14_.width;
            this.height[_loc17_] = _loc14_.height;
            this.offsetX[_loc17_] = _loc9_;
            this.offsetY[_loc17_] = _loc9_;
            _loc14_.rotation += 360 / param2;
            _loc17_++;
         }
      }
      
      public function toString() : String
      {
         return "<Frame (" + this.m_debugID + ") bitmapData:" + this.bitmapData.length + " numFrames:" + this.numFrames + " frameID:" + this.frameID + " offsetX:" + this.offsetX + " offsetY:" + this.offsetY + ">";
      }
      
      private function createFrameWithNoRotation(param1:BitmapData, param2:Number = 0, param3:Number = 0) : void
      {
         this.bitmapData.push(param1);
         this.width.push(param1.width);
         this.height.push(param1.height);
         this.offsetX.push(-param2);
         this.offsetY.push(-param3);
      }
   }
}

