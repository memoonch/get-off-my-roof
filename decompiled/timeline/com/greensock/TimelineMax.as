package com.greensock
{
   import com.greensock.core.*;
   import com.greensock.events.TweenEvent;
   import flash.events.*;
   import flash.utils.*;
   
   public class TimelineMax extends TimelineLite implements IEventDispatcher
   {
      
      public static const version:Number = 1.03;
      
      protected var _cyclesComplete:uint;
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _hasUpdateListener:Boolean;
      
      public var yoyo:Boolean;
      
      protected var _repeatDelay:Number;
      
      protected var _repeat:int;
      
      public function TimelineMax(param1:Object = null)
      {
         super(param1);
         this._repeat = int(this.vars.repeat) || 0;
         this._repeatDelay = Number(this.vars.repeatDelay) || 0;
         this._cyclesComplete = 0;
         this.yoyo = Boolean(this.vars.yoyo);
         this.cacheIsDirty = true;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
         {
            this.initDispatcher();
         }
      }
      
      private static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 / param4;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._dispatcher == null ? false : this._dispatcher.dispatchEvent(param1);
      }
      
      public function get currentLabel() : String
      {
         return this.getLabelBefore(this.cachedTime + 1e-8);
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc6_:TweenCore = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:TweenCore = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         if(this.gc)
         {
            this.setEnabled(true,false);
         }
         else if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         var _loc4_:Number = this.cacheIsDirty ? this.totalDuration : this.cachedTotalDuration;
         var _loc5_:Number = this.cachedTime;
         if(param1 >= _loc4_)
         {
            if(_rawPrevTime <= _loc4_ && _rawPrevTime != param1)
            {
               if(!this.cachedReversed && this.yoyo && this._repeat % 2 != 0)
               {
                  forceChildrenToBeginning(0,param2);
                  this.cachedTime = 0;
               }
               else
               {
                  forceChildrenToEnd(this.cachedDuration,param2);
                  this.cachedTime = this.cachedDuration;
               }
               this.cachedTotalTime = _loc4_;
               _loc7_ = !this.hasPausedChild();
               _loc8_ = true;
               if(this.cachedDuration == 0 && _loc7_ && (param1 == 0 || _rawPrevTime < 0))
               {
                  param3 = true;
               }
            }
         }
         else if(param1 <= 0)
         {
            if(param1 < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0 && _rawPrevTime > 0)
               {
                  param3 = true;
                  _loc7_ = true;
               }
            }
            if(_rawPrevTime >= 0 && _rawPrevTime != param1)
            {
               this.cachedTotalTime = 0;
               if(!this.cachedReversed && this.yoyo && this._repeat % 2 != 0)
               {
                  forceChildrenToEnd(this.cachedDuration,param2);
                  this.cachedTime = this.cachedDuration;
               }
               else
               {
                  forceChildrenToBeginning(0,param2);
                  this.cachedTime = 0;
               }
               _loc8_ = true;
               if(this.cachedReversed)
               {
                  _loc7_ = true;
               }
            }
         }
         else
         {
            this.cachedTotalTime = this.cachedTime = param1;
         }
         _rawPrevTime = param1;
         if(this._repeat != 0)
         {
            _loc12_ = this.cachedDuration + this._repeatDelay;
            if(_loc7_)
            {
               if(this.yoyo && Boolean(this._repeat % 2))
               {
                  this.cachedTime = 0;
               }
            }
            else if(param1 > 0)
            {
               this.cachedTime = this.yoyo && this.cachedTotalTime / _loc12_ % 2 >= 1 || !this.yoyo && !(this.cachedTotalTime / _loc12_ % 1) ? this.cachedDuration - this.cachedTotalTime % _loc12_ : this.cachedTotalTime % _loc12_;
               if(this.cachedTime >= this.cachedDuration)
               {
                  this.cachedTime = this.cachedDuration;
               }
               else if(this.cachedTime <= 0)
               {
                  this.cachedTime = 0;
               }
            }
            if(this._cyclesComplete != int(this.cachedTotalTime / _loc12_) && !_loc7_ && (this.cachedTime != _loc5_ || param3))
            {
               _loc9_ = true;
               _loc13_ = int(this._cyclesComplete);
               this._cyclesComplete = int(this.cachedTotalTime / _loc12_);
               _loc14_ = Boolean(!this.yoyo || this._cyclesComplete % 2 == 0);
               _loc15_ = Boolean(!this.yoyo || _loc13_ % 2 == 0);
               _loc16_ = Boolean(_loc14_ == _loc15_);
               if(_loc13_ > this._cyclesComplete)
               {
                  _loc15_ = !_loc15_;
               }
               if(_loc15_)
               {
                  _loc5_ = forceChildrenToEnd(this.cachedDuration,param2);
                  if(_loc16_)
                  {
                     _loc5_ = forceChildrenToBeginning(0,true);
                  }
               }
               else
               {
                  _loc5_ = forceChildrenToBeginning(0,param2);
                  if(_loc16_)
                  {
                     _loc5_ = forceChildrenToEnd(this.cachedDuration,true);
                  }
               }
               _loc8_ = false;
            }
         }
         if(this.cachedTime == _loc5_ && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            this.initted = true;
         }
         if(_loc5_ == 0 && this.cachedTotalTime != 0 && !param2)
         {
            if(this.vars.onStart)
            {
               this.vars.onStart.apply(null,this.vars.onStartParams);
            }
            if(this._dispatcher)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
            }
         }
         if(!_loc8_)
         {
            if(this.cachedTime - _loc5_ > 0)
            {
               _loc6_ = _firstChild;
               while(_loc6_)
               {
                  _loc10_ = _loc6_.nextNode;
                  if(_loc6_.active || !_loc6_.cachedPaused && _loc6_.cachedStartTime <= this.cachedTime)
                  {
                     if(!_loc6_.cachedReversed)
                     {
                        _loc6_.renderTime((this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                     }
                     else
                     {
                        _loc11_ = _loc6_.cacheIsDirty ? _loc6_.totalDuration : _loc6_.cachedTotalDuration;
                        _loc6_.renderTime(_loc11_ - (this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                     }
                  }
                  _loc6_ = _loc10_;
               }
            }
            else
            {
               _loc6_ = _lastChild;
               while(_loc6_)
               {
                  _loc10_ = _loc6_.prevNode;
                  if(_loc6_.active || !_loc6_.cachedPaused && _loc6_.cachedStartTime <= _loc5_)
                  {
                     if(!_loc6_.cachedReversed)
                     {
                        _loc6_.renderTime((this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                     }
                     else
                     {
                        _loc11_ = _loc6_.cacheIsDirty ? _loc6_.totalDuration : _loc6_.cachedTotalDuration;
                        _loc6_.renderTime(_loc11_ - (this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                     }
                  }
                  _loc6_ = _loc10_;
               }
            }
         }
         if(_hasUpdate && !param2)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(this._hasUpdateListener && !param2)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
         }
         if(_loc7_)
         {
            this.complete(true,param2);
         }
         else if(_loc9_ && !param2)
         {
            if(this.vars.onRepeat)
            {
               this.vars.onRepeat.apply(null,this.vars.onRepeatParams);
            }
            if(this._dispatcher)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
            }
         }
      }
      
      public function addCallback(param1:Function, param2:*, param3:Array = null) : TweenLite
      {
         var _loc4_:TweenLite = new TweenLite(param1,0,{
            "onComplete":param1,
            "onCompleteParams":param3,
            "overwrite":0,
            "immediateRender":false
         });
         insert(_loc4_,param2);
         return _loc4_;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         this._repeatDelay = param1;
         setDirtyCache(true);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(this._dispatcher != null)
         {
            this._dispatcher.removeEventListener(param1,param2,param3);
         }
      }
      
      override public function set currentTime(param1:Number) : void
      {
         if(this._cyclesComplete == 0)
         {
            setTotalTime(param1,false);
         }
         else if(this.yoyo && this._cyclesComplete % 2 == 1)
         {
            setTotalTime(this.duration - param1 + this._cyclesComplete * (this.cachedDuration + this._repeatDelay),false);
         }
         else
         {
            setTotalTime(param1 + this._cyclesComplete * (this.duration + this._repeatDelay),false);
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(this._dispatcher == null)
         {
            this.initDispatcher();
         }
         if(param1 == TweenEvent.UPDATE)
         {
            this._hasUpdateListener = true;
         }
         this._dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function tweenTo(param1:*, param2:Object = null) : TweenLite
      {
         var _loc4_:String = null;
         var _loc3_:Object = {
            "ease":easeNone,
            "overwrite":2,
            "useFrames":this.useFrames
         };
         for(_loc4_ in param2)
         {
            _loc3_[_loc4_] = param2[_loc4_];
         }
         if(typeof param1 == "string")
         {
            if(!(param1 in _labels))
            {
               return null;
            }
            _loc3_.currentTime = getLabelTime(String(param1));
         }
         else
         {
            _loc3_.currentTime = Number(param1);
         }
         this.paused = true;
         return new TweenLite(this,Math.abs(Number(_loc3_.currentTime) - this.cachedTime),_loc3_);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._dispatcher == null ? false : this._dispatcher.hasEventListener(param1);
      }
      
      protected function initDispatcher() : void
      {
         if(this._dispatcher == null)
         {
            this._dispatcher = new EventDispatcher(this);
            if(this.vars.onStartListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.START,this.vars.onStartListener,false,0,true);
            }
            if(this.vars.onUpdateListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.UPDATE,this.vars.onUpdateListener,false,0,true);
               this._hasUpdateListener = true;
            }
            if(this.vars.onCompleteListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.COMPLETE,this.vars.onCompleteListener,false,0,true);
            }
            if(this.vars.onRepeatListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.REPEAT,this.vars.onRepeatListener,false,0,true);
            }
            if(this.vars.onReverseCompleteListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.REVERSE_COMPLETE,this.vars.onReverseCompleteListener,false,0,true);
            }
         }
      }
      
      public function get repeat() : int
      {
         return this._repeat;
      }
      
      public function getLabelBefore(param1:Number = NaN) : String
      {
         if(!param1 && param1 != 0)
         {
            param1 = this.cachedTime;
         }
         var _loc2_:Array = this.getLabelsArray();
         var _loc3_:* = int(_loc2_.length);
         while(_loc3_--)
         {
            if(_loc2_[_loc3_].time < param1)
            {
               return _loc2_[_loc3_].name;
            }
         }
         return null;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._dispatcher == null ? false : this._dispatcher.willTrigger(param1);
      }
      
      public function get totalProgress() : Number
      {
         return this.cachedTotalTime / this.totalDuration;
      }
      
      public function set totalProgress(param1:Number) : void
      {
         setTotalTime(this.totalDuration * param1,false);
      }
      
      protected function getLabelsArray() : Array
      {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         for(_loc2_ in _labels)
         {
            _loc1_[_loc1_.length] = {
               "time":_labels[_loc2_],
               "name":_loc2_
            };
         }
         _loc1_.sortOn("time",Array.NUMERIC);
         return _loc1_;
      }
      
      public function removeCallback(param1:Function, param2:* = null) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Boolean = false;
         var _loc5_:* = 0;
         if(param2 == null)
         {
            return killTweensOf(param1,false);
         }
         if(typeof param2 == "string")
         {
            if(!(param2 in _labels))
            {
               return false;
            }
            param2 = _labels[param2];
         }
         _loc3_ = getTweensOf(param1,false);
         _loc5_ = int(_loc3_.length);
         while(_loc5_--)
         {
            if(_loc3_[_loc5_].cachedStartTime == param2)
            {
               remove(_loc3_[_loc5_] as TweenCore);
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      public function get repeatDelay() : Number
      {
         return this._repeatDelay;
      }
      
      public function set repeat(param1:int) : void
      {
         this._repeat = param1;
         setDirtyCache(true);
      }
      
      override public function get totalDuration() : Number
      {
         var _loc1_:Number = NaN;
         if(this.cacheIsDirty)
         {
            _loc1_ = super.totalDuration;
            this.cachedTotalDuration = this._repeat == -1 ? 999999999999 : this.cachedDuration * (this._repeat + 1) + this._repeatDelay * this._repeat;
         }
         return this.cachedTotalDuration;
      }
      
      override public function complete(param1:Boolean = false, param2:Boolean = false) : void
      {
         super.complete(param1,param2);
         if(Boolean(this._dispatcher) && !param2)
         {
            if(this.cachedReversed && this.cachedTotalTime == 0 && this.cachedDuration != 0)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REVERSE_COMPLETE));
            }
            else
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
            }
         }
      }
      
      override public function invalidate() : void
      {
         this._repeat = int(this.vars.repeat) || 0;
         this._repeatDelay = Number(this.vars.repeatDelay) || 0;
         this.yoyo = Boolean(this.vars.yoyo);
         this._hasUpdateListener = false;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
         {
            this.initDispatcher();
         }
         setDirtyCache(true);
         super.invalidate();
      }
      
      public function getActive(param1:Boolean = true, param2:Boolean = true, param3:Boolean = false) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:Array = getChildren(param1,param2,param3);
         var _loc7_:uint = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            if(TweenCore(_loc5_[_loc6_]).active)
            {
               _loc4_[_loc4_.length] = _loc5_[_loc6_];
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function getLabelAfter(param1:Number = NaN) : String
      {
         if(!param1 && param1 != 0)
         {
            param1 = this.cachedTime;
         }
         var _loc2_:Array = this.getLabelsArray();
         var _loc3_:uint = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].time > param1)
            {
               return _loc2_[_loc4_].name;
            }
            _loc4_++;
         }
         return null;
      }
   }
}

