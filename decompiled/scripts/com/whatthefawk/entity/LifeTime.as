package com.whatthefawk.entity
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class LifeTime extends EventDispatcher
   {
      
      public static const COMPLETE:String = "complete";
      
      protected var _isComplete:Boolean;
      
      protected var _lifeTime:int;
      
      protected var _timePassed:int;
      
      public function LifeTime(param1:int = -1)
      {
         super();
         this._lifeTime = param1;
      }
      
      public function update(param1:int) : void
      {
         if(this._lifeTime == -1)
         {
            return;
         }
         if(this._isComplete)
         {
            return;
         }
         this._timePassed += param1;
         if(this._timePassed > this._lifeTime)
         {
            this._isComplete = true;
            dispatchEvent(new Event(LifeTime.COMPLETE));
         }
      }
      
      public function get isComplete() : Boolean
      {
         return this._isComplete;
      }
      
      public function reset(param1:int = -2) : void
      {
         this._lifeTime = param1 > -2 ? param1 : this._lifeTime;
         this._timePassed = 0;
         this._isComplete = false;
      }
      
      public function get lifeTime() : int
      {
         return this._lifeTime;
      }
      
      public function get timePassed() : int
      {
         return this._timePassed;
      }
   }
}

