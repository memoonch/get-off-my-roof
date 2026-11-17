package com.getoffmyroof.points
{
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Points extends EventDispatcher
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_pointLossDelay:int;
      
      private var m_minPoints:int;
      
      private var m_tickRate:int;
      
      private var m_maxPoints:int;
      
      private var m_pointLossPerTick:int;
      
      private var m_points:int;
      
      public function Points(param1:PointsParams)
      {
         super();
         this.m_maxPoints = param1.maxPoints;
         this.m_minPoints = param1.minPoints;
         this.m_points = param1.points != -1 ? param1.points : this.m_maxPoints;
         this.m_pointLossPerTick = param1.pointLossPerTick;
         this.m_pointLossDelay = param1.pointLossDelay;
         this.m_tickRate = param1.tickRate;
         if(this.m_tickRate > 0)
         {
            this.m_tickRegulator = new TickRegulator(this.m_tickRate);
            this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTick,false,0,true);
         }
      }
      
      public function update(param1:int) : void
      {
         this.m_pointLossDelay -= param1;
         if(this.m_pointLossDelay <= 0 && this.m_tickRate > 0)
         {
            this.m_tickRegulator.update(param1);
         }
      }
      
      public function onTick(param1:Event) : void
      {
         this.m_points -= this.m_pointLossPerTick;
         if(this.m_points < this.m_minPoints)
         {
            this.m_points = this.m_minPoints;
         }
      }
      
      public function get points() : int
      {
         return this.m_points;
      }
      
      public function dispose() : void
      {
         this.m_tickRegulator = null;
         this.m_tickRegulator.removeEventListener(TickRegulator.TICK,this.onTick);
      }
   }
}

