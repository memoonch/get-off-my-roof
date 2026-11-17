package com.whatthefawk.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class TickRegulator extends EventDispatcher
   {
      
      public static const TICK:String = "tick";
      
      private var m_rate:int;
      
      private const TICK_INTERVAL:int = 33;
      
      private var m_randTime:int;
      
      private var m_time:int;
      
      public function TickRegulator(param1:int = 1000, param2:* = 0)
      {
         super();
         this.m_rate = param1;
         this.m_time = 0;
         this.m_randTime = param2;
      }
      
      public function update(param1:int = 33) : void
      {
         this.m_time += param1;
         if(this.m_time > this.m_rate)
         {
            this.m_time -= this.m_rate;
            if(this.m_randTime)
            {
               this.m_time -= Math.random() * this.m_randTime;
            }
            dispatchEvent(new Event(TickRegulator.TICK));
         }
      }
   }
}

