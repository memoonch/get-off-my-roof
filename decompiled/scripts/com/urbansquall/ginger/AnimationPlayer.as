package com.urbansquall.ginger
{
   import com.urbansquall.ginger.events.AnimationEvent;
   import com.urbansquall.ginger.events.FrameEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AnimationPlayer extends Sprite
   {
      
      private var m_timeSinceLastUpdate:int;
      
      private var m_framesMap:Dictionary;
      
      private var m_hasAnimationEnded:Boolean;
      
      private var m_currentFrame:Frame;
      
      private var m_animationQueue:Array;
      
      private var m_rotation:Number = 0;
      
      private var m_desiredY:Number = 0;
      
      private var m_currentAnimationID:String;
      
      private var m_isPausedOnLastFrame:Boolean;
      
      private var m_currentAnimation:Animation;
      
      private var m_IDArray:Array;
      
      private var m_fps:int;
      
      private var m_defaultAnimationID:String;
      
      private var m_desiredX:Number = 0;
      
      private var m_totalFrames:int;
      
      private var m_rotationFrame:int;
      
      private var m_frames:Array;
      
      private var m_bitmap:Bitmap;
      
      private var m_hasRotationChanged:Boolean;
      
      private var m_framesPassed:int;
      
      private var m_isPlaying:Boolean;
      
      private var m_timerInterval:int = 0;
      
      private var m_isLooping:Boolean;
      
      private var m_animationMap:Dictionary;
      
      private var m_animationDelay:int;
      
      private var m_timer:Timer;
      
      private var m_frameIndex:int;
      
      public function AnimationPlayer()
      {
         super();
         this.m_IDArray = [];
         this.m_animationQueue = [];
         this.m_frames = [];
         this.m_animationMap = new Dictionary();
         this.m_framesMap = new Dictionary();
         this.m_bitmap = new Bitmap(null,"never",false);
         addChild(this.m_bitmap);
      }
      
      public function togglePause() : void
      {
         if(this.m_currentAnimation != null)
         {
            this.m_isPlaying = !this.m_isPlaying;
         }
      }
      
      public function isPaused() : Boolean
      {
         return this.m_isPlaying;
      }
      
      public function startSelfTick(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         this.stopSelfTick();
         this.m_timerInterval = param1;
         this.m_timer = new Timer(this.m_timerInterval);
         this.m_timer.addEventListener(TimerEvent.TIMER,this.tickTimer,false,0,true);
         this.m_timer.start();
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.handleRemovedFromStage,false,0,true);
      }
      
      override public function set width(param1:Number) : void
      {
         throw new Error("<AnimationPlayer> Width / Height cannot be changed!");
      }
      
      public function queue(param1:String) : void
      {
         var _loc2_:Animation = this.m_animationMap[param1];
         if(_loc2_ == null)
         {
            throw new Error("<AnimationPlayer> Invalid Animation ID!");
         }
         this.m_animationQueue.push(param1);
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         this.performOffset();
      }
      
      public function get defaultAnimationID() : String
      {
         return this.m_defaultAnimationID;
      }
      
      public function dispose() : void
      {
         this.m_currentFrame = null;
         this.m_frames = null;
         this.m_framesMap = null;
         this.m_IDArray = null;
         this.m_currentAnimation = null;
         this.m_animationMap = null;
         this.m_animationQueue = null;
         this.m_bitmap = null;
         this.m_timer = null;
      }
      
      private function updateFrame() : void
      {
         if(this.m_currentFrame == null)
         {
            return;
         }
         ++this.m_framesPassed;
         if(this.m_framesPassed >= this.m_currentFrame.numFrames)
         {
            this.m_framesPassed = 0;
            if(++this.m_frameIndex >= this.m_totalFrames)
            {
               if(!this.m_isLooping)
               {
                  this.m_hasAnimationEnded = true;
                  return;
               }
               this.m_frameIndex = 0;
            }
            this.m_currentFrame = Frame(this.m_frames[this.m_frameIndex]);
            this.m_bitmap.bitmapData = this.m_currentFrame.bitmapData[this.m_rotationFrame];
            this.performOffset();
            if(this.m_currentFrame.frameID != null)
            {
               if(hasEventListener(FrameEvent.CHANGE))
               {
                  dispatchEvent(new FrameEvent(FrameEvent.CHANGE,true,this.m_currentFrame.frameID,this.m_currentAnimationID));
               }
            }
         }
      }
      
      public function get offsetX() : Number
      {
         return this.m_currentFrame.offsetX[this.m_rotationFrame];
      }
      
      public function get offsetY() : Number
      {
         return this.m_currentFrame.offsetY[this.m_rotationFrame];
      }
      
      override public function get height() : Number
      {
         return this.m_currentFrame.height[this.m_rotationFrame];
      }
      
      private function tickTimer(param1:TimerEvent) : void
      {
         this.update(this.m_timerInterval);
      }
      
      public function stopSelfTick() : void
      {
         if(this.m_timer != null)
         {
            this.removeEventListener(Event.REMOVED_FROM_STAGE,this.handleRemovedFromStage,false);
            this.m_timer.removeEventListener(TimerEvent.TIMER,this.tickTimer,false);
            this.m_timer.stop();
            this.m_timer = null;
         }
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
         this.performOffset();
      }
      
      public function get animationIDs() : Array
      {
         return this.m_IDArray.slice();
      }
      
      public function play(param1:String) : void
      {
         if(this.m_animationMap[param1] == null)
         {
            throw new Error("<AnimationPlayer> Invalid Animation ID [" + param1 + "]");
         }
         this.m_isPlaying = true;
         this.m_hasAnimationEnded = false;
         this.m_animationQueue = [this.m_currentAnimation];
         this.startNewAnimation(param1);
      }
      
      private function handleRemovedFromStage(param1:Event) : void
      {
         this.stopSelfTick();
      }
      
      public function set defaultAnimationID(param1:String) : void
      {
         this.m_defaultAnimationID = param1;
      }
      
      override public function get width() : Number
      {
         return this.m_currentFrame.width[this.m_rotationFrame];
      }
      
      public function update(param1:Number) : void
      {
         if(this.m_hasAnimationEnded)
         {
            if(hasEventListener(AnimationEvent.CHANGE))
            {
               dispatchEvent(new AnimationEvent(AnimationEvent.CHANGE,false,this.m_currentAnimationID));
            }
            if(this.m_isPausedOnLastFrame)
            {
               this.m_isPlaying = false;
            }
            else if(this.m_isLooping)
            {
               this.startNewAnimation(this.m_animationQueue[0]);
            }
            else if(this.m_animationQueue.length <= 1)
            {
               this.m_animationQueue.splice(0);
               if(this.m_currentAnimationID == this.m_defaultAnimationID)
               {
                  this.m_isPlaying = false;
               }
               else
               {
                  this.startNewAnimation(this.m_defaultAnimationID);
               }
            }
            else
            {
               this.m_animationQueue.shift();
               this.startNewAnimation(this.m_animationQueue[0]);
            }
            this.m_hasAnimationEnded = false;
         }
         else if(this.m_hasRotationChanged)
         {
            this.m_bitmap.bitmapData = this.m_currentFrame.bitmapData[this.m_rotationFrame];
            this.m_hasRotationChanged = false;
         }
         if(this.m_isPlaying)
         {
            this.m_timeSinceLastUpdate += param1;
            if(this.m_timeSinceLastUpdate >= this.m_animationDelay)
            {
               this.m_timeSinceLastUpdate -= this.m_animationDelay;
               this.updateFrame();
            }
         }
      }
      
      public function gotoFrame(param1:String, param2:String = null) : void
      {
         if(param2 != null)
         {
            this.startNewAnimation(param2);
         }
         var _loc3_:int = int(this.m_framesMap[param1]);
         this.m_currentFrame = Frame(this.m_frames[_loc3_]);
         this.performOffset();
         this.m_bitmap.bitmapData = this.m_currentFrame.bitmapData[this.m_rotationFrame] as BitmapData;
         this.m_frameIndex = _loc3_;
         this.m_framesPassed = 0;
         this.m_isPlaying = false;
         if(this.m_currentFrame.frameID != null)
         {
            if(hasEventListener(FrameEvent.CHANGE))
            {
               dispatchEvent(new FrameEvent(FrameEvent.CHANGE,true,this.m_currentFrame.frameID,this.m_currentAnimationID));
            }
         }
      }
      
      private function startNewAnimation(param1:String) : void
      {
         this.m_timeSinceLastUpdate = 0;
         this.m_currentAnimationID = param1;
         this.m_currentAnimation = this.m_animationMap[this.m_currentAnimationID];
         if(this.m_currentAnimation == null)
         {
            this.m_currentAnimationID = this.m_defaultAnimationID;
            this.m_currentAnimation = this.m_animationMap[this.m_currentAnimationID];
         }
         this.fps = this.m_currentAnimation.m_fps;
         this.m_frames = this.m_currentAnimation.m_frames;
         this.m_framesMap = this.m_currentAnimation.m_frameMap;
         this.m_isLooping = this.m_currentAnimation.isLooping;
         this.m_isPausedOnLastFrame = this.m_currentAnimation.isPausedOnLastFrame;
         this.m_totalFrames = this.m_frames.length;
         this.m_frameIndex = 0;
         this.m_currentFrame = Frame(this.m_frames[0]);
         this.m_bitmap.bitmapData = this.m_currentFrame.bitmapData[this.m_rotationFrame];
         this.performOffset();
         if(hasEventListener(AnimationEvent.CHANGE))
         {
            dispatchEvent(new AnimationEvent(AnimationEvent.CHANGE,true,this.m_currentAnimationID));
         }
      }
      
      override public function set height(param1:Number) : void
      {
         throw new Error("<AnimationPlayer> Width / Height cannot be changed!");
      }
      
      public function set fps(param1:int) : void
      {
         this.m_fps = param1;
         if(param1 <= 0)
         {
            this.m_fps = 0;
            this.m_animationDelay = 0;
         }
         else
         {
            this.m_fps = param1;
            this.m_animationDelay = 1000 / param1;
         }
      }
      
      private function performOffset() : void
      {
         var _loc1_:int = -1;
         var _loc2_:int = -1;
         if(scaleX < 0)
         {
            _loc1_ = 1;
         }
         if(scaleY < 0)
         {
            _loc2_ = 1;
         }
         super.x = this.m_desiredX + _loc1_ * this.offsetX;
         super.y = this.m_desiredY + _loc2_ * this.offsetY;
      }
      
      public function addAnimation(param1:String, param2:Animation) : void
      {
         this.m_IDArray.push(param1);
         this.m_animationMap[param1] = param2;
         if(this.m_defaultAnimationID == null)
         {
            this.m_defaultAnimationID = param1;
            this.play(param1);
            this.performOffset();
         }
      }
      
      public function get currentAnimationID() : String
      {
         return this.m_currentAnimationID;
      }
      
      public function get fps() : int
      {
         return this.m_fps;
      }
      
      override public function set y(param1:Number) : void
      {
         this.m_desiredY = param1;
         this.performOffset();
      }
      
      public function copy() : AnimationPlayer
      {
         var _loc3_:String = null;
         var _loc1_:AnimationPlayer = new AnimationPlayer();
         var _loc2_:int = int(this.m_IDArray.length);
         while(--_loc2_ > -1)
         {
            _loc3_ = this.m_IDArray[_loc2_];
            _loc1_.addAnimation(_loc3_,this.m_animationMap[_loc3_]);
         }
         _loc1_.defaultAnimationID = this.m_defaultAnimationID;
         _loc1_.fps = this.m_fps;
         _loc1_.play(this.m_defaultAnimationID);
         _loc1_.m_bitmap.bitmapData = this.m_bitmap.bitmapData;
         return _loc1_;
      }
      
      public function pause() : void
      {
         this.m_isPlaying = false;
      }
      
      override public function get x() : Number
      {
         return this.m_desiredX;
      }
      
      override public function get y() : Number
      {
         return this.m_desiredY;
      }
      
      override public function set rotation(param1:Number) : void
      {
         this.m_rotation = int(param1);
         this.m_rotation %= 360;
         if(this.m_rotation < 0)
         {
            this.m_rotation += 360;
         }
         this.m_rotationFrame = Math.round(this.m_rotation / this.m_currentAnimation.m_degToRotBy);
         if(this.m_rotationFrame >= this.m_currentAnimation.m_framesOfRotation)
         {
            this.m_rotationFrame = 0;
         }
         this.performOffset();
         this.m_hasRotationChanged = true;
      }
      
      public function unpause() : void
      {
         if(this.m_currentAnimation != null)
         {
            this.m_isPlaying = true;
         }
      }
      
      override public function get rotation() : Number
      {
         return this.m_rotation;
      }
      
      override public function set x(param1:Number) : void
      {
         this.m_desiredX = param1;
         this.performOffset();
      }
   }
}

