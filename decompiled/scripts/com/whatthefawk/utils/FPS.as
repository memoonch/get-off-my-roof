package com.whatthefawk.utils
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class FPS
   {
      
      protected var _max:uint = 0;
      
      protected var _average:uint = 0;
      
      protected var _min:uint = 4294967295;
      
      protected var _last:uint = getTimer();
      
      protected var _ticks:uint = 0;
      
      protected var _current:uint = 0;
      
      protected var _stage:Stage;
      
      public function FPS(param1:Stage)
      {
         super();
         this._stage = param1;
         this._stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
      }
      
      public function dispose() : void
      {
         this._stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._stage = null;
      }
      
      public function get max() : uint
      {
         return this._max;
      }
      
      public function reset() : void
      {
         this._average = 0;
      }
      
      public function get min() : uint
      {
         return this._min;
      }
      
      public function get current() : uint
      {
         return this._current;
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         ++this._ticks;
         var _loc2_:uint = uint(getTimer());
         var _loc3_:uint = _loc2_ - this._last;
         if(_loc3_ >= 1000)
         {
            this._current = this._ticks / _loc3_ * 1000;
            this._min = this._current < this._min ? this._current : this._min;
            this._max = this._current > this._max ? this._current : this._max;
            this._average = this._average > 0 ? uint((this._average + this._current) / 2) : this._current;
            this._ticks = 0;
            this._last = _loc2_;
         }
      }
      
      public function get average() : uint
      {
         return this._average;
      }
   }
}

