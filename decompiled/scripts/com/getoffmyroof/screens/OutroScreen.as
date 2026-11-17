package com.getoffmyroof.screens
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol464")]
   public class OutroScreen extends AScreen
   {
      
      public var background:MovieClip;
      
      private var m_screenManager:ScreenManager;
      
      public function OutroScreen(param1:IScreenItem = null)
      {
         addFrameScript(689,this.frame690);
         super(param1);
         this.m_screenManager = GameComponents.instance.getScreenManager();
         addEventListener(Event.COMPLETE,this.onOutroComplete,false,0,true);
      }
      
      internal function frame690() : *
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onOutroComplete(param1:Event) : void
      {
         removeEventListener(Event.COMPLETE,this.onOutroComplete);
         this.m_screenManager.setScreen("MainScreen");
      }
      
      override public function dispose() : void
      {
         this.m_screenManager = null;
         super.dispose();
      }
   }
}

