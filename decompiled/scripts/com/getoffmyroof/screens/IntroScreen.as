package com.getoffmyroof.screens
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   
   public class IntroScreen extends AScreen
   {
      
      private var m_nextScreen:String = "MainScreen";
      
      private var m_screenManager:ScreenManager;
      
      public function IntroScreen(param1:IScreenItem = null)
      {
         super(param1);
         this.m_screenManager = GameComponents.instance.getScreenManager();
      }
      
      private function onIntroSkip() : void
      {
         this.m_screenManager.setScreen(this.m_nextScreen);
      }
      
      private function onIntroComplete() : void
      {
         this.m_screenManager.setScreen(this.m_nextScreen);
      }
      
      override public function dispose() : void
      {
         this.m_screenManager = null;
         super.dispose();
      }
   }
}

