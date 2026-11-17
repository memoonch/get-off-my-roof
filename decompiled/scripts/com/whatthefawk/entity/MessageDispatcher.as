package com.whatthefawk.entity
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MessageDispatcher implements IMessageDispatcher
   {
      
      private var m_gameWorld:GameWorld;
      
      private var m_currentTime:Date;
      
      private var m_delayedMessageTimer:Timer;
      
      private var m_delayedMessageTickRate:int = 500;
      
      private var m_delayedMessages:Array;
      
      public function MessageDispatcher()
      {
         super();
         this.m_currentTime = new Date();
         this.m_delayedMessages = [];
         this.m_delayedMessageTimer = new Timer(this.m_delayedMessageTickRate);
         this.m_delayedMessageTimer.addEventListener(TimerEvent.TIMER,this.onDispatchDelayedMessages);
      }
      
      private function discharge(param1:String, param2:Telegram) : void
      {
         var _loc3_:IMessageReceiver = this.m_gameWorld.getChildByID(param1);
         if(_loc3_)
         {
            _loc3_.handleMessage(param2);
         }
      }
      
      private function onDispatchDelayedMessages() : void
      {
         var _loc2_:Telegram = null;
         var _loc1_:int = int(this.m_delayedMessages.length);
         while(--_loc1_ > -1)
         {
            _loc2_ = this.m_delayedMessages[_loc1_];
            if(_loc2_.dispatchTime < this.m_currentTime.getTime())
            {
               this.discharge(_loc2_.recieverID,_loc2_);
               this.m_delayedMessages.splice(_loc1_,1);
            }
         }
      }
      
      public function dispatchMessage(param1:int, param2:String, param3:String, param4:String, param5:Object = null) : void
      {
         if(this.m_gameWorld == null)
         {
            throw new Error("<MessageDispatcher> You must set GameWorld through setGameWorld() before using message dispatcher.");
         }
         var _loc6_:Telegram = new Telegram(param1,param2,param3,param4,param5);
         if(param1 < 1)
         {
            this.discharge(param3,_loc6_);
         }
         else
         {
            _loc6_.dispatchTime = this.m_currentTime.getTime() + param1;
            this.m_delayedMessages.push(_loc6_);
         }
      }
      
      public function setGameWorld(param1:GameWorld) : void
      {
         this.m_gameWorld = param1;
      }
   }
}

