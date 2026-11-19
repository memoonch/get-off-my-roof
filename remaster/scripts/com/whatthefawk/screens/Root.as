package com.whatthefawk.screens
{
   import com.urbansquall.metronome.Ticker;
   import com.urbansquall.metronome.TickerEvent;
   import com.whatthefawk.utils.Input;
   import com.whatthefawk.utils.KeyCode;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class Root extends AScreen
   {
      
      private static var m_areBreakpointsEnabled:Boolean;
      
      public static var root:Root;
      
      public static var WIDTH:Number;
      
      public static var HEIGHT:Number;
      
      private static var m_isUpdateOn:Boolean;
      
      public static var stage:Stage;
      
      private static var m_gameSpeed:Number = 1;
      
      private const DEFAULT_QUALITY:String = "high";
      
      private const TICK_INTERVAL:int = 33;
      
      private var m_screenToSet:Class;
      
      private var m_ticker:Ticker;
      private var m_fpsCounter:TextField;
      private var m_fpsWindowStart:int;
      private var m_fpsFrames:int = 0;
      
      public function Root(param1:Stage = null)
      {
         super();
         Root.stage = param1;
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      public static function breakpoint(param1:String, param2:Boolean = false) : void
      {
         if(!m_areBreakpointsEnabled && !param2)
         {
            return;
         }
         m_isUpdateOn = false;
      }
      
      public static function isPaused() : Boolean
      {
         return m_isUpdateOn;
      }
      
      public static function togglePause() : void
      {
         m_isUpdateOn = !m_isUpdateOn;
      }
      
      private function onTick(param1:TickerEvent) : void
      {
         if(m_isUpdateOn)
         {
            update(param1.interval * m_gameSpeed);
         }
         this.handleInput();
         Input.instance.update();
         if(this.m_screenToSet)
         {
            super.setScreen(this.m_screenToSet);
            this.m_screenToSet = null;
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         Root.root = this;
         Root.stage = Root.stage == null ? this.stage : Root.stage;
         // Keep simulation, spawning, and original overlay coordinates stable.
         Root.WIDTH = 640;
         Root.HEIGHT = 480;
         Root.stage.quality = this.DEFAULT_QUALITY;
         this.m_fpsCounter = new TextField();
         this.m_fpsCounter.defaultTextFormat = new TextFormat("_sans",12,0xA5F3B4,true);
         this.m_fpsCounter.width = 110;
         this.m_fpsCounter.height = 23;
         this.m_fpsCounter.x = 8;
         this.m_fpsCounter.y = 8;
         this.m_fpsCounter.background = true;
         this.m_fpsCounter.backgroundColor = 0x161B22;
         this.m_fpsCounter.selectable = false;
         this.m_fpsCounter.mouseEnabled = false;
         this.m_fpsCounter.text = "FPS: -- / 30";
         Root.stage.addChild(this.m_fpsCounter);
         this.m_fpsWindowStart = getTimer();
         Root.stage.addEventListener(Event.ENTER_FRAME,this.onFpsFrame,false,0,true);
         m_isUpdateOn = true;
         m_areBreakpointsEnabled = true;
         Input.instance.activate(Root.stage);
         this.onDataLoad(null);
      }

      private function onFpsFrame(param1:Event) : void
      {
         ++this.m_fpsFrames;
         var now:int = getTimer();
         var elapsed:int = now - this.m_fpsWindowStart;
         if(elapsed >= 1000)
         {
            this.m_fpsCounter.text = "FPS: " + (this.m_fpsFrames * 1000 / elapsed).toFixed(1) + " / 30";
            this.m_fpsFrames = 0;
            this.m_fpsWindowStart = now;
         }
         if(Root.stage.getChildIndex(this.m_fpsCounter) != Root.stage.numChildren - 1)
         {
            Root.stage.setChildIndex(this.m_fpsCounter,Root.stage.numChildren - 1);
         }
      }
      
      public function set gameSpeed(param1:Number) : void
      {
         m_gameSpeed = Math.max(param1,0);
      }
      
      private function onDataLoad(param1:Event) : void
      {
         this.m_ticker = new Ticker(this.TICK_INTERVAL);
         this.m_ticker.addEventListener(TickerEvent.TICK,this.onTick);
         this.m_ticker.start();
         Root.stage.showDefaultContextMenu = false;
      }
      
      private function handleInput() : *
      {
         var _loc1_:Input = Input.instance;
         if(_loc1_.isKeyPressed(KeyCode.END))
         {
            m_isUpdateOn = !m_isUpdateOn;
         }
         if(_loc1_.isKeyPressed(KeyCode.PAGE_DOWN))
         {
            if(!m_isUpdateOn)
            {
               update(this.TICK_INTERVAL);
            }
         }
         if(_loc1_.isKeyPressed(KeyCode.PAGE_UP))
         {
            m_areBreakpointsEnabled = !m_areBreakpointsEnabled;
         }
      }
      
      public function get gameSpeed() : Number
      {
         return m_gameSpeed;
      }
      
      override public function setScreen(param1:Class) : void
      {
         this.m_screenToSet = param1;
      }
   }
}

