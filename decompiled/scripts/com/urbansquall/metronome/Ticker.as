package com.urbansquall.metronome
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   
   public class Ticker extends EventDispatcher
   {
      
      private var m_accruedTime:int;
      
      private var m_running:Boolean;
      
      private var m_shape:Shape;
      
      private var m_delay:int;
      
      private var m_timeOfLastUpdate:int;
      
      public function Ticker(param1:int = 33)
      {
         super();
         this.m_running = false;
         this.m_delay = param1;
         this.m_shape = new Shape();
      }
      
      public function get delay() : int
      {
         return this.m_delay;
      }
      
      public function stop() : void
      {
         this.m_shape.removeEventListener(Event.ENTER_FRAME,this.tick);
         this.m_running = false;
      }
      
      public function start() : void
      {
         this.m_running = true;
         this.m_timeOfLastUpdate = getTimer();
         this.m_accruedTime = 0;
         this.m_shape.addEventListener(Event.ENTER_FRAME,this.tick,false,0,true);
      }
      
      private function tick(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this.m_timeOfLastUpdate;
         this.m_timeOfLastUpdate = _loc2_;
         if(!this.m_running)
         {
            return;
         }
         this.m_accruedTime += _loc3_;
         while(this.m_accruedTime >= this.m_delay)
         {
            this.m_accruedTime -= this.m_delay;
            dispatchEvent(new TickerEvent(this.m_delay));
         }
      }
      
      public function get running() : Boolean
      {
         return this.m_running;
      }
   }
}

