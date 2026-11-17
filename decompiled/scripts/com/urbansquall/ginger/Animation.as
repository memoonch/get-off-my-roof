package com.urbansquall.ginger
{
   import flash.display.BitmapData;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class Animation extends EventDispatcher
   {
      
      public static const POINT:Point = new Point();
      
      internal var m_frameMap:Dictionary;
      
      private var m_totalFrames:int;
      
      private var m_isLooping:Boolean = false;
      
      internal var m_framesOfRotation:int;
      
      private var m_isPausedOnLastFrame:Boolean = false;
      
      internal var m_fps:int;
      
      internal var m_frames:Array;
      
      internal var m_degToRotBy:Number;
      
      public function Animation(param1:int, param2:int = 1)
      {
         super();
         this.m_frames = [];
         this.m_frameMap = new Dictionary();
         this.m_fps = param1;
         this.m_framesOfRotation = param2;
         if(this.m_framesOfRotation < 1)
         {
            this.m_framesOfRotation = 1;
         }
         this.m_degToRotBy = 360 / this.m_framesOfRotation;
      }
      
      public function get isPausedOnLastFrame() : Boolean
      {
         return this.m_isPausedOnLastFrame;
      }
      
      public function get totalFrames() : int
      {
         return this.m_totalFrames;
      }
      
      public function addFrame(param1:int, param2:BitmapData, param3:Rectangle, param4:Number = 0, param5:Number = 0, param6:String = null) : BitmapData
      {
         if(param6 == "")
         {
            param6 = null;
         }
         var _loc7_:BitmapData = new BitmapData(param3.width,param3.height,true,0);
         _loc7_.copyPixels(param2,param3,POINT);
         this.m_frames.push(new Frame(param1,_loc7_,this.m_framesOfRotation,param6,param4,param5));
         if(param6 != null)
         {
            this.m_frameMap[param6] = this.m_totalFrames;
         }
         ++this.m_totalFrames;
         return this.m_frames[this.m_frames.length - 1].bitmapData[0];
      }
      
      public function set isLooping(param1:Boolean) : void
      {
         this.m_isLooping = param1;
      }
      
      public function get isLooping() : Boolean
      {
         return this.m_isLooping;
      }
      
      public function set isPausedOnLastFrame(param1:Boolean) : void
      {
         this.m_isPausedOnLastFrame = param1;
      }
   }
}

