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
      private static const MAX_STEPS_PER_FRAME:int = 5;
      
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
         this.m_timeOfLastUpdate = getTimer() - 60000;
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
         // Do not replay minutes of missed simulation after a stalled/hidden tab.
         // Ordinary frames retain the original fixed 33ms step and remainder.
         if(this.m_accruedTime + _loc3_ > this.m_delay * MAX_STEPS_PER_FRAME)
         {
            trace("Ticker discarded stale catch-up time: " + _loc3_ + "ms");
         }
         this.m_accruedTime = Math.min(this.m_accruedTime + Math.max(0,_loc3_),this.m_delay * MAX_STEPS_PER_FRAME);
         var qaSteps:int = 0;
         while(this.m_accruedTime >= this.m_delay)
         {
            this.m_accruedTime -= this.m_delay;
            ++qaSteps;
            dispatchEvent(new TickerEvent(this.m_delay));
         }
         if(_loc3_ >= 60000){
            trace("Stall QA updates: " + qaSteps);
            var resultText:flash.text.TextField = new flash.text.TextField();
            resultText.defaultTextFormat = new flash.text.TextFormat("_sans",14,0x00FF00,true);
            resultText.width = 330;
            resultText.height = 25;
            resultText.x = 8;
            resultText.y = 34;
            resultText.background = true;
            resultText.backgroundColor = 0x161B22;
            resultText.text = "60s stall: " + qaSteps + " updates (limit 5)";
            com.whatthefawk.screens.Root.stage.addChild(resultText);
         }
      }
      
      public function get running() : Boolean
      {
         return this.m_running;
      }
   }
}

