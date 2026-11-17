package com.urbansquall.ginger.tools
{
   import com.urbansquall.ginger.Animation;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class AnimationBuilder
   {
      
      public function AnimationBuilder()
      {
         super();
      }
      
      public static function importStrip(param1:int, param2:BitmapData, param3:int, param4:int, param5:int = -1, param6:int = 0, param7:int = 0, param8:int = 1, param9:int = 0, param10:int = 0) : Animation
      {
         var _loc14_:Rectangle = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc11_:Animation = new Animation(param1,param8);
         var _loc12_:int = Math.ceil(param2.height / param4);
         var _loc13_:int = Math.ceil(param2.width / param3);
         if(param5 == -1)
         {
            param5 = _loc12_ * _loc13_;
         }
         var _loc15_:int = 0;
         while(_loc15_ < param5)
         {
            _loc16_ = _loc15_ % _loc13_;
            _loc17_ = Math.floor(_loc15_ / _loc13_);
            _loc14_ = new Rectangle(param6 + _loc16_ * param3,param7 + _loc17_ * param4,param3,param4);
            _loc11_.addFrame(1,param2,_loc14_,param9,param10);
            _loc15_++;
         }
         return _loc11_;
      }
      
      public static function importMovieClip(param1:int, param2:MovieClip, param3:int = 0, param4:int = 0, param5:int = 1, param6:* = 1, param7:* = 0, param8:int = 0, param9:int = 0) : *
      {
         var _loc11_:int = 0;
         var _loc20_:Rectangle = null;
         if(!(param6 is int) && !(param6 is String))
         {
            throw new Error("<AnimationBuilder::importMovieClip()> FrameStart must be of type (int) or (String).");
         }
         if(!(param7 is int) && !(param7 is String))
         {
            throw new Error("<AnimationBuilder::importMovieClip()> FrameEnd must be of type (int) or (String).");
         }
         if(param7 is int)
         {
            if(param7 > param2.totalFrames)
            {
               throw new Error("<AnimationBuilder::importMovieClip()> FrameEnd can not be greater than the total number of frames.");
            }
         }
         param2.gotoAndStop(param6);
         var _loc10_:int = param2.currentFrame;
         if(param7 == 0)
         {
            _loc11_ = param2.totalFrames;
         }
         else
         {
            param2.gotoAndStop(param7);
            _loc11_ = param2.currentFrame;
         }
         var _loc12_:Animation = new Animation(param1,param5);
         var _loc13_:Sprite = new Sprite();
         _loc13_.addChild(param2);
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = _loc10_;
         while(_loc16_ <= _loc11_)
         {
            param2.gotoAndStop(_loc16_);
            if(param2.width > _loc14_)
            {
               _loc14_ = param2.width;
            }
            if(param2.height > _loc15_)
            {
               _loc15_ = param2.height;
            }
            _loc16_++;
         }
         var _loc17_:int = param3 > 0 ? param3 : _loc14_;
         var _loc18_:int = param4 > 0 ? param4 : _loc15_;
         var _loc19_:BitmapData = new BitmapData(_loc17_,_loc18_,true,0);
         _loc16_ = _loc10_;
         while(_loc16_ <= _loc11_)
         {
            param2.gotoAndStop(_loc16_);
            param2.x = _loc17_ / 2;
            param2.y = _loc18_ / 2;
            _loc19_.fillRect(_loc19_.rect,0);
            _loc19_.draw(_loc13_);
            _loc20_ = new Rectangle(0,0,_loc17_,_loc18_);
            _loc12_.addFrame(1,_loc19_,_loc20_,param8,param9);
            _loc16_++;
         }
         return _loc12_;
      }
   }
}

